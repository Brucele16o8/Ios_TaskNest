//
//  deleteTaskItemUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct DeleteTaskItemUseCase {
  private let taskItemRepository: TaskItemRepository
  
  init(taskItemRepository: TaskItemRepository) {
    self.taskItemRepository = taskItemRepository
  }
  
  func callAsFunction(id: UUID) async throws {
    try await taskItemRepository.delete(id: id)
  }
}
