//
//  SubTask.swift
//  TaskNest
//
//  Created by Tung Le on 20/6/2025.
//

import SwiftData
import Foundation

@Model
class SubTask {
  @Attribute(.unique) var id: UUID
  var title: String
  var isCompleted: Bool
  var createdAt: Date
  @Relationship(inverse: \TaskItem.subTasks) var taskItem: TaskItem? /// for inverse relationship
  @Relationship(deleteRule: .cascade) var photoAttachments: [PhotoAttachment] = []
  
  init(
    id: UUID = .init(),
    title: String,
    isCompleted: Bool = false,
    createdAt: Date = .now,
    taskItem: TaskItem? = nil
  ) {
    self.id = id
    self.title = title
    self.isCompleted = isCompleted
    self.createdAt = createdAt
    self.taskItem = taskItem
  }
}
