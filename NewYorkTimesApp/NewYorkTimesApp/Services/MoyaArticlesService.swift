//
//  MoyaArticlesService.swift
//  NewYorkTimesApp
//
//  Created by Rayan Taj on 29/08/2025.
//
import Foundation
import Moya
import Combine
import CombineMoya

protocol ArticlesService {
    func mostViewed(period: NYTTarget.Period) -> AnyPublisher<[Article], Error>
}

final class MoyaArticlesService: ArticlesService {
    private let provider: MoyaProvider<NYTTarget>
    private let decoder: JSONDecoder

    init(provider: MoyaProvider<NYTTarget>? = nil) {
        let plugins: [PluginType] = [
            NetworkLoggerPlugin(configuration: .init(logOptions: .formatRequestAscURL))
        ]
        self.provider = provider ?? MoyaProvider<NYTTarget>(plugins: plugins)
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder = d
    }

    func mostViewed(period: NYTTarget.Period) -> AnyPublisher<[Article], Error> {
        provider.requestPublisher(.mostViewed(period: period))
            .filterSuccessfulStatusCodes() // throws on 404/500
            .map(MostViewedResponse.self, using: decoder)
            .map(\.results)
            .mapError { error -> Error in
                if let moya = error as? MoyaError {
                    switch moya {
                    case .statusCode(let resp): return NetworkError.http(status: resp.statusCode, data: resp.data)
                    default: return NetworkError.moya(moya)
                    }
                } else if error is DecodingError {
                    return NetworkError.decoding(error)
                }
                return error
            }
            .eraseToAnyPublisher()
    }
}
