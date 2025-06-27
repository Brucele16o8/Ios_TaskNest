//
//  TaskItemRemoteSourceImpl.swift
//  TaskNest
//
//  Created by Tung Le on 27/6/2025.
//

import Foundation

class CategoryRemoteSourceImpl: CategoryRemoteSource {
  private let categoryApi: CategoryApi
  
  init(categoryApi: CategoryApi) {
    self.categoryApi = categoryApi
  }

  
  func getAllCategories() async throws -> [CategoryDto] {
    try await categoryApi.getAllCategories()
  }
  
  func getCategory(by id: UUID) async throws -> CategoryDto {
    try await categoryApi.getCategory(by: id)
  }
  
  func createCategory(_ categoryDto: CategoryDto) async throws {
    try await categoryApi.createCategory(categoryDto)
  }
  
  func updateCategory(_ categoryDto: CategoryDto) async throws {
    try await categoryApi.updateCategory(categoryDto)
  }
  
  func deleteCategory(id: UUID) async throws {
    try await categoryApi.deleteCategory(id: id)
  }
  
}
