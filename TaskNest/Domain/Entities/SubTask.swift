//
//  SubTask.swift
//  TaskNest
//
//  Created by Tung Le on 20/6/2025.
//

import SwiftData
import Foundation

@Model
class SubTask: Identifiable {
  @Attribute(.unique) var id: UUID
  var title: String
  var isCompleted: Bool
  var createdAt: Date
  var task: TaskItem? /// for inverse relationship
  @Relationship(deleteRule: .cascade) var photoAttachments: [PhotoAttachment] = []
  
  init(
    id: UUID = .init(),
    title: String,
    isCompleted: Bool = false,
    createdAt: Date = .now,
    photoAttachments: [PhotoAttachment]
  ) {
    self.id = id
    self.title = title
    self.isCompleted = isCompleted
    self.createdAt = createdAt
    self.task = task
    self.photoAttachments = []
  }
}
