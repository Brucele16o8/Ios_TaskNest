//
//  MockTaskItemRepository.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

final class MockTaskItemRepository: TaskItemRepository {
  
  func getAll() async throws -> [TaskItemEntity] {
    try TaskItem.all.map { try $0.mapToTaskItemEntity }
  }
  
  func getTaskItemEntity(byId id: UUID) async throws -> TaskItemEntity {
    if let taskItem = TaskItem.all.first(where: { $0.id == id }) {
      return try taskItem.mapToTaskItemEntity
    } else {
      throw AppError.database(.notFound(message: "TaskItem with id \(id) not found"))
    }
    // wrong - change later
  }
  
  func save(_ taskItemEntity: TaskItemEntity) async throws {
    let taskItem = taskItemEntity.mapToTaskItem
    TaskItem.all.append(taskItem)
    // wrong - change later
  }
  
  func update(_ taskItemEntity: TaskItemEntity) async throws {
    let taskItem = taskItemEntity.mapToTaskItem
    if let index = TaskItem.all.firstIndex(of: taskItem) {
      TaskItem.all[index] = taskItem
    } else {
      throw AppError.database(.notFound(message: "TaskItem with id \(taskItem.id) not found"))
    }
    // wrong - change later
  }
  
  func delete(id: UUID) async throws {
    if let index = TaskItem.all.firstIndex(where: { $0.id == id }) {
      TaskItem.all.remove(at: index)
    } else {
      throw AppError.database(.notFound(message: "TaskItem with id \(id) not found"))
    }
    // wrong - change later
  }
  
  func getTaskItemsByCategory(categoryEntityId: UUID) async throws -> [TaskItemEntity] {
    let taskItems = TaskItem.all.filter { $0.category?.id == categoryEntityId }
    return try taskItems.map { try $0.mapToTaskItemEntity }
    // wrong - change later
  }
  
} // 🧱
