//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation
import SwiftData

final class SubTaskRepositoryImpl: SubTaskRepository {
  private let subTaskRemoteSource: SubTaskRemoteSource
  private let subTaskModelActor: SubTaskLocalDb
  
  init(subTaskRemoteSource: SubTaskRemoteSource, subTaskModelActor: SubTaskLocalDb) {
    self.subTaskRemoteSource = subTaskRemoteSource
    self.subTaskModelActor = subTaskModelActor
  }
  
  // ✅
  func getAll() async throws -> [SubTaskEntity] {
    try await subTaskModelActor.getAllSubTaskEntities()
  }
  
  // ✅
  func getSubTaskEntity(by id: UUID) async throws -> SubTaskEntity {
    try await subTaskModelActor.getSubTaskEntity(ofId: id)
  }
  
  // ✅
  func save(_ subTaskEntity: SubTaskEntity) async throws {
    try await subTaskModelActor.saveSubTaskEntity(subTaskEntity)
  }
  
  // ✅
  func update(_ subTaskEntity: SubTaskEntity) async throws {
    try await subTaskModelActor.updateSubTaskEntity(subTaskEntity)
  }
  
  // ✅
  func delete(id: UUID) async throws {
    try await subTaskModelActor.deleteSubTaskEntity(id: id)
  }
  
  // ✅
  func getAllSubTaskEntities(ofTaskEntityId taskItemId: UUID) async throws -> [SubTaskEntity] {
    try await subTaskModelActor.getAllSubTaskEntities(ofTaskId: taskItemId)
  }
  
} // 🧱
