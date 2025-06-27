//
//  CategoryRemoteSource.swift
//  TaskNest
//
//  Created by Tung Le on 27/6/2025.
//

import Foundation

protocol CategoryRemoteSource {
  func getAllCategories() async throws -> [CategoryDto]
  func getCategory(by id: UUID) async throws -> CategoryDto
  func createCategory(_ categoryDto: CategoryDto) async throws
  func updateCategory(_ categoryDto: CategoryDto) async throws
  func deleteCategory(id: UUID) async throws
}
