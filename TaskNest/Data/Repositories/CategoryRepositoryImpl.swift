//
//  CategoryRepositoryImpl.swift
//  TaskNest
//
//  Created by Tung Le on 28/6/2025.
//

// == Implement to work offline first for now ===

import Foundation
import SwiftData

final class CategoryRepositoryImpl: CategoryRepository {
  private let categoryRemoteSource: CategoryRemoteSource // Use later
  private let modelContext: ModelContext
  
  init(categoryRemoteSource: CategoryRemoteSource, modelContext: ModelContext) {
    self.categoryRemoteSource = categoryRemoteSource
    self.modelContext = modelContext
  }
  
  // ✅
  func getAll() async throws -> [Category] {
    do {
      return try modelContext.fetch(FetchDescriptor<Category>())
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch categories from database"), underlyingError: error)
    }
  }
  
  // ✅
  func getCategory(by id: UUID) async throws -> Category {
    let predicate = #Predicate<Category> { $0.id == id }
    let descriptor = FetchDescriptor<Category>(predicate: predicate)
    
    do {
      guard let category = try modelContext.fetch(descriptor).first else {
        throw AppError.database(.notFound(message: "[SwiftData] Category with id \(id) not found"))
      }
      return category
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch category with id \(id)"), underlyingError: error)
    }
  }
  
  // ✅
  func save(_ category: Category) async throws {
    modelContext.insert(category)
    do {
      try modelContext.save()
    } catch {
      throw AppError.database(.saveFailed(message: "[SwiftData] Failed to save category"), underlyingError: error)
    }
  }
  
  // ✅
  func update(_ category: Category) async throws {
    do {
      try modelContext.save()
    } catch {
      throw AppError.database(.saveFailed(message: "[SwiftData] Failed to update category"), underlyingError: error)
    }
  }
  
  // ✅
  func delete(id: UUID) async throws {
    let predicate = #Predicate<Category> { $0.id == id }
    let descriptor = FetchDescriptor<Category>(predicate: predicate)
    
    do {
      if let category = try modelContext.fetch(descriptor).first {
        modelContext.delete(category)
        try modelContext.save()
      } else {
        throw AppError.database(.notFound(message: "[SwiftData] Category with id \(id) not found"))
      }
    } catch {
      throw AppError.database(.deleteFailed(message: "[SwiftData] Failed to delete category with id \(id)"), underlyingError: error)
    }
  }
  
} // 🧱
