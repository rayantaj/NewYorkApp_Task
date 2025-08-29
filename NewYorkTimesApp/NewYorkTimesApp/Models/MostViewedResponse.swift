//
//  MostViewedResponse.swift
//  NewYorkTimesApp
//
//  Created by Rayan Taj on 29/08/2025.
//


import Foundation

struct MostViewedResponse: Decodable {
    let status: String
    let results: [Article] // list of articles 
}

// SAMPLE DATA
//        """
//        {
//          "status": "OK",
//          "results": [
//            {
//              "id": 1234567890,
//              "url": "https://nytimes.com/example",
//              "title": "Sample Title",
//              "byline": "By John Doe",
//              "abstract": "Abstract…",
//              "published_date": "2024-01-02",
//              "media": [{
//                "media-metadata": [{
//                  "url": "https://static01.nyt.com/images/…/thumb.jpg",
//                  "format": "Standard Thumbnail",
//                  "height": 75,
//                  "width": 75
//                }]
//              }]
//            }
//          ]
//        }
//        """
