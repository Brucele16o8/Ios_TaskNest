//
//  LoadingViewModel.swift
//  TaskNest
//
//  Created by Tung Le on 16/6/2025.
//

import SwiftUI

@MainActor
final class LoadingViewModel: ObservableObject {
  @Published var showText = false
  
  func startAnimation() {
    Task {
      try? await Task.sleep(nanoseconds: 300_000_000)
      withAnimation(.easeOut(duration: 1)) {
        showText = true
      }
    }
  }
}

