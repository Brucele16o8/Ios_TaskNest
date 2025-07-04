//
//  SavePhotoAttachmentUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct SavePhotoAttachmentEntityUseCase {
  private let photoAttachmentRepository: PhotoAttachmentRepository
  
  init(photoAttachmentRepository: PhotoAttachmentRepository) {
    self.photoAttachmentRepository = photoAttachmentRepository
  }
  
  func callAsFunction(photoAttachment: PhotoAttachmentEntity) async throws {
    try await photoAttachmentRepository.save(photoAttachment)
  }
}
