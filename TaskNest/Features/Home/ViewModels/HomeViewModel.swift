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
  private let appCoordinator: AppCoordinator
  
  var state: HomeViewUIState { homeViewState }
  
  
  // MARK: - Dependencies
  private let authUseCase: AuthUseCase
  
  // MARK: - INIT
  init(authManager: AuthManager, authUseCase: AuthUseCase, appCoordinator: AppCoordinator) {
    self.authManager = authManager
    self.authUseCase = authUseCase
    self.appCoordinator = appCoordinator
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
    authUseCase.logout { result in
      switch result {
      case .success:
        Task { @MainActor [weak self] in
          self?.authManager.authState = .unauthenticated
        }
        
        Logger.d(tag: "Logout", message: "Inside HomeViewModel - logout")
        Logger.d(tag: "Logout", message: "Successful Logout - Session cookies cleared")
        
      case .failure(let error):
        let appError = error as? AppError
        
        Logger.d(tag: "Logout", message: "Inside HomeViewModel - logout")
        Logger.e(tag: "Logout", message: "unuccessful Logout", error: appError)
      }
    }
  }
}
