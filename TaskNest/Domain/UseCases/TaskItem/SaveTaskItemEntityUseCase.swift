//
//  saveTaskItemUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation

struct SaveTaskItemEntityUseCase {
  private let taskItemRepository: TaskItemRepository
  
  init(taskItemRepository: TaskItemRepository) {
    self.taskItemRepository = taskItemRepository
  }
  
  func callAsFunction(_ taskItemEntity: TaskItemEntity) async throws {
    try await taskItemRepository.save(taskItemEntity)
  }
}
