//
//  ArticleRowView.swift
//  NewYorkTimesApp
//
//  Created by Rayan Taj on 29/08/2025.
//
import Foundation
import SwiftUI

public struct ArticleRowView: View {
    let article: Article

    public var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ThumbView(url: article.thumbURL)
                .frame(width: 64, height: 64)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.quaternary, lineWidth: 0.5))

            VStack(alignment: .leading, spacing: 6) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(2)

                if !article.byline.isEmpty {
                    Text(article.byline)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                if let date = article.publishedDate {
                    Text(date, style: .date)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
        }
        .padding(.vertical, 6)
    }
}
