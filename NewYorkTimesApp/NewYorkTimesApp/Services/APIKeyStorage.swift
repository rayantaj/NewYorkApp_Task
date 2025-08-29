//
//  APIKeyStorage.swift
//  NewYorkTimesApp
//
//  Created by Rayan Taj on 29/08/2025.
//
import Foundation

// This class is used for getting APIs keys from Info.plist
final class NYTAPIKeyStorage {
    static let shared = NYTAPIKeyStorage()

    /// API Key is stored in Info.plist under the name "NYT_API_KEY_TEST", we have only this one in this task.
    var apiKey: String {
        Bundle.main.object(forInfoDictionaryKey: "NYT_API_KEY_TEST") as? String ?? ""
    }
}
