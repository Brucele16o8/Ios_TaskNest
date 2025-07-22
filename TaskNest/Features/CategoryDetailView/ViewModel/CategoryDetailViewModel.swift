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
  private(set) var taskItemViewModels: [TaskItemRowViewModel] = []
  
  // Use cases
  private let appCoordinator: AppCoordinator
  private let getTaskItemEntitiesByCategoryEntityUseCase: GetTaskItemEntitiesByCategoryEntityUseCase!
  
  private let updateTaskItemEntityUseCase: UpdateTaskItemEntityUseCase
  private let deleteTaskItemEntityUseCase: DeleteTaskItemEntityUseCase
  
  init(categoryItem: CategoryItem,
       appCoordinator: AppCoordinator,
       getTaskItemEntitiesByCategoryEntityUseCase: GetTaskItemEntitiesByCategoryEntityUseCase,
       updateTaskItemEntityUseCase: UpdateTaskItemEntityUseCase,
       deleteTaskItemEntityUseCase: DeleteTaskItemEntityUseCase
       
  ) {
    self.categoryItem = categoryItem
    self.appCoordinator = appCoordinator
    self.getTaskItemEntitiesByCategoryEntityUseCase = getTaskItemEntitiesByCategoryEntityUseCase
    self.updateTaskItemEntityUseCase = updateTaskItemEntityUseCase
    self.deleteTaskItemEntityUseCase = deleteTaskItemEntityUseCase
  }
  
  
  // ✅ Call when view show up
  func start() async {
    categoryDetailUiState.isLoading = true
    do {
      categoryDetailUiState.taskItems = try await getTaskItemEntitiesByCategoryEntityUseCase.callAsFunction(categoryEntityId: categoryItem.id)
        .map { $0.maptoTaskItemItem }
        .sorted { $0.createdAt > $1.createdAt }
      
      taskItemViewModels = categoryDetailUiState.taskItems
        .map {
          TaskItemRowViewModel(
            taskItem: $0,
            onDelete: { id in
              try await self.deleteTaskItemEntityUseCase(id: id)
              await self.start()
            },
            onUpdate: { taskItemEntity in
              try await self.updateTaskItemEntityUseCase(taskItemEntity: taskItemEntity)
              await self.start()
            },
            onCliked: { taskItem in
              self.appCoordinator.navigate(to: AppRoute.taskDetail(taskItem: taskItem))
            }
          )
        }
      
    } catch let appError as AppError {
      categoryDetailUiState.errorMessage = appError.localizedDescription
    } catch {
      categoryDetailUiState.errorMessage = "Error when fetching task items"
    }
  }
  
  // ✅ - Go back to previous screen
  func goBack() {
    appCoordinator.goBack()
  }
  
} // 🧱
