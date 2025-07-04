//
//  CategoryModelActor.swift
//  TaskNest
//
//  Created by Tung Le on 2/7/2025.
//

import Foundation

protocol CategoryLocalDb {
  func getAllCategoryEntities() async throws -> [CategoryEntity]
  func getCategoryEntity(ofId id: UUID) async throws -> CategoryEntity
  func saveCategoryEntity(_ categoryEntity: CategoryEntity) async throws
  func updateCategoryEntity(_ categoryEntity: CategoryEntity) async throws
  func deleteCategoryEntity(id: UUID) async throws 
}
