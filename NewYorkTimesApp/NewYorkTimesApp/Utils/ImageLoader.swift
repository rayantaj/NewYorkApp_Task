//
//  ImageLoader.swift
//  NewYorkTimesApp
//
//  Created by Rayan Taj on 29/08/2025.
//


import Foundation
import UIKit
import Combine

final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var bag = Set<AnyCancellable>()

    func load(from url: URL?) {
        guard let url else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .compactMap { UIImage(data: $0) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
            .store(in: &bag)
    }
}