//
//  AppCoordinator.swift
//  TaskNest
//
//  Created by Tung Le on 9/6/2025.
//

import SwiftUI

@Observable
final class AppCoordinator {
  var path = [AppRoute]()
  
  func navigate(to route: AppRoute) {
    path.append(route)
  }
  
  func goBack() {
    path.removeLast()
  }
  
  func goToRootScreen() {
    path = []
  }
  
} // 🧱
