//
//  SubTaskRepository.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation

final class SubTaskUseCases {
  private let subTaskRepository: SubTaskRepository
  
  init(subTaskRepository: SubTaskRepository) {
    self.subTaskRepository = subTaskRepository
  }
  
  func getAllSubTasks() async throws -> [SubTask] {
    try await self.subTaskRepository.getAll()
  }
  
  func getSubTask(by id: UUID) async throws -> SubTask {
    try await self.subTaskRepository.getSubTask(by: id)
  }
  
  func save(_ subTask: SubTask) async throws {
    try await self.subTaskRepository.save(subTask)
  }
  
  func update(_ subTask: SubTask) async throws {
    try await self.subTaskRepository.update(subTask)
  }
  
  func delete(id: UUID) async throws {
    try await self.subTaskRepository.delete(id: id)
  }
  
  func getAllSubTasks(ofTaskId taskId: UUID) async throws -> [SubTask] {
    try await self.subTaskRepository.getAllSubTasks(ofTaskId: taskId)
  }
  
} // 🧱

