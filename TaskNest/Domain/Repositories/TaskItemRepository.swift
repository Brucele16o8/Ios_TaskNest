//
//  TaskItemRepository.swift
//  TaskNest
//
//  Created by Tung Le on 28/6/2025.
//

import Foundation

protocol TaskItemRepository {
  func getAll() async throws -> [TaskItem]
  func getTaskItem(by id: UUID) async throws -> TaskItem
  func save(_ taskItem: TaskItem) async throws
  func update(_ taskItem: TaskItem) async throws
  func delete(id: UUID) async throws
  func getTaskItemsByCategory(categoryId: UUID) async throws -> [TaskItem]
}

