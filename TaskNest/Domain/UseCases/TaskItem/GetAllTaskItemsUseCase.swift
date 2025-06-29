//
//  getAllTaskItems.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation

struct GetAllTaskItemsUseCase {
  private let taskItemRepository: TaskItemRepository
  
  init(taskItemRepository: TaskItemRepository) {
    self.taskItemRepository = taskItemRepository
  }
  
  func callAsFunction() async throws -> [TaskItem] {
    return try await taskItemRepository.getAll()
  }
}
