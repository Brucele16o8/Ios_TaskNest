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
  private let modelContext: ModelContext
  
  init(subTaskRemoteSource: SubTaskRemoteSource, modelContext: ModelContext) {
    self.subTaskRemoteSource = subTaskRemoteSource
    self.modelContext = modelContext
  }
  
  // ✅
  func getAll() async throws -> [SubTask] {
    do {
      return try modelContext.fetch(FetchDescriptor<SubTask>())
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch SubTask from database]"), underlyingError: error)
    }
  }
  
  // ✅
  func getSubTask(by id: UUID) async throws -> SubTask {
    let predicate = #Predicate<SubTask> { $0.id == id }
    let descriptor = FetchDescriptor<SubTask>(predicate: predicate)
    
    do {
      guard let subTask = try modelContext.fetch(descriptor).first else {
        throw AppError.database(.notFound(message: "[SwiftData] SubTask not found with id \(id)"))
      }
      return subTask
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch SubTask with id: \(id) from database]"), underlyingError: error)
    }
  }
  
  // ✅
  func save(_ subTask: SubTask) async throws {
    modelContext.insert(subTask)
    do {
      try modelContext.save()
    } catch {
      throw AppError.database(.saveFailed(message: "[SwiftData] Failed to save SubTask to database"), underlyingError: error)
    }
  }
  
  // ✅
  func update(_ subTask: SubTask) async throws {
    do {
      try modelContext.save()
    } catch {
      throw AppError.database(.saveFailed(message: "[SwiftData] Failed to save SubTask to database"), underlyingError: error)
    }
  }
  
  // ✅
  func delete(id: UUID) async throws {
    let predicate = #Predicate<SubTask> { $0.id == id }
    let descriptor = FetchDescriptor<SubTask>(predicate: predicate)
    
    do {
      guard let subTasksToDelete = try modelContext.fetch(descriptor).first else {
        throw AppError.database(.notFound(message: "[SwiftData] SubTask with id \(id) not found to delete "))
      }
      modelContext.delete(subTasksToDelete)
      try modelContext.save()
    } catch {
      throw AppError.database(.deleteFailed(message: "[SwiftData] Failed to delete SubTask with id \(id) from database]"), underlyingError: error)
    }
  }
  
  // ✅
  func getAllSubTasks(ofTaskId taskId: UUID) async throws -> [SubTask] {
    let predicate = #Predicate<SubTask> { $0.task?.id == taskId }
    let descriptor = FetchDescriptor<SubTask>(predicate: predicate)
    
    do {
      return try modelContext.fetch(descriptor)
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch all SubTasks with taskId \(taskId) from database"), underlyingError: error)
    }
  }
  
} // 🧱
