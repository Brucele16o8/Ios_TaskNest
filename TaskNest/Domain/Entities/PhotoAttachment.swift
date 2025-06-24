//
//  PhotoAttachment.swift
//  TaskNest
//
//  Created by Tung Le on 21/6/2025.
//

import Foundation
import SwiftData

@Model
class PhotoAttachment: Identifiable {
  @Attribute(.unique) var id: UUID
  var localPath: String?
  var remoteURL: URL?
  @Relationship(inverse: \SubTask.photoAttachments) var subTask: SubTask?
    
  init (
    id: UUID = .init(),
    localPath: String? = nil,
    remoteURL: URL? = nil,
    subTask: SubTask
  ) {
    self.id = id
    self.localPath = localPath
    self.remoteURL = remoteURL
    self.subTask = subTask
  }
}
