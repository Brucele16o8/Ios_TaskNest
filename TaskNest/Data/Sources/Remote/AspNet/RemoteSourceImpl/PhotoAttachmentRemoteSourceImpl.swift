//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 27/6/2025.
//

import Foundation

class PhotoAttachmentRemoteSourceImpl: PhotoAttachmentRemoteSource {
  private let photoAttachmentApi: PhotoAttachmentApi
  
  init(phpotAttachmentApi: PhotoAttachmentApi) {
    self.photoAttachmentApi = phpotAttachmentApi
  }
  
  func getAllPhotoAttachments() async throws -> [PhotoAttachmentDto] {
    try await photoAttachmentApi.getAllPhotoAttachments()
  }
  
  func getPhotoAttachment(by id: UUID) async throws -> PhotoAttachmentDto {
    try await photoAttachmentApi.getPhotoAttachment(by: id)
  }
  
  func createPhotoAttachment(_ photoAttachmentDto: PhotoAttachmentDto) async throws {
    try await photoAttachmentApi.createPhotoAttachment(photoAttachmentDto)
  }
  
  func updatePhotoAttachment(_ photoAttachmentDto: PhotoAttachmentDto) async throws {
    try await photoAttachmentApi.updatePhotoAttachment(photoAttachmentDto)
  }
  
  func deletePhotoAttachment(id: UUID) async throws {
    try await photoAttachmentApi.deletePhotoAttachment(id: id)
  }
  
  func getPhotoAttachmentsBySubTaskId(_ subTaskId: UUID) async throws -> [PhotoAttachmentDto] {
    try await photoAttachmentApi.getPhotoAttachmentsBySubTaskId(subTaskId)
  }
  
  
}
