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
  private let authManager: AuthManager
  private let getTaskItemEntitiesByCategoryEntityUseCase: GetTaskItemEntitiesByCategoryEntityUseCase!
  
  private let updateTaskItemEntityUseCase: UpdateTaskItemEntityUseCase
  private let deleteTaskItemEntityUseCase: DeleteTaskItemEntityUseCase
  private let saveTaskItemEntityUseCase: SaveTaskItemEntityUseCase
  
  init(categoryItem: CategoryItem,
       appCoordinator: AppCoordinator,
       authManager: AuthManager,
       getTaskItemEntitiesByCategoryEntityUseCase: GetTaskItemEntitiesByCategoryEntityUseCase,
       updateTaskItemEntityUseCase: UpdateTaskItemEntityUseCase,
       deleteTaskItemEntityUseCase: DeleteTaskItemEntityUseCase,
       saveTaskItemEntityUseCase: SaveTaskItemEntityUseCase
  ) {
    self.categoryItem = categoryItem
    self.appCoordinator = appCoordinator
    self.authManager = authManager
    self.getTaskItemEntitiesByCategoryEntityUseCase = getTaskItemEntitiesByCategoryEntityUseCase
    self.updateTaskItemEntityUseCase = updateTaskItemEntityUseCase
    self.deleteTaskItemEntityUseCase = deleteTaskItemEntityUseCase
    self.saveTaskItemEntityUseCase = saveTaskItemEntityUseCase
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
  
  // MARK: - Task Item manipulation
  func addNewTaskItem() async {
    Logger.d(tag: "SaveTaskItem", message: "Inside addNewTaskItem - HomeViewModel")
    guard !categoryDetailUiState.newTaskTitle.isEmpty else {
      categoryDetailUiState.errorMessage = "Task title cannot be empty."
      return
    }
    guard let userId = authManager.currentUser?.id else {
      categoryDetailUiState.errorMessage = "Cannot get current user id"
      return
    }
    
    
    let newTaskItem = TaskItem(
      id: UUID(),
      title: categoryDetailUiState.newTaskTitle,
      isCompleted: false,
      createdAt: Date(),
      userId: userId)
    
    do {
      try await saveTaskItemEntityUseCase(newTaskItem.mapToTaskItemEntity)
    } catch let appError as AppError {
      categoryDetailUiState.errorMessage = appError.localizedDescription
    } catch {
      categoryDetailUiState.errorMessage = "Something went wrong while adding a new task item."
    }
    
    await start()
  }
  
  // MARK: - Navigation
  // ✅ - Go back to previous screen
  func goBack() {
    appCoordinator.goBack()
  }
  
  
  // MARK: - Update for binding
  func updateNewTaskItemTitle(_ newTitle: String) {
    categoryDetailUiState.newTaskTitle = newTitle
  }
  
} // 🧱
