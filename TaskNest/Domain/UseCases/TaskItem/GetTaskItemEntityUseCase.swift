//
//  getTaskItemUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//
import Foundation

struct GetTaskItemEntityUseCase {
  private let taskItemRepository: TaskItemRepository
  
  init(taskItemRepository: TaskItemRepository) {
    self.taskItemRepository = taskItemRepository
  }
  
  func callAsFunction(id: UUID) async throws -> TaskItemEntity {
    try await taskItemRepository.getTaskItemEntity(byId: id)
  }
}
