//
//  updateCategory.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation

struct UpdateCategoryEntityUserCase {
  private let categoryRepository: CategoryRepository
  
  init(categoryRepository: CategoryRepository) {
    self.categoryRepository = categoryRepository
  }
  
  func callAsFunction(categoryEntity: CategoryEntity) async throws -> Void {
    try await categoryRepository.update(categoryEntity)
  }    
}
