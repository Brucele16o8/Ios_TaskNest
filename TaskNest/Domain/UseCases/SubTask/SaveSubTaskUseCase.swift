//
//  SaveSubTaskUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

struct SaveSubTaskUseCase {
  private let subTaskRepository: SubTaskRepository
  
  init(subTaskRepository: SubTaskRepository) {
    self.subTaskRepository = subTaskRepository
  }
  
  func callAsFunction(subTask: SubTask) async throws {
    try await subTaskRepository.save(subTask)
  }
}
