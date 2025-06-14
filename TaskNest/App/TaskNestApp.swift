//
//  TaskNestApp.swift
//  TaskNest
//
//  Created by Tung Le on 8/6/2025.
//

import SwiftUI

@main
struct TaskNestApp: App {
  @Environment(\.resolver) private var resolver
  
  var body: some Scene {
    WindowGroup {
      LoginView(viewModel: resolver.resolve(LoginViewModel.self)!)
    }
  }
  
} // 🧱
