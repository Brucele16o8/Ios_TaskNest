//
//  GetAllPhotoAttachmentsOfSubTaskId.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct GetAllPhotoAttachmentsOfSubTaskId {
  private let photoAttachmentRepository: PhotoAttachmentRepository
  
  init(photoAttachmentRepository: PhotoAttachmentRepository) {
    self.photoAttachmentRepository = photoAttachmentRepository
  }
  
  func callAsFunction(_ subTaskId: UUID) async throws -> [PhotoAttachment] {
    try await photoAttachmentRepository.getAllPhotoAttachments(ofSubTaskId: subTaskId)
  }
}
