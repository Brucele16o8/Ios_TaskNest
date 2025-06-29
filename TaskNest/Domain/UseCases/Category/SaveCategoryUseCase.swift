//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation

struct SaveCategoryUseCase {
  private let categoryRepository: CategoryRepository
  
  init(categoryRepository: CategoryRepository) {
    self.categoryRepository = categoryRepository
  }
  
  func callAsFunction(_ category: Category) async throws -> Void {
    try await categoryRepository.save(category)
  }
}
