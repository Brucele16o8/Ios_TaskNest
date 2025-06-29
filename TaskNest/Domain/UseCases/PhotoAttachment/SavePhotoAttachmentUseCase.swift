//
//  SavePhotoAttachmentUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct SavePhotoAttachmentUseCase {
  private let photoAttachmentRepository: PhotoAttachmentRepository
  
  init(photoAttachmentRepository: PhotoAttachmentRepository) {
    self.photoAttachmentRepository = photoAttachmentRepository
  }
  
  func callAsFunction(photoAttachment: PhotoAttachment) async throws {
    try await photoAttachmentRepository.save(photoAttachment)
  }
}
