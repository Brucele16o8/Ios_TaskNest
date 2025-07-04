//
//  getPhotoAttachmentUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct GetPhotoAttachmentEntityUseCase {
  private let photoattAchmentRepository: PhotoAttachmentRepository
  
  init(photoattAchmentRepository: PhotoAttachmentRepository) {
    self.photoattAchmentRepository = photoattAchmentRepository
  }
  
  func callAsFunction(id: UUID) async throws -> PhotoAttachmentEntity {
    return try await photoattAchmentRepository.getPhotoAttachmentEntity(by: id)
  }
}
