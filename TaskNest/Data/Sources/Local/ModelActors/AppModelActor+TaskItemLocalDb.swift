//
//  AppModelActor+TaskItemModel.swift
//  TaskNest
//
//  Created by Tung Le on 4/7/2025.
//

import Foundation
import SwiftData

extension AppModelActor: TaskItemLocalDb {
  // ✅
  func getAllTaskEntities() async throws -> [TaskItemEntity] {
    do {
      let taskItems: [TaskItem] = try modelContext.fetch(FetchDescriptor<TaskItem>())
      return try taskItems.map { try $0.mapToTaskItemEntity }
    } catch let appError as AppError {
      throw appError
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch TaskItem from database"), underlyingError: error)
    }
  }
  
  // ✅
  func getTaskItemEntity(byId id: UUID) async throws -> TaskItemEntity {
    do {
      return try await getTaskItem(by: id).mapToTaskItemEntity
    } catch let appError as AppError {
      throw appError
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch TaskItemeEntity with id \(id)"))
    }
  }
  
  /// ++ helper
  func getTaskItem(by id: UUID) async throws -> TaskItem {
    let predicate = #Predicate<TaskItem> { $0.id == id }
    let descriptor = FetchDescriptor<TaskItem>(predicate: predicate)
    
    do {
      guard let taskItem = try modelContext.fetch(descriptor).first else {
        throw AppError.database(.notFound(message: "[SwiftData] Category with id \(id) not found"))
      }
      return taskItem
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch taskItem with id \(id)"), underlyingError: error)
    }
  }
  
  // ✅
  func saveTaskItemEntity(_ taskItemEntity: TaskItemEntity) async throws {
    do {
      let category = try await getCategory(by: taskItemEntity.categoryId)
      let taskItem = taskItemEntity.mapToTaskItem
      taskItem.category = category
      try modelContext.save()
    } catch let appError as AppError {
      throw appError
    } catch {
      throw AppError.database(.saveFailed(message: "[SwiftData] Failed to save taskItem"), underlyingError: error)
    }
  }
  
  // ✅
  func updateTaskItemEntity(_ taskItemEntity: TaskItemEntity) async throws {
    var anyChanges = false
    do {
      let taskItem = try await getTaskItem(by: taskItemEntity.id)
      
      if taskItem.category?.id != taskItemEntity.categoryId {
        taskItem.category = try await getCategory(by: taskItemEntity.categoryId)
        anyChanges = true
      }
      if taskItem.applyIfChanged(fromTaskItemEntity: taskItemEntity) {
        anyChanges = true
      }
      
      if anyChanges { try modelContext.save() }
      
    } catch let appError as AppError {
      throw appError
    } catch {
      throw AppError.database(.saveFailed(message: "[SwiftData] Failed to update taskItem"), underlyingError: error)
    }
  }
  
  // ✅
  func deleteTaskItemEntity(id: UUID) async throws {
    let predicate = #Predicate<TaskItem> { $0.id == id }
    let descriptor = FetchDescriptor<TaskItem>(predicate: predicate)
    
    do {
      guard let taskItemToDelete = try modelContext.fetch(descriptor).first else {
        throw AppError.database(.notFound(message: "[SwiftData] TaskItem with id \(id) not found"))
      }
      modelContext.delete(taskItemToDelete)
      try modelContext.save()
    } catch {
      throw AppError.database(.deleteFailed(message: "[SwiftData] Failed to delete taskItem with id \(id)"), underlyingError: error)
    }
  }
  
  // ✅
  func getTaskItemEntities(byCategoryEntityId categoryEntityId: UUID) async throws -> [TaskItemEntity] {
    let predicate = #Predicate<TaskItem> { $0.category?.id == categoryEntityId }
    let descriptor = FetchDescriptor<TaskItem>(predicate: predicate)
    
    do {
      let taskItems = try modelContext.fetch(descriptor)
      return try taskItems.map { try $0.mapToTaskItemEntity }
    } catch let appError as AppError {
      throw appError
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch TaskItems for categoryId \(categoryEntityId)"), underlyingError: error)
    }
  }
  
} // 🧱
