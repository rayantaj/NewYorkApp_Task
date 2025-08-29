//
//  ArticleDecodingTests.swift
//  NewYorkTimesApp
//
//  Created by Rayan Taj on 29/08/2025.
//


// Tests/ArticleDecodingTests.swift
import XCTest
@testable import NewYorkTimesApp

final class ArticleDecodingTests: XCTestCase {

    func testDecodeArticle_success() throws {
        let data = """
        {
          "id": 123456789,
          "url": "https://nytimes.com/2024/01/02/example.html",
          "title": "Sample Title",
          "byline": "By Rayan Taj",
          "abstract": "This is a abstartct test case in this task",
          "published_date": "2024-01-02",
          "media": [
            { "media-metadata": [
                { "url": "https://static01.nyt.com/images/thumb.jpg", "format": "Standard Thumbnail", "height": 75, "width": 75 }
              ]
            }
          ]
        }
        """.data(using: .utf8)!

        let article = try JSONDecoder().decode(Article.self, from: data)
        XCTAssertEqual(article.id, 123456789)
        XCTAssertEqual(article.title, "Sample Title")
        XCTAssertNotNil(article.publishedDate)
        XCTAssertNotNil(article.thumbURL)
    }

    func testDecodeArticle_missingOptionals() throws {
        let data = """
        {
          "id": 1,
          "url": "https://nytimes.com/a",
          "title": "Test",
          "published_date": "2024-02-10"
        }
        """.data(using: .utf8)!

        let article = try JSONDecoder().decode(Article.self, from: data)
        XCTAssertEqual(article.byline, "")
        XCTAssertEqual(article.abstract, "")
        XCTAssertNil(article.thumbURL)
        XCTAssertNotNil(article.publishedDate)
    }

    func testDecodeArticle_badDate_gracefulNil() throws {
        let data = """
        {
          "id": 2,
          "url": "https://nytimes.com/b",
          "title": "Test 2",
          "published_date": "02-10-2024"
        }
        """.data(using: .utf8)!

        let article = try JSONDecoder().decode(Article.self, from: data)
        XCTAssertNil(article.publishedDate)
    }
}
