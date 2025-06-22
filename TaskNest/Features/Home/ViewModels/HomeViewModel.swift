//
//  HomeViewModel.swift
//  TaskNest
//
//  Created by Tung Le on 22/6/2025.
//

import SwiftUI

// MARK: - Binding
extension HomeViewModel {
  var showSettingsBinding: Binding<Bool> {
    Binding (
      get: { self.homeViewState.showSetting },
      set: { self.homeViewState.showSetting = $0 }
    )
  }
}



@Observable
final class HomeViewModel {
  // MARK: - States
  private var homeViewState = HomeViewUIState()
  private let authManager: AuthManager
  
  var state: HomeViewUIState { homeViewState }
  
  
  // MARK: - Dependencies
  private let authUseCase: AuthUseCase
  
  // MARK: - INIT
  init(authManager: AuthManager, authUseCase: AuthUseCase) {
    self.authManager = authManager
    self.authUseCase = authUseCase
  }  
  
  // ✅
  func openSettings() {
    homeViewState.showSetting = true
    Logger.d(tag: "Settings", message: "Inside HomeViewModel - opensettings")
    Logger.d(tag: "Settings", message: "Show setting: \(homeViewState.showSetting)")
  }
  
  // ✅
  func closeSettings() {
    homeViewState.showSetting = false
  }
  
  // ✅
  func logout() {
    authUseCase.logout()
    Task { @MainActor in
      authManager.authState = .unauthenticated
    }
  }
}
