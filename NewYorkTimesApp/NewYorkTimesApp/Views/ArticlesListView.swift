//
//  ArticlesListView.swift
//  NewYorkTimesApp
//
//  Created by Rayan Taj on 29/08/2025.
//

import Foundation
import SwiftUI

struct ArticlesListView: View {
    @StateObject var viewModel: ArticlesViewModel
    @State private var selectedPeriod: NYTTarget.Period = .one

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.articles.isEmpty {
                    ProgressView("Loading…").padding(.top, 24)
                } else if let msg = viewModel.errorMessage {
                    ErrorStateView(message: msg) { viewModel.load(period: selectedPeriod) }
                } else {
                    List(viewModel.articles) { article in
                        NavigationLink {
                            ArticleDetailView(article: article)
                        } label: {
                            ArticleRowView(article: article)
                        }
                    }
                    .listStyle(.plain)
                    .refreshable {
                        viewModel.load(period: selectedPeriod)
                    }
                }
            }
            .navigationTitle("Most Viewed")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    PeriodPicker(selected: $selectedPeriod)
                        .onChange(of: selectedPeriod) { _, newValue in
                            viewModel.load(period: newValue)
                        }
                }
            }
        }
        .task {
            // initial load
            if viewModel.articles.isEmpty { viewModel.load(period: selectedPeriod) }
        }
    }
}

private struct PeriodPicker: View {
    @Binding var selected: NYTTarget.Period
    var body: some View {
        Picker("", selection: $selected) {
            Text("1d").tag(NYTTarget.Period.one)
            Text("7d").tag(NYTTarget.Period.seven)
            Text("30d").tag(NYTTarget.Period.thirty)
            Text("40d").tag(NYTTarget.Period.foutry) // will show error ALWAYS since NYT does not support 40 days.
        }
        .pickerStyle(.segmented)
        .frame(maxWidth: 220)
    }
}
