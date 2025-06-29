//
//  getPhotoAttachmentUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct GetPhotoAttachmentUseCase {
  private let photoattachmentRepository: PhotoAttachmentRepository
  
  init(photoattachmentRepository: PhotoAttachmentRepository) {
    self.photoattachmentRepository = photoattachmentRepository
  }
  
  func callAsFunction(id: UUID) async throws -> PhotoAttachment {
    return try await photoattachmentRepository.getPhotoAttachment(by: id)
  }
}
