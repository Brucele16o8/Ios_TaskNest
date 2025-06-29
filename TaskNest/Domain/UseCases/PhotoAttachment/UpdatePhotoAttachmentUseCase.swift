//
//  UpdatePhotoAttachmentUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct UpdatePhotoAttachmentUseCase {
  private let photoAttachmentRepository: PhotoAttachmentRepository
  
  init(photoAttachmentRepository: PhotoAttachmentRepository) {
    self.photoAttachmentRepository = photoAttachmentRepository
  }
  
  func callAsFunction(_ photoAttachment: PhotoAttachment) async throws {
    try await photoAttachmentRepository.update(photoAttachment)
  }
}
