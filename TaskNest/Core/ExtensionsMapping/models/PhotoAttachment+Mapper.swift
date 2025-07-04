//
//  PhotoAttachment+Mapper.swift
//  TaskNest
//
//  Created by Tung Le on 4/7/2025.
//

extension PhotoAttachment {
  var mapToPhotoAttachmentEntity: PhotoAttachmentEntity {
    get throws {
      return try PhotoAttachmentMapper.fromPhotoAttachmentToEntity(self)
    }
  }
}
