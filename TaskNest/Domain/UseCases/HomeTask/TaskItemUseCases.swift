//
//  TaskItemUseCases.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation

final class TaskItemUseCases {
  private var taskItemRepository: TaskItemRepository
  
  init(taskItemRepository: TaskItemRepository) {
    self.taskItemRepository = taskItemRepository
  }
  
  func getAllTaskItems() async throws -> [TaskItem] {
    return try await taskItemRepository.getAll()
  }
  
  func getTaskItem(by id: UUID) async throws -> TaskItem {
    return try await taskItemRepository.getTaskItem(by: id)
  }
  
  func save(_ taskItem: TaskItem) async throws {
    try await taskItemRepository.save(taskItem)
  }
  
  func update(_ taskItem: TaskItem) async throws {
    try await taskItemRepository.update(taskItem)
  }
  
  func delete(id: UUID) async throws {
    try await taskItemRepository.delete(id: id)
  }
  
  func getTaskItemsByCategory(categoryId: UUID) async throws -> [TaskItem] {
    return try await taskItemRepository.getTaskItemsByCategory(categoryId: categoryId)
  }
  
} // 🧱

