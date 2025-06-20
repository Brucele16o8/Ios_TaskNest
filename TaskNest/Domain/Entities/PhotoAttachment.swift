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
  var subTask: SubTask?
    
  init (
    id: UUID = .init(),
    localPath: String? = nil,
    remoteURL: URL? = nil
  ) {
    self.id = id
    self.localPath = localPath
    self.remoteURL = remoteURL
  }
}
