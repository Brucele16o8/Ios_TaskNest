//
//  DeletePhotoAttachmentUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct DeletePhotoAttachmentUseCase {
  private let photoAttachmentRepository: PhotoAttachmentRepository
  
  init(photoAttachmentRepository: PhotoAttachmentRepository) {
    self.photoAttachmentRepository = photoAttachmentRepository
  }
  
  func callAsFunction(id: UUID) async throws {
    try await photoAttachmentRepository.delete(id: id)
  }
}
