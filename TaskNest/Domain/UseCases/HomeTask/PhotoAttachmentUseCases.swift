//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation

final class PhotoAttachmentUseCases {
  private var photoAttachmentRepository: PhotoAttachmentRepository
  
  init(photoAttachmentRepository: PhotoAttachmentRepository) {
    self.photoAttachmentRepository = photoAttachmentRepository
  }
  
  func getAll() async throws -> [PhotoAttachment] {
    try await photoAttachmentRepository.getAll()
  }
  
  func getPhotoAttachment(by id: UUID) async throws -> PhotoAttachment {
    try await photoAttachmentRepository.getPhotoAttachment(by: id)
  }
  
  func save(_ photoAttachment: PhotoAttachment) async throws {
    try await photoAttachmentRepository.save(photoAttachment)
  }
  
  func update(_ photoAttachment: PhotoAttachment) async throws {
    try await photoAttachmentRepository.update(photoAttachment)
  }
  
  func delete(id: UUID) async throws {
    try await photoAttachmentRepository.delete(id: id)
  }
  
   func getAllPhotoAttachments(ofSubTaskId subTaskId: UUID) async throws -> [PhotoAttachment] {
    try await photoAttachmentRepository.getAllPhotoAttachments(ofSubTaskId: subTaskId)
  }
} // 🧱


