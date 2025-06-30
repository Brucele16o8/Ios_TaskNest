//
//  MockPhotoAttachmentRepository.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

final class MockPhotoAttachmentRepository: PhotoAttachmentRepository {
  func getAll() async throws -> [PhotoAttachment] {
    PhotoAttachment.all
  }
  
  func getPhotoAttachment(by id: UUID) async throws -> PhotoAttachment {
    if let index = PhotoAttachment.all.firstIndex(where: { $0.id == id }) {
      return PhotoAttachment.all[index]
    } else {
      throw AppError.database(.notFound(message: "PhotoAttachment not found for id: \(id)"))
    }
  }
  
  func save(_ photoAttachment: PhotoAttachment) async throws {
    PhotoAttachment.all.append(photoAttachment)
  }
  
  func update(_ photoAttachment: PhotoAttachment) async throws {
    if let index = PhotoAttachment.all.firstIndex(of: photoAttachment) {
      PhotoAttachment.all[index] = photoAttachment
    } else {
      throw AppError.database(.notFound(message: "PhotoAttachment not found for id: \(photoAttachment.id) to update"))
    }
  }
  
  func delete(id: UUID) async throws {
    if let index = PhotoAttachment.all.firstIndex(where: { $0.id == id }) {
      PhotoAttachment.all.remove(at: index)
    } else {
      throw AppError.database(.notFound(message: "PhotoAttachment not found for id: \(id)"))
    }
  }
  
  func getAllPhotoAttachments(ofSubTaskId subTaskId: UUID) async throws -> [PhotoAttachment] {
    return PhotoAttachment.all.filter { $0.subTask?.id == subTaskId }
  }
  
  
}
