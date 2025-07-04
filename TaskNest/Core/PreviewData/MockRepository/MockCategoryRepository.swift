//
//  MockCategoryRepository.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

final class MockCategoryRepository: CategoryRepository {
  
  
  
  func getAll() async throws -> [CategoryEntity] {
    Category.all.map { $0.mapToCategoryEntity }
  }
  
  func getCategoryEntity(by id: UUID) async throws -> CategoryEntity {
    if let index = Category.all.firstIndex(where: { $0.id == id }) {
      return Category.all[index].mapToCategoryEntity
    } else {
      throw AppError.database(.notFound(message: "Category with id \(id) not found"))
    }
    // wrong - change later
  }
  
  func save(_ categoryEntity: CategoryEntity) async throws {
    let category = categoryEntity.mapToCategory
    Category.all.append(category)
    // wrong - change later
  }
  
  func update(_ categoryEntity: CategoryEntity) async throws {
    let category = categoryEntity.mapToCategory
    if let index = Category.all.firstIndex(of: category) {
      Category.all[index] = category
    } else {
      throw AppError.database(.notFound(message: "Category with id \(category.id) not found"))
    }
    // wrong - change later
  }
  
  func delete(id: UUID) async throws {
    if let index = Category.all.firstIndex(where: { $0.id == id }) {
      Category.all.remove(at: index)
    } else {
      throw AppError.database(.notFound(message: "Category with id \(id) not found"))
    }
    // wrong - change later
  }
  
} // 🧱
