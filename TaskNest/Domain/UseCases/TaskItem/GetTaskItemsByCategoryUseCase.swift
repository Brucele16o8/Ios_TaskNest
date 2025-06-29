//
//  getTaskItemsByCategoryUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct GetTaskItemsByCategoryUseCase {
  private let taskItemRepository: TaskItemRepository
  
  init(taskItemRepository: TaskItemRepository) {
    self.taskItemRepository = taskItemRepository
  }
  
  func callAsFunction(categoryId: UUID) async throws -> [TaskItem] {
    return try await taskItemRepository.getTaskItemsByCategory(categoryId: categoryId)
  }
}
