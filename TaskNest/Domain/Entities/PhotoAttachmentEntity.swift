//
//  PhotoAttachment.swift
//  TaskNest
//
//  Created by Tung Le on 21/6/2025.
//

import Foundation
import SwiftData

struct PhotoAttachmentEntity: Identifiable {
  let id: UUID
  var localPath: String?
  var remoteURL: String?
  var subTaskID: UUID
  
  init (
    id: UUID = .init(),
    localPath: String? = nil,
    remoteURL: String? = nil,
    subTaskId: UUID
  ) {
    self.id = id
    self.localPath = localPath
    self.remoteURL = remoteURL
    self.subTaskID = subTaskId
  }
}

extension PhotoAttachmentEntity {
  static let photo1 = PhotoAttachmentEntity(
    localPath: Bundle.main.url(forResource: "Dolomites-Itay", withExtension: "webp")?.path,
    remoteURL: "",
    subTaskId: SubTask.subTask1.id
  )
  
  static let photo2 = PhotoAttachmentEntity(
    localPath: Bundle.main.url(forResource: "Milan-City-Italy-Canal", withExtension: "webp")?.path,
    remoteURL: "",
    subTaskId: SubTask.subTask1.id
  )
  
  static var all: [PhotoAttachmentEntity] = [photo1, photo2]
}
