//
//  NavigationState.swift
//  TaskNest
//
//  Created by Tung Le on 9/6/2025.
//

import SwiftUI

final class NavigationState: ObservableObject {
  @Published var isLoginnedIn = false
  @Published var homePath = NavigationPath()
  
  func resetAll() {
    homePath = NavigationPath()
  }
  
  func navigateToHomeAndPush(to route: AppRoute) {
    
  }
  
}
