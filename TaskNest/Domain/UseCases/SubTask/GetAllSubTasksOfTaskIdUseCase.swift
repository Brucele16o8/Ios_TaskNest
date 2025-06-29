//
//  GetAllSubTasksOfTaskId.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct GetAllSubTasksOfTaskId {
  private let subTaskRepository: SubTaskRepository
  
  init(subTaskRepository: SubTaskRepository) {
    self.subTaskRepository = subTaskRepository
  }
  
  func callAsFunction(_ taskId: UUID) async throws -> [SubTask] {
    try await subTaskRepository.getAllSubTasks(ofTaskId: taskId)
  }
}
