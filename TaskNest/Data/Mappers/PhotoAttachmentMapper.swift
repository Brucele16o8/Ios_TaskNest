//
//  PhotoAttachmentMapper.swift
//  TaskNest
//
//  Created by Tung Le on 25/6/2025.
//

import Foundation
import SwiftData

enum PhotoAttachmentMapper {
  // From Dto
//  static func fromDTOs(_ dtos: [PhotoAttachmentDto], subtaskMap: [UUID : SubTask]) -> [PhotoAttachment] {
//    dtos.compactMap { dto -> PhotoAttachment? in
//      guard let subtask = subtaskMap[dto.subTaskId] else { return nil }
//      return PhotoAttachment(
//        id: dto.id,
//        localPath: dto.localPath,
//        remoteURL: dto.remoteURL,
//      )
//    }
//  }
  
  // From PhotoAttachment
  static func fromPhotoAttachmentToEntity(_ photoAttachment: PhotoAttachment) throws -> PhotoAttachmentEntity {
    guard let subTaskId = photoAttachment.subTask?.id else {
      throw AppError.database(.missingParent(message: "PhotoAtttachment is missing linked subTask parent -> Coversion to PhotoattachmentEntity failed"))
    }
    
    return PhotoAttachmentEntity(
      id: photoAttachment.id,
      localPath: photoAttachment.localPath,
      remoteURL: photoAttachment.remoteURL,
      subTaskId: subTaskId,
      createdAt: photoAttachment.createdAt
    )
  }
  
  // From PhotoAttachment Entity
  static func fromEntityToPhotoAttachment(_ entity: PhotoAttachmentEntity) -> PhotoAttachment {
    PhotoAttachment(
      id: entity.id,
      localPath: entity.localPath,
      remoteURL: entity.remoteURL,
      createdAt: entity.createdAt
    )
  }
  
  static func fromEntityToItem(_ entity: PhotoAttachmentEntity) -> PhotoAttachmentItem {
    PhotoAttachmentItem(
      id: entity.id,
      localPath: entity.localPath,
      remoteURL: entity.remoteURL,
      subTaskID: entity.subTaskID,
      createdAt: entity.createdAt
    )
  }
  
} // 🧱
