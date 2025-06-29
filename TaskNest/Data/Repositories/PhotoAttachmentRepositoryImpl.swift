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
  private let modelContext: ModelContext
  
  init(photoAttachmentRemoteSource: PhotoAttachmentRemoteSource, modelContext: ModelContext) {
    self.photoAttachmentRemoteSource = photoAttachmentRemoteSource
    self.modelContext = modelContext
  }
  
  // ✅
  func getAll() async throws -> [PhotoAttachment] {
    do {
      return try modelContext.fetch(FetchDescriptor<PhotoAttachment>())
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch all photo attachments from database"), underlyingError: error)
    }
  }
  
  // ✅
  func getPhotoAttachment(by id: UUID) async throws -> PhotoAttachment {
    let predicate = #Predicate<PhotoAttachment> { $0.id == id }
    let descriptor = FetchDescriptor<PhotoAttachment>(predicate: predicate)
    
    do {
      guard let photoAttachment = try modelContext.fetch(descriptor).first else {
        throw AppError.database(.notFound(message: "[SwiftData] Photo attachment with id \(id) not found in database"))
      }
      return photoAttachment
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch photo attachment with id \(id) from database"), underlyingError: error)
    }
  }
  
  // ✅
  func save(_ photoAttachment: PhotoAttachment) async throws {
    modelContext.insert(photoAttachment)
    do {
      try modelContext.save()
    } catch {
      throw AppError.database(.saveFailed(message: "[SwiftData] Failed to save photo attachment to database"), underlyingError: error)
    }
  }
  
  // ✅
  func update(_ photoAttachment: PhotoAttachment) async throws {
    do {
      try modelContext.save()
    } catch {
      throw AppError.database(.saveFailed(message: "[SwissData] Failed to update photo attachment to database"), underlyingError: error)
    }
  }
  
  // ✅
  func delete(id: UUID) async throws {
    let predicate = #Predicate<PhotoAttachment> { $0.id == id }
    let descriptor = FetchDescriptor<PhotoAttachment>(predicate: predicate)
    
    do {
      guard let photoAttachmentToDelete = try modelContext.fetch(descriptor).first else {
        throw AppError.database(.notFound(message: "[SwiftData] Photo attachment with id \(id) not found in database"))
      }
      modelContext.delete(photoAttachmentToDelete)
      try modelContext.save()
    } catch {
      throw AppError.database(.deleteFailed(message: "[SwiftData] Failed to delete photo attachment with id \(id) from database"), underlyingError: error)
    }
  }
  
  // ✅
  func getAllPhotoAttachments(ofSubTaskId subTaskId: UUID) async throws -> [PhotoAttachment] {
    let predicate = #Predicate<PhotoAttachment> { $0.subTask?.id == subTaskId }
    let descriptor = FetchDescriptor<PhotoAttachment>(predicate: predicate)
    
    do {
      return try modelContext.fetch(descriptor)
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch photo attachments with SubTask id \(subTaskId)  from database"), underlyingError: error)
    }
  }
  
  
} // 🧱
