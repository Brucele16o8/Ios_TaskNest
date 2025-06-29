//
//  getAllCategories.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation

struct GetAllCategoriesUseCase {
  private let categoryRepository: CategoryRepository
  
  init(categoryRepository: CategoryRepository) {
    self.categoryRepository = categoryRepository
  }
  
  func callAsFunction() async throws -> [Category] {
    try await categoryRepository.getAll()
  }
}
