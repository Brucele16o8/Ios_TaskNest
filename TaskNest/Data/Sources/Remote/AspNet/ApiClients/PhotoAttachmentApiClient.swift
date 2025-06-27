//
//  PhotoAttachmentApiClient.swift
//  TaskNest
//
//  Created by Tung Le on 27/6/2025.
//

import Foundation

class PhotoAttachmentApiClient: PhotoAttachmentApi {
  private let networkService: NetworkService
  private let authManager: AuthManager
  
  init(networkService: NetworkService, authManager: AuthManager) {
    self.networkService = networkService
    self.authManager = authManager
  }
  
  func getAllPhotoAttachments() async throws -> [PhotoAttachmentDto] {
    try await networkService.request(
      endpoint: "api/photo-attachment/all",
      method: .getMethod,
      body: Optional<Data>.none,
      headers: [:],
      authToken: nil
    )
  }
  
  func getPhotoAttachment(by id: UUID) async throws -> PhotoAttachmentDto {
    try await networkService.request(
      endpoint: "api/photo-attachment/\(id)",
      method: .getMethod,
      body: Optional<Data>.none,
      headers: [:],
      authToken: nil
    )
  }
  
  func createPhotoAttachment(_ photoAttachmentDto: PhotoAttachmentDto) async throws {
    try await networkService.requestWithoutResponse(
      endpoint: "api/photo-attachment",
      method: .postMethod,
      body: photoAttachmentDto,
      headers: [:],
      authToken: authManager.authToken
    )
  }
  
  func updatePhotoAttachment(_ photoAttachmentDto: PhotoAttachmentDto) async throws {
    try await networkService.requestWithoutResponse(
      endpoint: "api/photo-attachment",
      method: .putMethod,
      body: photoAttachmentDto,
      headers: [:],
      authToken: authManager.authToken
    )
  }
  
  func deletePhotoAttachment(id: UUID) async throws {
    try await networkService.requestWithoutResponse(
      endpoint: "api/photo-attachment/\(id)",
      method: .deleteMethod,
      body: Optional<Data>.none,
      headers: [:],
      authToken: authManager.authToken
    )
  }
  
  func getPhotoAttachmentsBySubTaskId(_ subTaskId: UUID) async throws -> [PhotoAttachmentDto] {
    try await networkService.request(
      endpoint: "api/photo-attachment/subtask/\(subTaskId)",
      method: .getMethod,
      body: Optional<Data>.none,
      headers: [:],
      authToken: nil
    )
  }
  
  
}
