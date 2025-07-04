//
//  PhotoAttachmentEntiry+Mapper.swift
//  TaskNest
//
//  Created by Tung Le on 4/7/2025.
//

extension PhotoAttachmentEntity {
  var mapToPhotoAttachment: PhotoAttachment {
    PhotoAttachmentMapper.fromEntityToPhotoAttachment(self)
  }
}
