//
//  SubTaskApiClient.swift
//  TaskNest
//
//  Created by Tung Le on 27/6/2025.
//

import Foundation

class SubTaskApiClient: SubTaskApi {
  private let networkservice: NetworkService
  private let authManager: AuthManager
  
  init(networkservice: NetworkService, authManager: AuthManager) {
    self.networkservice = networkservice
    self.authManager = authManager
  }
  
  
  
  func getAllSubTasks() async throws -> [SubTaskDto] {
    try await networkservice.request(
      endpoint: "api/subtask/all",
      method: .getMethod,
      body: Optional<Data>.none,
      headers: [:],
      authToken: nil
    )
  }
  
  func getSubTask(by id: UUID) async throws -> SubTaskDto {
    try await networkservice.request(
      endpoint: "api/subtask/\(id)",
      method: .getMethod,
      body: Optional<Data>.none,
      headers: [:],
      authToken: nil
    )
  }
  
  func createSubTask(_ subTaskDto: SubTaskDto) async throws {
    try await networkservice.requestWithoutResponse(
      endpoint: "api/subtask",
      method: .postMethod,
      body: subTaskDto,
      headers: [:],
      authToken: authManager.authToken
    )
  }
  
  func updateSubTask(_ subTaskDto: SubTaskDto) async throws {
    try await networkservice.requestWithoutResponse(
      endpoint: "api/subtask",
      method: .putMethod,
      body: subTaskDto,
      headers: [:],
      authToken: authManager.authToken
    )
  }
  
  func deleteSubTask(id: UUID) async throws {
    try await networkservice.requestWithoutResponse(
      endpoint: "api/subtask/\(id)",
      method: .postMethod,
      body: Optional<Data>.none,
      headers: [:],
      authToken: authManager.authToken
    )
  }
  
  func getSubTasksByTaskId(taskId: UUID) async throws -> [SubTaskDto] {
    try await networkservice.request(
      endpoint: "api/subtask/task/\(taskId)",
      method: .getMethod,
      body: Optional<Data>.none,
      headers: [:],
      authToken: authManager.authToken
    )
  }
  
  
}
