//
//  TaskItemRepository.swift
//  TaskNest
//
//  Created by Tung Le on 28/6/2025.
//

import Foundation

protocol TaskItemRepository {
  func getAll() async throws -> [TaskItemEntity]
  func getTaskItemEntity(byId id: UUID) async throws -> TaskItemEntity
  func save(_ taskItemEntity: TaskItemEntity) async throws
  func update(_ taskItemEntity: TaskItemEntity) async throws
  func delete(id: UUID) async throws
  func getTaskItemsByCategory(categoryEntityId: UUID) async throws -> [TaskItemEntity]
}

