//
//  getCategoryUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation

struct GetCategoryUseCase {
  private let categoryRepository: CategoryRepository
  
  init(categoryRepository: CategoryRepository) {
    self.categoryRepository = categoryRepository
  }
  
  func callAsFunction(id: UUID) async throws -> Category {
    try await categoryRepository.getCategory(by: id)
  }
}
