//
//  MockPhotoAttachmentRepository.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

final class MockPhotoAttachmentRepository: PhotoAttachmentRepository {
  
  func getAll() async throws -> [PhotoAttachmentEntity] {
    try PhotoAttachment.all.map { try $0.mapToPhotoAttachmentEntity }
  }
  
  func getPhotoAttachmentEntity(by id: UUID) async throws -> PhotoAttachmentEntity {
    if let index = PhotoAttachment.all.firstIndex(where: { $0.id == id }) {
      return try PhotoAttachment.all[index].mapToPhotoAttachmentEntity
    } else {
      throw AppError.database(.notFound(message: "PhotoAttachment not found for id: \(id)"))
    }
    // wrong - change later
  }
  
  func save(_ photoAttachmentEntity: PhotoAttachmentEntity) async throws {
    let photoAttachment = photoAttachmentEntity.mapToPhotoAttachment
    PhotoAttachment.all.append(photoAttachment)
    // wrong - change later
  }
  
  func update(_ photoAttachmentEntity: PhotoAttachmentEntity) async throws {
    let photoAttachment = photoAttachmentEntity.mapToPhotoAttachment
    if let index = PhotoAttachment.all.firstIndex(of: photoAttachment) {
      PhotoAttachment.all[index] = photoAttachment
    } else {
      throw AppError.database(.notFound(message: "PhotoAttachment not found for id: \(photoAttachment.id) to update"))
    }
    // wrong - change later
  }
  
  func delete(id: UUID) async throws {
    if let index = PhotoAttachment.all.firstIndex(where: { $0.id == id }) {
      PhotoAttachment.all.remove(at: index)
    } else {
      throw AppError.database(.notFound(message: "PhotoAttachment not found for id: \(id)"))
    }
    // wrong - change later
  }
  
  func getAllPhotoAttachmentEntities(ofSubTaskEntityId subTaskId: UUID) async throws -> [PhotoAttachmentEntity] {
    return try PhotoAttachment.all.filter { $0.subTask?.id == subTaskId }.map { try $0.mapToPhotoAttachmentEntity }
    // wrong - change later
  }
  
}
