//
//  SubTaskModelActor.swift
//  TaskNest
//
//  Created by Tung Le on 2/7/2025.
//

import Foundation

protocol SubTaskLocalDb {

  func getAllSubTaskEntities() async throws -> [SubTaskEntity]
  func getSubTaskEntity(ofId id: UUID) async throws -> SubTaskEntity
  func saveSubTaskEntity(_ subTaskEntity: SubTaskEntity) async throws
  func updateSubTaskEntity(_ subTask: SubTaskEntity) async throws
  func deleteSubTaskEntity(id: UUID) async throws
  func getAllSubTaskEntities(ofTaskId taskId: UUID) async throws -> [SubTaskEntity]
  
}
