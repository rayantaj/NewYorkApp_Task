//
//  ArticlesViewModel.swift
//  NewYorkTimesApp
//
//  Created by Rayan Taj on 29/08/2025.
//
import Foundation
import Combine

@MainActor
final class ArticlesViewModel: ObservableObject {
    @Published private(set) var articles: [Article] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let service: ArticlesService
    private var bag = Set<AnyCancellable>()

    init(service: ArticlesService = MoyaArticlesService()) {
        self.service = service
    }

    func load(period: NYTTarget.Period = .seven) {
        isLoading = true
        errorMessage = nil
        articles.removeAll()
        service.mostViewed(period: period)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] articles in
                self?.articles = articles
            }
            .store(in: &bag)
    }
}


