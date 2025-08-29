//
//  NetworkError.swift
//  NewYorkTimesApp
//
//  Created by Rayan Taj on 29/08/2025.
//

import Foundation
import Moya

enum NetworkError: Error, LocalizedError {
    case http(status: Int, data: Data)
    case decoding(Error)
    case moya(MoyaError)

    var errorDescription: String? {
        switch self {
        case .http(let status, _): return "HTTP error: \(status)"
        case .decoding(let err):  return "Decoding error: \(err.localizedDescription)"
        case .moya(let err):      return "Network error: \(err.localizedDescription)"
        }
    }
}
