//
//  AppModelActor+SubTaskLocalDb.swift
//  TaskNest
//
//  Created by Tung Le on 4/7/2025.
//

import Foundation
import SwiftData

extension AppModelActor: SubTaskLocalDb {  
  
  // ✅
  func getAllSubTaskEntities() async throws -> [SubTaskEntity] {
    do {
      let subTasks = try modelContext.fetch(FetchDescriptor<SubTask>())
      return try subTasks.map { try $0.mapToSubTaskEntity }
    } catch let error as AppError {
      throw error
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch SubTask from database]"), underlyingError: error)
    }
  }
  
  // ✅
  func getSubTaskEntity(ofId id: UUID) async throws -> SubTaskEntity{
    do {
      return try await getSubTask(by: id).mapToSubTaskEntity
    } catch let appError as AppError {
      throw appError
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch SubTaskEntity with id: \(id) from database]"))
    }
  }
  
  // ++
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
  func saveSubTaskEntity(_ subTaskEntity: SubTaskEntity) async throws {
    do {
      let taskItem = try await getTaskItem(by: subTaskEntity.taskId)
      let subTask = subTaskEntity.mapToSubTask
      subTask.taskItem = taskItem
      try modelContext.save()
    } catch let appError as AppError {
      throw appError
    } catch {
      throw AppError.database(.saveFailed(message: "[SwiftData] Failed to save SubTask to database"), underlyingError: error)
    }
  }
  
  // ✅
  func updateSubTaskEntity(_ subTaskEntity: SubTaskEntity) async throws {
    var newTaskItem: TaskItem? = nil
    do {
      let subTask = try await getSubTask(by: subTaskEntity.id)
      
      if subTask.taskItem?.id != subTaskEntity.taskId {
        newTaskItem = try await getTaskItem(by: subTaskEntity.taskId)
      }
      
      if subTask.applyIfChanged(fromSubTaskEntity: subTaskEntity, newTaskItem: newTaskItem) {
        try modelContext.save()
      }
    } catch let appError as AppError {
      throw appError
    } catch {
      throw AppError.database(.saveFailed(message: "[SwiftData] Failed to save SubTask to database"), underlyingError: error)
    }
  }
  
  // ✅
  func deleteSubTaskEntity(id: UUID) async throws {
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
  func getAllSubTaskEntities(ofTaskId taskId: UUID) async throws -> [SubTaskEntity] {
    let predicate = #Predicate<SubTask> { $0.taskItem?.id == taskId }
    let descriptor = FetchDescriptor<SubTask>(predicate: predicate)
    
    do {
      let subTaskItems = try modelContext.fetch(descriptor)
      return try subTaskItems.map { try $0.mapToSubTaskEntity }
    } catch let appError as AppError {
      throw appError
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch all SubTasks with taskId \(taskId) from database"), underlyingError: error)
    }
  }
  
} // 🧱
