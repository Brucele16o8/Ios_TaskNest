//
//  AppModelActor+AppModelActor.swift
//  TaskNest
//
//  Created by Tung Le on 4/7/2025.
//

import Foundation
import SwiftData

extension AppModelActor: PhotoAttachmentLocalDb {
  
  // ✅
  func getAllPhotoAttachmentEntities() async throws -> [PhotoAttachmentEntity] {
    do {
      let photoAttachments = try modelContext.fetch(FetchDescriptor<PhotoAttachment>())
      return try photoAttachments.map { try $0.mapToPhotoAttachmentEntity }
    } catch let appError as AppError{
      throw appError
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch all photo attachments from database"), underlyingError: error)
    }
  }
  
  // ✅
  func getPhotoAttachmentEntity(byId id: UUID) async throws -> PhotoAttachmentEntity {
    do {
      let photoAttachment = try await getPhotoAttachment(byId: id)
      return try photoAttachment.mapToPhotoAttachmentEntity
    } catch let appError as AppError {
      throw appError
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch photo attachment with id: \(id)"), underlyingError: error)
    }
  }
  
  // ++ helper
  func getPhotoAttachment(byId id: UUID) async throws -> PhotoAttachment {
    let predicate = #Predicate<PhotoAttachment> { $0.id == id }
    let descriptor = FetchDescriptor<PhotoAttachment>(predicate: predicate)
    
    do {
      guard let photoAttachment = try modelContext.fetch(descriptor).first else {
        throw AppError.database(.notFound(message: "[SwiftData] Photo attachment not found with id: \(id)"))
      }
      return photoAttachment
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch photo attachment with id: \(id)"), underlyingError: error)
    }
  }
  
  // ✅
  func savePhotoAttachmentEntity(_ photoAttachmentEntity: PhotoAttachmentEntity) async throws {
    do {
      let subTask = try await getSubTask(by: photoAttachmentEntity.subTaskID)
      let photoAttachment = photoAttachmentEntity.mapToPhotoAttachment
      photoAttachment.subTask = subTask
      try modelContext.save()
    } catch let appError as AppError {
      throw appError
    } catch {
      throw AppError.database(.saveFailed(message: "[SwiftData] Failed to save photo attachment"), underlyingError: error)
    }
  }
  
  // ✅
  func updatePhotoAttachmentEntity(_ photoAttachmentEntity: PhotoAttachmentEntity) async throws {
    var newSubTask: SubTask? = nil
    do {
      let photoAttachment = try await getPhotoAttachment(byId: photoAttachmentEntity.id)
      
      if photoAttachment.subTask?.id != photoAttachmentEntity.subTaskID {
        newSubTask = try await getSubTask(by: photoAttachmentEntity.subTaskID)
      }
      
      if photoAttachment.applyIfChanged(fromPhotoAttachmentEntity: photoAttachmentEntity, newSubTask: newSubTask) {
        try modelContext.save()
      }
    } catch let appError as AppError {
      throw appError
    } catch {
      throw AppError.database(.saveFailed(message: "[SwiftData] Failed to save photo attachment with id \(photoAttachmentEntity.id)"), underlyingError: error)
    }
  }
  
  // ✅
  func deletePhotoAttachmentEntity(id: UUID) async throws {
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
  func getAllPhotoAttachmentEntities(ofSubTaskId subTaskId: UUID) async throws -> [PhotoAttachmentEntity] {
    let predicate = #Predicate<PhotoAttachment> { $0.subTask?.id == subTaskId }
    let descriptor = FetchDescriptor<PhotoAttachment>(predicate: predicate)
    
    do {
      let photoAttachments = try modelContext.fetch(descriptor)
      return try photoAttachments.map { try $0.mapToPhotoAttachmentEntity }
    } catch let appError as AppError {
      throw appError
    } catch {
      throw AppError.database(.fetchFailed(message: "[SwiftData] Failed to fetch photo attachments with SubTask id \(subTaskId)  from database"), underlyingError: error)
    }
  }
  
} // 🧱

