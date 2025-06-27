//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 27/6/2025.
//

import Foundation

class TaskItemApiClient: TaskItemApi {
  private let networkService: NetworkService
  private let authManager: AuthManager
  
  init(networkService: NetworkService, authManager: AuthManager) {
    self.networkService = networkService
    self.authManager = authManager
  }
  
  func getAllTasks() async throws -> [TaskItemDto] {
    try await networkService.request(
      endpoint: "api/taskItem/all",
      method: .getMethod,
      body: Optional<Data>.none,
      headers: [:],
      authToken: nil
    )
  }
  
  func getTask(by id: UUID) async throws -> TaskItemDto {
    try await networkService.request(
      endpoint: "api/taskItem/\(id)",
      method: .getMethod,
      body: Optional<Data>.none,
      headers: [:],
      authToken: nil
    )
  }
  
  func createTask(_ taskItemDto: TaskItemDto) async throws {
    try await networkService.requestWithoutResponse(
      endpoint: "api/taskItem",
      method: .postMethod,
      body: taskItemDto,
      headers: [:],
      authToken: authManager.authToken
    )
  }
  
  func updateTask(_ taskItemDto: TaskItemDto) async throws {
    try await networkService.requestWithoutResponse(
      endpoint: "api/taskItem",
      method: .putMethod,
      body: taskItemDto,
      headers: [:],
      authToken: authManager.authToken
    )
  }
  
  func deleteTask(id: UUID) async throws {
    try await networkService.requestWithoutResponse(
      endpoint: "api/taskItem/\(id)",
      method: .deleteMethod,
      body: Optional<Data>.none,
      headers: [:],
      authToken: authManager.authToken
    )
  }
  
  func getTasksbyCategory(categoryId: UUID) async throws -> [TaskItemDto] {
    try await networkService.request(
      endpoint: "api/taskItem/category/\(categoryId)",
      method: .getMethod,
      body: Optional<Data>.none,
      headers: [:],
      authToken: nil
    )
  }
  
}
