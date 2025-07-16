//
//  CategoryDetailViewModel.swift
//  TaskNest
//
//  Created by Tung Le on 14/7/2025.
//

import SwiftUI

@MainActor
@Observable
class CategoryDetailViewModel: ObservableObject {
  let categoryItem: CategoryItem
  
  // State
  private(set) var categoryDetailUiState: CategoryDetailUiState = .init()
  var state: CategoryDetailUiState { categoryDetailUiState }
  
  // TaskItem view models
  private var taskItemViewModels: [TaskItemViewModel] = []
  
  // Use cases
  private var getTaskItemEntitiesByCategoryEntityUseCase: GetTaskItemEntitiesByCategoryEntityUseCase!
  
  
  init(categoryItem: CategoryItem, getTaskItemEntitiesByCategoryEntityUseCase: GetTaskItemEntitiesByCategoryEntityUseCase) {
    self.categoryItem = categoryItem
    self.getTaskItemEntitiesByCategoryEntityUseCase = getTaskItemEntitiesByCategoryEntityUseCase
  }
  
  
  // ✅ Call when view show up
  func start() async {
    categoryDetailUiState.isLoading = true
    do {
      categoryDetailUiState.taskItems = try await getTaskItemEntitiesByCategoryEntityUseCase.callAsFunction(categoryEntityId: categoryItem.id)
        .map { $0.maptoTaskItemItem }
        .sorted { $0.createdAt > $1.createdAt}
      
      taskItemViewModels = categoryDetailUiState.taskItems
        .map {
          TaskItemViewModel(taskItem: $0)
        }
      
    } catch let appError as AppError {
      categoryDetailUiState.errorMessage = appError.localizedDescription
    } catch {
      categoryDetailUiState.errorMessage = "Error when fetching task items"
    }
  }
  
  
  
} // 🧱
