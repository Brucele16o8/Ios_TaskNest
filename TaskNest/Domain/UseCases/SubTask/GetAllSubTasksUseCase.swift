//
//  getAllSubTasksUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct GetAllSubTasksUseCase {
  private let subTaskRepository: SubTaskRepository
  
  init(subTaskRepository: SubTaskRepository) {
    self.subTaskRepository = subTaskRepository
  }
  
  func callAsFunction() async throws -> [SubTask] {
    return try await subTaskRepository.getAll()
  }
}
