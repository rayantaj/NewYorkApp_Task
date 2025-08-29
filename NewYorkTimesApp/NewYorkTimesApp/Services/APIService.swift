//
//  APIService.swift
//  NewYorkTimesApp
//
//  Created by Rayan Taj on 29/08/2025.
//

import Foundation
import Moya

enum NYTTarget {
    case mostViewed(period: Period)

    enum Period: Int {
        case one = 1
        case seven = 7
        case thirty = 30
        case foutry = 40 // to show error only, NYT supports 1,7, and 30 only in this API.
    }
}

extension NYTTarget: TargetType {
    var baseURL: URL {
        URL(string: "https://api.nytimes.com/svc/mostpopular/v2")!
    }

    var path: String {
        switch self {
        case .mostViewed(let period):
            return "viewed/\(period.rawValue).json"
        }
    }

    var method: Moya.Method {
        .get
    }

    var task: Task {
      
        let params: [String: Any] = [
            "api-key": NYTAPIKeyStorage.shared.apiKey
        ]
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }

    var headers: [String : String]? {
        ["Accept": "application/json"]
    }
}
