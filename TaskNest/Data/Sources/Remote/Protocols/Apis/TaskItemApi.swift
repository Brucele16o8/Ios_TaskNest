//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 27/6/2025.
//

import Foundation

protocol TaskItemApi {
  func getAllTasks() async throws -> [TaskItemDto]
  func getTask(by id: UUID) async throws -> TaskItemDto
  func createTask(_ taskItemDto: TaskItemDto) async throws
  func updateTask(_ taskItemDto: TaskItemDto) async throws
  func deleteTask(id: UUID) async throws
  func getTasksbyCategory(categoryId: UUID) async throws -> [TaskItemDto]
}




