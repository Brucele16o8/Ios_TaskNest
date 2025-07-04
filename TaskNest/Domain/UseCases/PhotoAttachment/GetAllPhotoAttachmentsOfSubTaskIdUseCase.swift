//
//  GetAllPhotoAttachmentsOfSubTaskId.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct GetAllPhotoAttachmentEntitiesOfSubTaskId {
  private let photoAttachmentRepository: PhotoAttachmentRepository
  
  init(photoAttachmentRepository: PhotoAttachmentRepository) {
    self.photoAttachmentRepository = photoAttachmentRepository
  }
  
  func callAsFunction(_ subTaskEntityId: UUID) async throws -> [PhotoAttachmentEntity] {
    try await photoAttachmentRepository.getAllPhotoAttachmentEntities(ofSubTaskEntityId: subTaskEntityId)
  }
}
