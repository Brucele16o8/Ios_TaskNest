//
//  getCategoryUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation

struct GetCategoryEntityUseCase {
  private let categoryRepository: CategoryRepository
  
  init(categoryRepository: CategoryRepository) {
    self.categoryRepository = categoryRepository
  }
  
  func callAsFunction(id: UUID) async throws -> CategoryEntity {
    try await categoryRepository.getCategoryEntity(by: id)
  }
}
