//
//  PhotoAttachmentLocalDb.swift
//  TaskNest
//
//  Created by Tung Le on 4/7/2025.
//

import Foundation

protocol PhotoAttachmentLocalDb {
  
  func getAllPhotoAttachmentEntities() async throws -> [PhotoAttachmentEntity]
  func getPhotoAttachmentEntity(byId id: UUID) async throws -> PhotoAttachmentEntity
  func savePhotoAttachmentEntity(_ photoAttachmentEntity: PhotoAttachmentEntity) async throws
  func updatePhotoAttachmentEntity(_ photoAttachmentEntity: PhotoAttachmentEntity) async throws
  func deletePhotoAttachmentEntity(id: UUID) async throws
  func getAllPhotoAttachmentEntities(ofSubTaskId subTaskId: UUID) async throws -> [PhotoAttachmentEntity]
  
}
