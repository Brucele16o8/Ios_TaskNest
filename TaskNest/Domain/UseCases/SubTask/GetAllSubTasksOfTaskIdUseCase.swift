//
//  GetAllSubTasksOfTaskId.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct GetAllSubTaskEntitiesOfTaskId {
  private let subTaskRepository: SubTaskRepository
  
  init(subTaskRepository: SubTaskRepository) {
    self.subTaskRepository = subTaskRepository
  }
  
  func callAsFunction(_ taskEntityId: UUID) async throws -> [SubTaskEntity] {
    try await subTaskRepository.getAllSubTaskEntities(ofTaskEntityId: taskEntityId)
  }
}
