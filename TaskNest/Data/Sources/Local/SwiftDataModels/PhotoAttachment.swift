//
//  PhotoAttachment.swift
//  TaskNest
//
//  Created by Tung Le on 21/6/2025.
//

import Foundation
import SwiftData

@Model
class PhotoAttachment {
  @Attribute(.unique) var id: UUID
  var localPath: String?
  var remoteURL: String?
  @Relationship(inverse: \SubTask.photoAttachments) var subTask: SubTask?
  var createdAt: Date
    
  init (
    id: UUID = .init(),
    localPath: String? = nil,
    remoteURL: String? = nil,
    subTask: SubTask? = nil,
    createdAt: Date = Date()
  ) {
    self.id = id
    self.localPath = localPath
    self.remoteURL = remoteURL
    self.subTask = subTask
    self.createdAt = createdAt
  }
}
