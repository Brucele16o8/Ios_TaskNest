//
//  TaskItemRemoteSourceImpl.swift
//  TaskNest
//
//  Created by Tung Le on 27/6/2025.
//

import Foundation

class TaskItemRemoteSourceImpl: TaskItemRemoteSource {
  private let taskItemApi: TaskItemApi
  
  init(taskItemApi: TaskItemApi) {
    self.taskItemApi = taskItemApi
  }
  
  func getAllTasks() async throws -> [TaskItemDto] {
    try await taskItemApi.getAllTasks()
  }
  
  func getTask(by id: UUID) async throws -> TaskItemDto {
    try await taskItemApi.getTask(by: id)
  }
  
  func createTask(_ taskItemDto: TaskItemDto) async throws {
    try await taskItemApi.createTask(taskItemDto)
  }
  
  func updateTask(_ taskItemDto: TaskItemDto) async throws {
    try await taskItemApi.updateTask(taskItemDto)
  }
  
  func deleteTask(id: UUID) async throws {
    try await taskItemApi.deleteTask(id: id)
  }
  
  func getTasksbyCategory(categoryId: UUID) async throws -> [TaskItemDto] {
    try await taskItemApi.getTasksbyCategory(categoryId: categoryId)
  }
  
  
} // 🧱
