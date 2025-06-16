//
//  TaskNestApp.swift
//  TaskNest
//
//  Created by Tung Le on 8/6/2025.
//

import SwiftUI

@main
struct TaskNestApp: App {
  let container = AppDIContainer.shared.container
  
  var body: some Scene {
    WindowGroup {
      RoorAppView()
    }
  }
  
} // 🧱
