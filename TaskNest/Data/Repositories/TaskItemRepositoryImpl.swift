//
//  TaskItemRepository.swift
//  TaskNest
//
//  Created by Tung Le on 28/6/2025.
//

import Foundation
import SwiftData

final class TaskItemRepositoryImpl: TaskItemRepository {
  private let taskItemRemoteSource: TaskItemRemoteSource
  private let modelContext: ModelContext
  
  init(taskItemRemoteSource: TaskItemRemoteSource, modelContext: ModelContext) {
    self.taskItemRemoteSource = taskItemRemoteSource
    self.modelContext = modelContext
  }
  
  // ✅
  func getAll() async throws -> [TaskItem] {
    do {
      return try modelContext.fetch(FetchDescriptor<TaskItem>())
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch TaskItem from database"), underlyingError: error)
    }
  }
  
  // ✅
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
  func save(_ taskItem: TaskItem) async throws {
    modelContext.insert(taskItem)
    do {
      try modelContext.save()
    } catch {
      throw AppError.database(.saveFailed(message: "[SwiftData] Failed to save taskItem"), underlyingError: error)
    }
  }
  
  // ✅
  func update(_ taskItem: TaskItem) async throws {
    do {
      try modelContext.save()
    } catch {
      throw AppError.database(.saveFailed(message: "[SwiftData] Failed to update taskItem"), underlyingError: error)
    }
  }
  
  // ✅
  func delete(id: UUID) async throws {
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
  func getTaskItemsByCategory(categoryId: UUID) async throws -> [TaskItem] {
    let predicate = #Predicate<TaskItem> { $0.category?.id == categoryId }
    let descriptor = FetchDescriptor<TaskItem>(predicate: predicate)
    
    do {
      return try modelContext.fetch(descriptor)
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch TaskItems for categoryId \(categoryId)"), underlyingError: error)
    }
  }
  
  
} // 🧱
