//
//  saveTaskItemUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation

struct SaveTaskItemUseCase {
  private let taskItemRepository: TaskItemRepository
  
  init(taskItemRepository: TaskItemRepository) {
    self.taskItemRepository = taskItemRepository
  }
  
  func callAsFunction(_ taskItem: TaskItem) async throws {
    try await taskItemRepository.save(taskItem)
  }
}
