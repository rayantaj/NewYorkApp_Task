//
//  ThumbView.swift
//  NewYorkTimesApp
//
//  Created by Rayan Taj on 29/08/2025.
//
import Foundation
import SwiftUI

public struct ThumbView: View {
    let url: URL?
    public var body: some View {
        if let url {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty: ProgressView()
                case .success(let image): image.resizable().scaledToFill()
                case .failure: placeholder
                @unknown default: placeholder
                }
            }
        } else {
            placeholder
        }
    }
    private var placeholder: some View {
        ZStack {
            Color.gray.opacity(0.15)
            Image(systemName: "photo")
                .imageScale(.large)
                .foregroundStyle(.secondary)
        }
    }
}
