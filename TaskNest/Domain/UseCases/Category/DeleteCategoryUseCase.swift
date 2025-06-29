//
//  deleteCategoryUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation

struct DeleteCategoryUseCase {
  private let categoryrepository: CategoryRepository
  
  init(categoryrepository: CategoryRepository) {
    self.categoryrepository = categoryrepository
  }
  
  func callAsFunction(id: UUID) async throws {
    try await categoryrepository.delete(id: id)
  }
}
