//
//  MockCategoryRepository.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

final class MockCategoryRepository: CategoryRepository {
  func getAll() async throws -> [Category] {
    Category.all
  }
  
  func getCategory(by id: UUID) async throws -> Category {
    if let index = Category.all.firstIndex(where: { $0.id == id }) {
      return Category.all[index]
    } else {
      throw AppError.database(.notFound(message: "Category with id \(id) not found"))
    }
  }
  
  func save(_ category: Category) async throws {
    Category.all.append(category)
  }
  
  func update(_ category: Category) async throws {
    if let index = Category.all.firstIndex(of: category) {
      Category.all[index] = category
    } else {
      throw AppError.database(.notFound(message: "Category with id \(category.id) not found"))
    }
  }
  
  func delete(id: UUID) async throws {
    if let index = Category.all.firstIndex(where: { $0.id == id }) {
      Category.all.remove(at: index)
    } else {
      throw AppError.database(.notFound(message: "Category with id \(id) not found"))
    }
  }
  
} // 🧱
