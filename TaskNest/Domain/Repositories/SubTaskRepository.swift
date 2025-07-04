//
//  SubTaskRepository.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation

protocol SubTaskRepository {
  func getAll() async throws -> [SubTaskEntity]
  func getSubTaskEntity(by id: UUID) async throws -> SubTaskEntity
  func save(_ subTaskEntity: SubTaskEntity) async throws
  func update(_ subTaskEntity: SubTaskEntity) async throws
  func delete(id: UUID) async throws
  func getAllSubTaskEntities(ofTaskEntityId taskItemId: UUID) async throws -> [SubTaskEntity]
}

