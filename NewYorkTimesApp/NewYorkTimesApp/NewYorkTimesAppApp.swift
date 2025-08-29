//
//  NewYorkTimesAppApp.swift
//  NewYorkTimesApp
//
//  Created by Rayan Taj on 29/08/2025.
//

import SwiftUI

@main
struct NewYorkTimesAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ArticlesListView(viewModel: ArticlesViewModel())
        }
    }
}
