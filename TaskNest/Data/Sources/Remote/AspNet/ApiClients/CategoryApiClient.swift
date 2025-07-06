//
//  CategoryApiImpl.swift
//  TaskNest
//
//  Created by Tung Le on 27/6/2025.
//

import Foundation

class CategoryApiClient: CategoryApi {
  private let networkService: NetworkService
  private let authManager: AuthManager
  
  init(networkService: NetworkService, authManager: AuthManager) {
    self.networkService = networkService
    self.authManager = authManager
  }
  
  func getAllCategories() async throws -> [CategoryDto] {
    try await networkService.request(
      endpoint: "/api/category/all",
      method: .getMethod,
      body: Optional<Data>.none,
      headers: [:],
      authToken: nil,
      customURL: nil,
    )
  }
  
  func getCategory(by id: UUID) async throws -> CategoryDto {
    try await networkService.request(
      endpoint: "api/category/\(id)",
      method: .getMethod,
      body: Optional<Data>.none,
      headers: [:],
      authToken: nil,
      customURL: nil,
      )
  }
  
  func createCategory(_ categoryDto: CategoryDto) async throws {
    try await networkService.requestWithoutResponse(
      endpoint: "api/category",
      method: .postMethod,
      body: categoryDto,
      headers: [:],
      authToken: authManager.authToken,
      customURL: nil,
    )
  }
  
  func updateCategory(_ categoryDto: CategoryDto) async throws {
    try await networkService.requestWithoutResponse(
      endpoint: "api/category",
      method: .putMethod,
      body: categoryDto,
      headers: [:],
      authToken: authManager.authToken,
      customURL: nil,
    )
  }
  
  func deleteCategory(id: UUID) async throws {
    try await networkService.requestWithoutResponse(
      endpoint: "api/category/\(id)",
      method: .deleteMethod,
      body: Optional<Data>.none,
      headers: [:],
      authToken: authManager.authToken,
      customURL: nil,
    )
  }
  
  
}
