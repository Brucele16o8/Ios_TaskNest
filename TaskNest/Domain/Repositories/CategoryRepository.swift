//
//  CategoryRepository.swift
//  TaskNest
//
//  Created by Tung Le on 28/6/2025.
//

import Foundation

protocol CategoryRepository {
    func getAll() async throws -> [Category]
    func getCategory(by id: UUID) async throws -> Category
    func save(_ category: Category) async throws
    func update(_ category: Category) async throws
    func delete(id: UUID) async throws
}
