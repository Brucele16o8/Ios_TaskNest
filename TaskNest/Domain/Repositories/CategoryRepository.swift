//
//  CategoryRepository.swift
//  TaskNest
//
//  Created by Tung Le on 28/6/2025.
//

import Foundation

protocol CategoryRepository {
    func getAll() async throws -> [CategoryEntity]
    func getCategoryEntity(by id: UUID) async throws -> CategoryEntity
    func save(_ categoryEntity: CategoryEntity) async throws
    func update(_ categoryEntity: CategoryEntity) async throws
    func delete(id: UUID) async throws
}
