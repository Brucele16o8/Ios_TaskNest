//
//  getTaskItemsByCategoryUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct GetTaskItemEntitiesByCategoryEntityUseCase {
  private let taskItemRepository: TaskItemRepository
  
  init(taskItemRepository: TaskItemRepository) {
    self.taskItemRepository = taskItemRepository
  }
  
  func callAsFunction(categoryEntityId: UUID) async throws -> [TaskItemEntity] {
    return try await taskItemRepository.getTaskItemsByCategory(categoryEntityId: categoryEntityId)
  }
}



struct MockGetTaskItemEntitiesByCategoryEntityUseCase {
  private let taskItemRepository: TaskItemRepository
  
  init(taskItemRepository: MockTaskItemRepository) {
    self.taskItemRepository = taskItemRepository
  }
  
  func callAsFunction(categoryEntityId: UUID) async throws -> [TaskItemEntity] {
    return try await taskItemRepository.getTaskItemsByCategory(categoryEntityId: categoryEntityId)
  }
}
