//
//  updateTaskItemUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct UpdateTaskItemEntityUseCase {
  private let taskItemRepository: TaskItemRepository
  
  init(taskItemRepository: TaskItemRepository) {
    self.taskItemRepository = taskItemRepository
  }
  
  func callAsFunction(taskItemEntity: TaskItemEntity) async throws -> Void {
    try await taskItemRepository.update(taskItemEntity)
  }
}
