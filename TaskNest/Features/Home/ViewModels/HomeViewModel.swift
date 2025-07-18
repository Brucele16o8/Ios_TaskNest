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
  var uiState: HomeViewUIState { homeViewState }
  private let authManager: AuthManager
  private let appCoordinator: AppCoordinator
  
  // MARK: - Dependencies
  private let authUseCase: AuthUseCase
  private let getAllCategoriesUseCase: GetAllCategoryEntitiesUseCase
  private let deleteCategoryUseCase: DeleteCategoryEntityUseCase
  private let saveCategoryUseCase: SaveCategoryEntityUseCase
  
  // MARK: - INIT
  init(
    authManager: AuthManager,
    authUseCase: AuthUseCase,
    appCoordinator: AppCoordinator,
    getAllCategoriesUseCase: GetAllCategoryEntitiesUseCase,
    deleteCategoryUseCase: DeleteCategoryEntityUseCase,
    saveCategoryUseCase: SaveCategoryEntityUseCase
  ) {
    self.authManager = authManager
    self.authUseCase = authUseCase
    self.appCoordinator = appCoordinator
    self.getAllCategoriesUseCase = getAllCategoriesUseCase
    self.deleteCategoryUseCase = deleteCategoryUseCase
    self.saveCategoryUseCase = saveCategoryUseCase
    Task { await setupDefaultCategoriesIfNeeded() }
  }
  
  // ✅
  func startLoading() async {
    homeViewState.isLoading = true
    do {
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
  
  // ✅ Seeding logic
  private func setupDefaultCategoriesIfNeeded() async {
    Logger.d(tag: "HomeViewModel", message: "Inside setupDefaultCategoriesIfNeeded")
    guard let userId = authManager.currentUser?.id else { return }
    
    let loadedCategories = (try? await getAllCategoriesUseCase()) ?? []
    if !loadedCategories.isEmpty {
      homeViewState = homeViewState.copy(
        isLoading: false,
        categories: loadedCategories.map( \.mapToCategotyItem )
      )
      return
    } else {
      let defaultNames = ["Personal", "Work", "Study", "Shopping"]
      for name in defaultNames {
        let categoryEntity = CategoryEntity(id: UUID(), title: name, userId: userId)
        do {
          try await saveCategoryUseCase(categoryEntity)
        } catch let appError as AppError {
          homeViewState.errorMessage = appError.localizedDescription
        } catch {
          homeViewState.errorMessage = "Failed to create default category"
        }
      }
    }
    await loadCategories()
  }
  
  // ✅ - Update properties
  func updateSearchText(_ searchText: String) {
    homeViewState.searchText = searchText
  }
  
  func updateShowSetting(_ showSetting: Bool) {
    homeViewState.showSetting = showSetting
  }
  
  func updateShowAddCategory(_ showAddCategory: Bool) {
    homeViewState.showAddCategory = showAddCategory
  }
  
  func updateUiErrorMessage(_ errorMessage: String) {
    homeViewState.errorMessage = errorMessage
  }
  
  // MARK: - CATEGORY manipulation
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
  func createAndSaveCategory(from title: String) async {
    Logger.d(tag: "SaveCategory", message: "Inside createAndSaveCategory - HomeViewModel")
    guard !title.isEmpty else {
      homeViewState.errorMessage = "Category name cannot be empty."
      return
    }
    guard let userId = authManager.currentUser?.id else {
      homeViewState.errorMessage = "Cannot get current user id"
      return
    }
    
    let newCategory = CategoryItem(title: title, userId: userId)
    
    do {
      Logger.d(tag: "SaveCategory", message: "Before save use case - AddCategoryViewModel")
      try await saveCategoryUseCase(newCategory.mapToEntity)
      Logger.d(tag: "SaveCategory", message: "After save use case - AddCategoryViewModel")
    } catch let appError as AppError {
      homeViewState.errorMessage = appError.localizedDescription
    } catch {
      homeViewState.errorMessage = "Something went wrong while adding the category."
    }
    await startLoading()
  }
  
  func goBack() {
    appCoordinator.goBack()
  }
  
  // ✅ Load categories into UiState
  private func loadCategories() async {
    guard let userId = authManager.currentUser?.id else { return } /// leave the error here to correct fetching based on user id later
    homeViewState.isLoading = true
    do {
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
  func logout() async {
    do {
      try await authManager.logout()
//      authManager.clearCredentials()
      homeViewState = HomeViewUIState()
      Logger.d(tag: "HomeViewModel", message: "Logged out successfully")
      appCoordinator.logOut()
      Logger.d(tag: "HomeViewModel", message: "Navigated to LogIn")
    } catch let appError as AppError {
      homeViewState.errorMessage = appError.localizedDescription
    } catch {
      homeViewState.errorMessage = "Failed to Log Out"
    }
  }
  
  // ✅ - Nvaigation
  func navigateToCategoryDetailView(for categoryItem: CategoryItem) {
    Logger.d(tag: "HomeViewModel", message: "Inside navigateToCategoryDetailView")
    appCoordinator.navigate(to: .category(categoryItem: categoryItem))
  }
  
} // 🧱
