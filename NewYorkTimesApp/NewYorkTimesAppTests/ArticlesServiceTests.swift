//
//  ArticlesServiceTests.swift
//  NewYorkTimesApp
//
//  Created by Rayan Taj on 29/08/2025.
//


// Tests/ArticlesServiceTests.swift
import XCTest
import Combine
import Moya
import CombineMoya
@testable import NewYorkTimesApp

final class ArticlesServiceTests: XCTestCase {
    private var bag = Set<AnyCancellable>()

    private func providerReturning(status: Int, body: Data) -> MoyaProvider<NYTTarget> {
        let endpointClosure: (NYTTarget) -> Endpoint = { target in
            let url = target.baseURL.appendingPathComponent(target.path).absoluteString
            return Endpoint(
                url: url,
                sampleResponseClosure: { .networkResponse(status, body) },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
        }
        return MoyaProvider<NYTTarget>(endpointClosure: endpointClosure,
                                       stubClosure: MoyaProvider.immediatelyStub)
    }

    func testMostViewed_success() {
        let okBody = """
        {"status":"OK","results":[{"id":100,"url":"https://nytimes.com/x","title":"OK Title","byline":"By Test","abstract":"A","published_date":"2024-01-01","media":[{"media-metadata":[{"url":"https://static01.nyt.com/images/t.jpg","format":"Standard Thumbnail","height":75,"width":75}]}]}]}
        """.data(using: .utf8)!

        let provider = providerReturning(status: 200, body: okBody)
        let service = MoyaArticlesService(provider: provider)

        let exp = expectation(description: "Decodes OK")
        service.mostViewed(period: .seven)
            .sink { completion in
                if case .failure(let error) = completion { XCTFail("Unexpected error: \(error)") }
            } receiveValue: { articles in
                XCTAssertEqual(articles.count, 1)
                XCTAssertEqual(articles.first?.id, 100)
                exp.fulfill()
            }
            .store(in: &bag)

        wait(for: [exp], timeout: 1)
    }

    func testMostViewed_404MapsToNetworkErrorHttp() {
        let provider = providerReturning(status: 404, body: Data("Not Found".utf8))
        let service = MoyaArticlesService(provider: provider)

        let exp = expectation(description: "Maps 404")
        service.mostViewed(period: .one)
            .sink { completion in
                if case .failure(let error) = completion {
                    if case NetworkError.http(let code, _) = error {
                        XCTAssertEqual(code, 404)
                        exp.fulfill()
                        return
                    }
                    XCTFail("Expected NetworkError.http, got \(error)")
                } else {
                    XCTFail("Expected failure")
                }
            } receiveValue: { _ in
                XCTFail("Should not succeed on 404")
            }
            .store(in: &bag)

        wait(for: [exp], timeout: 1)
    }

    
}
