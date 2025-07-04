//
//  PhotoAttachmentRepository.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation
import SwiftData

final class PhotoAttachmentRepositoryImpl: PhotoAttachmentRepository {
  private let photoAttachmentRemoteSource: PhotoAttachmentRemoteSource
  private let photoAttachmentLocalDb: PhotoAttachmentLocalDb
  
  init(photoAttachmentRemoteSource: PhotoAttachmentRemoteSource, photoAttachmentLocalDb: PhotoAttachmentLocalDb) {
    self.photoAttachmentRemoteSource = photoAttachmentRemoteSource
    self.photoAttachmentLocalDb = photoAttachmentLocalDb
  }
  
  // ✅
  func getAll() async throws -> [PhotoAttachmentEntity] {
    return try await photoAttachmentLocalDb.getAllPhotoAttachmentEntities()
  }
  
  // ✅
  func getPhotoAttachmentEntity(by id: UUID) async throws -> PhotoAttachmentEntity {
    return try await photoAttachmentLocalDb.getPhotoAttachmentEntity(byId: id)
  }
  
  // ✅
  func save(_ photoAttachmentEntity: PhotoAttachmentEntity) async throws {
    try await photoAttachmentLocalDb.savePhotoAttachmentEntity(photoAttachmentEntity)
  }
  
  // ✅
  func update(_ photoAttachmentEntity: PhotoAttachmentEntity) async throws {
    try await photoAttachmentLocalDb.updatePhotoAttachmentEntity(photoAttachmentEntity)
  }
  
  // ✅
  func delete(id: UUID) async throws {
    try await photoAttachmentLocalDb.deletePhotoAttachmentEntity(id: id)
  }
  
  // ✅
  func getAllPhotoAttachmentEntities(ofSubTaskEntityId subTaskId: UUID) async throws -> [PhotoAttachmentEntity] {
    return try await photoAttachmentLocalDb.getAllPhotoAttachmentEntities(ofSubTaskId: subTaskId)
  }
  
} // 🧱
