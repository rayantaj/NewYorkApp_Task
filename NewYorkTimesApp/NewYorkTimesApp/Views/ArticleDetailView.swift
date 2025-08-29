//
//  ArticleDetailView.swift
//  NewYorkTimesApp
//
//  Created by Rayan Taj on 29/08/2025.
//
import SwiftUI

struct ArticleDetailView: View {
    let article: Article

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                if let url = article.thumbURL {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty: ProgressView().frame(maxWidth: .infinity)
                        case .success(let image): image.resizable().scaledToFill()
                        case .failure: Color.gray.opacity(0.15)
                        @unknown default: Color.gray.opacity(0.15)
                        }
                    }
                    .frame(height: 200)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }

                Text(article.title)
                    .font(.title2).bold()

                if !article.byline.isEmpty {
                    Text(article.byline)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                if let date = article.publishedDate {
                    Text("Published: \(date.formatted(date: .abbreviated, time: .omitted))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                if !article.abstract.isEmpty {
                    Text(article.abstract)
                        .font(.body)
                        .padding(.top, 4)
                }

                // Open in Safari directly as a link
                Link("Open on nytimes.com", destination: article.url)
                    .font(.body.weight(.semibold))
                    .padding(.top, 8)
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
