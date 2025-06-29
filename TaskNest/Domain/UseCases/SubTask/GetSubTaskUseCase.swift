//
//  GetSubTaskUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct GetSubTaskUseCase {
  private let subTaskRepository: SubTaskRepository
  
  init(subTaskRepository: SubTaskRepository) {
    self.subTaskRepository = subTaskRepository
  }
  
  func callAsFunction(taskId: UUID) async throws -> SubTask {
    try await subTaskRepository.getSubTask(by: taskId)
  }
}
