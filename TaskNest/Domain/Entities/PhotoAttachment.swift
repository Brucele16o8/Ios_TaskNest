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
  var remoteURL: String?
  @Relationship(inverse: \SubTask.photoAttachments) var subTask: SubTask?
    
  init (
    id: UUID = .init(),
    localPath: String? = nil,
    remoteURL: String? = nil,
    subTask: SubTask? = nil
  ) {
    self.id = id
    self.localPath = localPath
    self.remoteURL = remoteURL
    self.subTask = subTask
  }
}

extension PhotoAttachment {
  static let photo1 = PhotoAttachment(
    localPath: Bundle.main.url(forResource: "Dolomites-Itay", withExtension: "webp")?.path,
    remoteURL: "",
    subTask: .subTask1
  )
  
  static let photo2 = PhotoAttachment(
    localPath: Bundle.main.url(forResource: "Milan-City-Italy-Canal", withExtension: "webp")?.path,
    remoteURL: "",
    subTask: .subTask1
  )
  
  static var all = [photo1, photo2]
}
