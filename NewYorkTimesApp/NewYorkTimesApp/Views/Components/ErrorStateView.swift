//
//  ErrorStateView.swift
//  NewYorkTimesApp
//
//  Created by Rayan Taj on 29/08/2025.
//
import Foundation
import SwiftUI

public struct ErrorStateView: View {
    let message: String
    let retry: () -> Void
    public var body: some View {
        VStack(spacing: 12) {
            Text("Something went wrong").font(.headline)
            Text(message).font(.subheadline).multilineTextAlignment(.center).foregroundStyle(.secondary)
            Button("Retry", action: retry)
        }
        .padding()
    }
}
