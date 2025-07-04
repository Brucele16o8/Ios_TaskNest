//
//  AppModelActor+CategoryModel.swift
//  TaskNest
//
//  Created by Tung Le on 4/7/2025.
//

import Foundation
import SwiftData

extension AppModelActor: CategoryLocalDb {
  
  // ✅
  func getAllCategoryEntities() async throws -> [CategoryEntity] {
    do {
      let categories = try modelContext.fetch(FetchDescriptor<Category>())
      return categories.map { $0.mapToCategoryEntity }
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch categories from database"), underlyingError: error)
    }
  }
  
  // ✅
  func getCategoryEntity(ofId id: UUID) async throws -> CategoryEntity {
    do {
      return try await getCategory(by: id).mapToCategoryEntity
    } catch let error as AppError {
      throw error
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch category entity with id \(id)"), underlyingError: error)
    }
  }
  
  /// ++ helper
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
  func saveCategoryEntity(_ categoryEntity: CategoryEntity) async throws  {
    let category = categoryEntity.mapToCategory
    modelContext.insert(category)
    do {
      try modelContext.save()
    } catch {
      throw AppError.database(.saveFailed(message: "[SwiftData] Failed to save category"), underlyingError: error)
    }
  }
  
  // ✅
  func updateCategoryEntity(_ categoryEntity: CategoryEntity) async throws {
    do {
      let category = try await getCategory(by: categoryEntity.id)
      if category.applyIfChanged(fromCategoryEntity: categoryEntity) {
        try modelContext.save()
      }
    } catch let error as AppError {
      throw error
    } catch {
      throw AppError.database(.saveFailed(message: "[SwiftData] Failed to update category"), underlyingError: error)
    }
  }
  
  // ✅
  func deleteCategoryEntity(id: UUID) async throws {
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
