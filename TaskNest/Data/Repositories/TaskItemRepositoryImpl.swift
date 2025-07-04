//
//  TaskItemRepository.swift
//  TaskNest
//
//  Created by Tung Le on 28/6/2025.
//

import Foundation
import SwiftData

final class TaskItemRepositoryImpl: TaskItemRepository {
  
  private let taskItemRemoteSource: TaskItemRemoteSource
  private let taskItemLocalDb: TaskItemLocalDb
  
  init(taskItemRemoteSource: TaskItemRemoteSource, taskItemLocalDb: TaskItemLocalDb) {
    self.taskItemRemoteSource = taskItemRemoteSource
    self.taskItemLocalDb = taskItemLocalDb
  }
  
  // ✅
  func getAll() async throws -> [TaskItemEntity] {
    try await taskItemLocalDb.getAllTaskEntities()
  }
  
  // ✅
  func getTaskItemEntity(byId id: UUID) async throws -> TaskItemEntity {
    return try await taskItemLocalDb.getTaskItemEntity(byId: id)
  }
  
  // ✅
  func save(_ taskItemEntity: TaskItemEntity) async throws  {
    try await taskItemLocalDb.saveTaskItemEntity(taskItemEntity)
  }
  
  // ✅
  func update(_ taskItemEntity: TaskItemEntity) async throws {
    try await taskItemLocalDb.updateTaskItemEntity(taskItemEntity)
  }
  
  // ✅
  func delete(id: UUID) async throws {
    try await taskItemLocalDb.deleteTaskItemEntity(id: id)
  }
  
  // ✅
  func getTaskItemsByCategory(categoryEntityId: UUID) async throws -> [TaskItemEntity] {
    return try await taskItemLocalDb.getTaskItemEntities(byCategoryEntityId: categoryEntityId)
  }
  
} // 🧱
