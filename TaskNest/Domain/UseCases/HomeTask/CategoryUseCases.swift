//
//  getAllC.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation

final class CategoryUseCases {
  private let categoryRepository: CategoryRepository
  
  init(categoryRepository: CategoryRepository) {
    self.categoryRepository = categoryRepository
  }
  
  func getAllCategories() async throws -> [Category] {
    try await categoryRepository.getAll()
  }
  
  func getCategory(by id: UUID) async throws -> Category {
    try await categoryRepository.getCategory(by: id)
  }
  
  func save(_ category: Category) async throws {
    try await categoryRepository.save(category)
  }
  
  func update(_ category: Category) async throws {
    try await categoryRepository.update(category)
  }
  
  func delete(id: UUID) async throws {
    try await categoryRepository.delete(id: id)
  }

} // 🧱
