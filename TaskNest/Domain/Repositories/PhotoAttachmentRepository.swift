//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 29/6/2025.
//

import Foundation


protocol PhotoAttachmentRepository {
  func getAll() async throws -> [PhotoAttachment]
  func getPhotoAttachment(by id: UUID) async throws -> PhotoAttachment
  func save(_ photoAttachment: PhotoAttachment) async throws
  func update(_ photoAttachment: PhotoAttachment) async throws
  func delete(id: UUID) async throws
  func getAllPhotoAttachments(ofSubTaskId subTaskId: UUID) async throws -> [PhotoAttachment]
}

