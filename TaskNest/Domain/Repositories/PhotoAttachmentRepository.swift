//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation


protocol PhotoAttachmentRepository {
  func getAll() async throws -> [PhotoAttachmentEntity]
  func getPhotoAttachmentEntity(by id: UUID) async throws -> PhotoAttachmentEntity
  func save(_ photoAttachmentEntity: PhotoAttachmentEntity) async throws
  func update(_ photoAttachmentEntity: PhotoAttachmentEntity) async throws
  func delete(id: UUID) async throws
  func getAllPhotoAttachmentEntities(ofSubTaskEntityId subTaskId: UUID) async throws -> [PhotoAttachmentEntity]
}

