//
//  MockTaskItemRepository.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

final class MockTaskItemRepository: TaskItemRepository {
  
  func getAll() async throws -> [TaskItem] {
    TaskItem.all
  }
  
  func getTaskItem(by id: UUID) async throws -> TaskItem {
    if let TaskItem = TaskItem.all.first(where: { $0.id == id }) {
      return TaskItem
    } else {
      throw AppError.database(.notFound(message: "TaskItem with id \(id) not found"))
    }
  }
  
  func save(_ taskItem: TaskItem) async throws {
    TaskItem.all.append(taskItem)
  }
  
  func update(_ taskItem: TaskItem) async throws {
    if let index = TaskItem.all.firstIndex(of: taskItem) {
      TaskItem.all[index] = taskItem
    } else {
      throw AppError.database(.notFound(message: "TaskItem with id \(taskItem.id) not found"))
    }
  }
  
  func delete(id: UUID) async throws {
    if let index = TaskItem.all.firstIndex(where: { $0.id == id }) {
      TaskItem.all.remove(at: index)
    } else {
      throw AppError.database(.notFound(message: "TaskItem with id \(id) not found"))
    }
  }
  
  func getTaskItemsByCategory(categoryId: UUID) async throws -> [TaskItem] {
    TaskItem.all.filter { $0.category?.id == categoryId }
  }
  
} // 🧱
