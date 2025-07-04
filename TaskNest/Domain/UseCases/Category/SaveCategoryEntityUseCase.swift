//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation

struct SaveCategoryEntityUseCase {
  private let categoryRepository: CategoryRepository
  
  init(categoryRepository: CategoryRepository) {
    self.categoryRepository = categoryRepository
  }
  
  func callAsFunction(_ categoryEntity: CategoryEntity) async throws -> Void {
    try await categoryRepository.save(categoryEntity)
  }
}
