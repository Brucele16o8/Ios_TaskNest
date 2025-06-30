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
  @Relationship(inverse: \TaskItem.subTasks) var task: TaskItem? /// for inverse relationship
  @Relationship(deleteRule: .cascade) var photoAttachments: [PhotoAttachment] = []
  
  init(
    id: UUID = .init(),
    title: String,
    isCompleted: Bool = false,
    createdAt: Date = .now,
    task: TaskItem? = nil
  ) {
    self.id = id
    self.title = title
    self.isCompleted = isCompleted
    self.createdAt = createdAt
    self.task = task
  }
}

extension SubTask {
  static let subTask1 = SubTask(title: "SubTask 1", isCompleted: false, task: .taskItem1)
  static let subTask2 = SubTask(title: "SubTask 2", isCompleted: true, task: .taskItem1)
  static let subTask3 = SubTask(title: "SubTask 1", isCompleted: true, task: .taskItem2)
  
  static var all: [SubTask] = [subTask1, subTask2, subTask3]
}
