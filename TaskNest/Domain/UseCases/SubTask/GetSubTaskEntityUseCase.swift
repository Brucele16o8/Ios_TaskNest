//
//  GetSubTaskUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct GetSubTaskEntityUseCase {
  private let subTaskRepository: SubTaskRepository
  
  init(subTaskRepository: SubTaskRepository) {
    self.subTaskRepository = subTaskRepository
  }
  
  func callAsFunction(subTaskEntityId: UUID) async throws -> SubTaskEntity {
    try await subTaskRepository.getSubTaskEntity(by: subTaskEntityId)
  }
}
