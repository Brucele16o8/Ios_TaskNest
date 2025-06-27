//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 27/6/2025.
//

import Foundation

protocol SubTaskRemoteSource {
  func getAllSubTasks() async throws -> [SubTaskDto]
  func getSubTask(by id: UUID) async throws -> SubTaskDto
  func createSubTask(_ subTaskDto: SubTaskDto) async throws
  func updateSubTask(_ subTaskDto: SubTaskDto) async throws
  func deleteSubTask(id: UUID) async throws
  func getSubTasksByTaskId(taskId: UUID) async throws -> [SubTaskDto]
}
