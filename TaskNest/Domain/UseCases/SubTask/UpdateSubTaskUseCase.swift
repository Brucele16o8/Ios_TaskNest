//
//  UpdateSubTaskUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct UpdateSubTaskUseCase {
  private let subTaskRepository: SubTaskRepository
  
  init(subTaskRepository: SubTaskRepository) {
    self.subTaskRepository = subTaskRepository
  }
  
  func callAsFunction(subTask: SubTask) async throws {
    try await subTaskRepository.update(subTask)
  }
}
