//
//  HomeViewModel.swift
//  TaskNest
//
//  Created by Tung Le on 22/6/2025.
//

import SwiftUI

@MainActor
@Observable
final class HomeViewModel {
  // MARK: - States
  private(set) var homeViewState = HomeViewUIState()
  private let authManager: AuthManager
  private let appCoordinator: AppCoordinator  
  
  // MARK: - Dependencies
  private let authUseCase: AuthUseCase
  private let getAllCategoriesUseCase: GetAllCategoryEntitiesUseCase
  private let deleteCategoryUseCase: DeleteCategoryEntityUseCase
  
  // MARK: - INIT
  init(
    authManager: AuthManager,
    authUseCase: AuthUseCase,
    appCoordinator: AppCoordinator,
    getAllCategoriesUseCase: GetAllCategoryEntitiesUseCase,
    deleteCategoryUseCase: DeleteCategoryEntityUseCase
  ) {
    self.authManager = authManager
    self.authUseCase = authUseCase
    self.appCoordinator = appCoordinator
    self.getAllCategoriesUseCase = getAllCategoriesUseCase
    self.deleteCategoryUseCase = deleteCategoryUseCase
  }
  
  // ✅
  func startLoading() async {
    homeViewState.isLoading = true
    do {
      let user = try await authUseCase.getUserInfo(acceessToken: authManager.authToken)
      authManager.storeAuthenticatedUser(user)
      
      let categoryEntities = try await getAllCategoriesUseCase()
      let categoryItems = categoryEntities.map { $0.mapToCategotyItem }
      homeViewState = homeViewState.copy(
        isLoading: false,
        categories: categoryItems
      )
    } catch let appError as AppError {
      homeViewState.errorMessage = appError.localizedDescription
    } catch {
      homeViewState.errorMessage = "Failed to loading data from Database"
    }
  }
  
  // ✅
  func updateSearchText(_ searchText: String) {
    homeViewState.searchText = searchText
  }
  
  // ✅
  func updateShowSetting(_ showSetting: Bool) {
    homeViewState.showSetting = showSetting
  }
  
  // ✅  haven't finished
  func deleteCategory(ofId categoryId: UUID) async {
    do {
      try await deleteCategoryUseCase(id: categoryId)
    } catch let appError as AppError {
      homeViewState.errorMessage = appError.localizedDescription
    } catch {
      homeViewState.errorMessage = "Failed to delete category"
    }
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
