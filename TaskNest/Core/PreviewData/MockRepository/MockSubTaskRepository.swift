//
//  MockSubTaskRepository.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

final class MockSubTaskRepository: SubTaskRepository {
  
  func getAll() async throws -> [SubTaskEntity] {
    try SubTask.all.map { try $0.mapToSubTaskEntity }
  }
  
  func getSubTaskEntity(by id: UUID) async throws -> SubTaskEntity {
    if let index = SubTask.all.firstIndex(where: { $0.id == id }) {
      return try SubTask.all[index].mapToSubTaskEntity
    } else {
      throw AppError.database(.notFound(message: "Sub Task with id \(id) not found"))
    }
    // wrong - change later
  }
  
  func save(_ subTaskEntity: SubTaskEntity) async throws {
    let subTask = subTaskEntity.mapToSubTask
    SubTask.all.append(subTask)
    // wrong - change later
  }
  
  func update(_ subTaskEntity: SubTaskEntity) async throws {
    let subTask = subTaskEntity.mapToSubTask
    if let index = SubTask.all.firstIndex(of: subTask) {
      SubTask.all[index] = subTask
    } else {
      throw AppError.database(.notFound(message: "Sub Task with id \(subTask.id) not found"))
    }
    // wrong - change later
  }
  
  func delete(id: UUID) async throws {
    if let index = SubTask.all.firstIndex(where: { $0.id == id }) {
      SubTask.all.remove(at: index)
    } else {
      throw AppError.database(.notFound(message: "Sub Task with id \(id) not found to delete"))
    }
    // wrong - change later
  }
  
  func getAllSubTaskEntities(ofTaskEntityId taskItemId: UUID) async throws -> [SubTaskEntity] {
    return try SubTask.all.filter { $0.taskItem?.id == taskItemId }.map { try $0.mapToSubTaskEntity }
    // wrong - change later
  }
  
} // 🧱
