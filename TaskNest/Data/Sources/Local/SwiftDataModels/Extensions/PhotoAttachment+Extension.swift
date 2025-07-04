//
//  PhotoAttachment+Extension.swift
//  TaskNest
//
//  Created by Tung Le on 4/7/2025.
//

import Foundation

extension PhotoAttachment {
  func applyIfChanged(fromPhotoAttachmentEntity photoAttachmentEntity: PhotoAttachmentEntity, newSubTask: SubTask? = nil) -> Bool {
    var didChange = false
    
    if self.localPath != photoAttachmentEntity.localPath {
      self.localPath = photoAttachmentEntity.localPath
      didChange = true
    }
    
    if self.remoteURL != photoAttachmentEntity.remoteURL {
      self.remoteURL = photoAttachmentEntity.remoteURL
      didChange = true
    }
    
    if newSubTask != nil {
      self.subTask = newSubTask!
      didChange = true
    }
    
    return didChange
  }
  
} // 🧱


// MARK: - Preview Data

extension PhotoAttachment {
  static let photo1 = PhotoAttachment(
    localPath: Bundle.main.url(forResource: "Dolomites-Itay", withExtension: "webp")?.path,
    remoteURL: "",
    subTask: SubTask.subTask1
  )
  
  static let photo2 = PhotoAttachment(
    localPath: Bundle.main.url(forResource: "Milan-City-Italy-Canal", withExtension: "webp")?.path,
    remoteURL: "",
    subTask: .subTask1
  )
  
  static var all = [photo1, photo2]
}

