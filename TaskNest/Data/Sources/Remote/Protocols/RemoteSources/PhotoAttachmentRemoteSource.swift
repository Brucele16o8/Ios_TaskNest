//
//  PhotoAttachmentRemoteSource.swift
//  TaskNest
//
//  Created by Tung Le on 27/6/2025.
//

import Foundation

protocol PhotoAttachmentRemoteSource {
  func getAllPhotoAttachments() async throws -> [PhotoAttachmentDto]
  func getPhotoAttachment(by id: UUID) async throws -> PhotoAttachmentDto
  func createPhotoAttachment(_ photoAttachmentDto: PhotoAttachmentDto) async throws
  func updatePhotoAttachment(_ photoAttachmentDto: PhotoAttachmentDto) async throws
  func deletePhotoAttachment(id: UUID) async throws
  func getPhotoAttachmentsBySubTaskId(_ subTaskId: UUID) async throws -> [PhotoAttachmentDto]
}

