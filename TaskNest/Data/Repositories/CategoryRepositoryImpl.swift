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
  private let categoryLocalDb: CategoryLocalDb
  
  init(categoryRemoteSource: CategoryRemoteSource, categoryLocalDb: CategoryLocalDb) {
    self.categoryRemoteSource = categoryRemoteSource
    self.categoryLocalDb = categoryLocalDb
  }
  
  // ✅
  func getAll() async throws -> [CategoryEntity] {
    return try await categoryLocalDb.getAllCategoryEntities()
  }
  
  // ✅
  func getCategoryEntity(by id: UUID) async throws -> CategoryEntity {
    return try await categoryLocalDb.getCategoryEntity(ofId: id)
  }
  
  // ✅
  func save(_ categoryEntity: CategoryEntity) async throws {
    try await categoryLocalDb.saveCategoryEntity(categoryEntity)
  }
  
  // ✅
  func update(_ categoryEntity: CategoryEntity) async throws {
    try await categoryLocalDb.updateCategoryEntity(categoryEntity)
  }
  
  // ✅
  func delete(id: UUID) async throws {
    try await categoryLocalDb.deleteCategoryEntity(id: id)
  }
  
} // 🧱
