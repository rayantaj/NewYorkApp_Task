//
//  Article.swift
//  NewYorkTimesApp
//
//  Created by Rayan Taj on 29/08/2025.
//
import Foundation

struct Article: Decodable, Identifiable, Equatable {
 
    let id: Int64
    let url: URL // article url
    let title: String // article title
    let byline: String // article author
    let abstract: String // article brief for showdown
    let publishedDate: Date? // article publishing date
    let thumbURL: URL?

    private enum CodingKeys: String, CodingKey {
        case id, url, title, byline, abstract
        case publishedDate = "published_date"
        case media
    }

    private struct Media: Decodable {
        let mediaMetadata: [MediaMeta]

        private enum CodingKeys: String, CodingKey {
            case mediaMetadata = "media-metadata"
        }
    }

    private struct MediaMeta: Decodable {
        let url: URL
        let format: String
        let height: Int
        let width: Int
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decode(Int64.self, forKey: .id)
        url = try c.decode(URL.self, forKey: .url)
        title = try c.decode(String.self, forKey: .title)
        byline = (try? c.decode(String.self, forKey: .byline)) ?? ""
        abstract = (try? c.decode(String.self, forKey: .abstract)) ?? ""

        // date format "yyyy-MM-dd"
        if let dateString = try? c.decode(String.self, forKey: .publishedDate) {
            let df = DateFormatter()
            df.calendar = Calendar(identifier: .gregorian)
            df.locale = Locale(identifier: "en_US_POSIX")
            df.dateFormat = "yyyy-MM-dd"
            publishedDate = df.date(from: dateString)
        } else {
            publishedDate = nil
        }

        // parse thumbnail
        if let media = try? c.decode([Media].self, forKey: .media),
           let meta = media.first?.mediaMetadata.first {
            thumbURL = meta.url
        } else {
            thumbURL = nil
        }
    }
}
