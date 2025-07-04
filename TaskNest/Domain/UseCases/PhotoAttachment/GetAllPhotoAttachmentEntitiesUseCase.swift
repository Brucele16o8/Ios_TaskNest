//
//  getAllPhotoAttachmentsUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct GetAllPhotoAttachmentEntitiesUseCase {
  private let photoAttachmentRepository: PhotoAttachmentRepository
  
  init(photoAttachmentRepository: PhotoAttachmentRepository) {
    self.photoAttachmentRepository = photoAttachmentRepository
  }
  
  func callAsFunction() async throws -> [PhotoAttachmentEntity] {
    return try await photoAttachmentRepository.getAll()
  }
}
