//
//  SubTask.swift
//  TaskNest
//
//  Created by Tung Le on 20/6/2025.
//

import SwiftData
import Foundation

class SubTaskEntity: Identifiable {
  let id: UUID
  var title: String
  var isCompleted: Bool
  var createdAt: Date
  var taskId: UUID
  
  init(
    id: UUID = .init(),
    title: String,
    isCompleted: Bool = false,
    createdAt: Date = .now,
    taskId: UUID
  ) {
    self.id = id
    self.title = title
    self.isCompleted = isCompleted
    self.createdAt = createdAt
    self.taskId = taskId
  }
}

extension SubTaskEntity {
  static let subTask1 = SubTaskEntity(title: "SubTask 1", isCompleted: false, taskId: UUID())
  static let subTask2 = SubTaskEntity(title: "SubTask 2", isCompleted: true, taskId: TaskItem.taskItem1.id)
  static let subTask3 = SubTaskEntity(title: "SubTask 1", isCompleted: true, taskId: TaskItem.taskItem2.id)
  
  static var all: [SubTaskEntity] = [subTask1, subTask2, subTask3]
}
