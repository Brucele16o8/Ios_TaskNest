//
//  SubTaskRepository.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation

protocol SubTaskRepository {
  func getAll() async throws -> [SubTask]
  func getSubTask(by id: UUID) async throws -> SubTask
  func save(_ subTask: SubTask) async throws
  func update(_ subTask: SubTask) async throws
  func delete(id: UUID) async throws
  func getAllSubTasks(ofTaskId taskId: UUID) async throws -> [SubTask]
}

