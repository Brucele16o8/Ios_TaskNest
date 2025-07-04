//
//  getAllTaskItems.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation

struct GetAllTaskItemEntitiesUseCase {
  private let taskItemRepository: TaskItemRepository
  
  init(taskItemRepository: TaskItemRepository) {
    self.taskItemRepository = taskItemRepository
  }
  
  func callAsFunction() async throws -> [TaskItemEntity] {
    return try await taskItemRepository.getAll()
  }
}
