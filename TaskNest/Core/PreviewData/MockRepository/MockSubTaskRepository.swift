//
//  MockSubTaskRepository.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

final class MockSubTaskRepository: SubTaskRepository {
  func getAll() async throws -> [SubTask] {
    SubTask.all
  }
  
  func getSubTask(by id: UUID) async throws -> SubTask {
    if let index = SubTask.all.firstIndex(where: { $0.id == id }) {
      return SubTask.all[index]
    } else {
      throw AppError.database(.notFound(message: "Sub Task with id \(id) not found"))
    }
  }
  
  func save(_ subTask: SubTask) async throws {
    SubTask.all.append(subTask)
  }
  
  func update(_ subTask: SubTask) async throws {
    if let index = SubTask.all.firstIndex(of: subTask) {
      SubTask.all[index] = subTask
    } else {
      throw AppError.database(.notFound(message: "Sub Task with id \(subTask.id) not found"))
    }
  }
  
  func delete(id: UUID) async throws {
    if let index = SubTask.all.firstIndex(where: { $0.id == id }) {
      SubTask.all.remove(at: index)
    } else {
      throw AppError.database(.notFound(message: "Sub Task with id \(id) not found to delete"))
    }
  }
  
  func getAllSubTasks(ofTaskId taskId: UUID) async throws -> [SubTask] {
    return SubTask.all.filter { $0.task?.id == taskId }
  }
  
} // 🧱
