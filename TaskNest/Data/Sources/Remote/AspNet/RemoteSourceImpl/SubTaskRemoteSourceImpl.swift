//
//  SubTaskRemoteSourceImpl.swift
//  TaskNest
//
//  Created by Tung Le on 27/6/2025.
//

import Foundation

class SubTaskRemoteSourceImpl: SubTaskRemoteSource {
  private let subTaskApi: SubTaskApi
  
  init(subTaskApi: SubTaskApi) {
    self.subTaskApi = subTaskApi
  }
  
  func getAllSubTasks() async throws -> [SubTaskDto] {
    try await subTaskApi.getAllSubTasks()
  }
  
  func getSubTask(by id: UUID) async throws -> SubTaskDto {
    try await subTaskApi.getSubTask(by: id)
  }
  
  func createSubTask(_ subTaskDto: SubTaskDto) async throws {
    try await subTaskApi.createSubTask(subTaskDto)
  }
  
  func updateSubTask(_ subTaskDto: SubTaskDto) async throws {
    try await subTaskApi.updateSubTask(subTaskDto)
  }
  
  func deleteSubTask(id: UUID) async throws {
    try await subTaskApi.deleteSubTask(id: id)
  }
  
  func getSubTasksByTaskId(taskId: UUID) async throws -> [SubTaskDto] {
    try await subTaskApi.getSubTasksByTaskId(taskId: taskId)
  }  
  
}
