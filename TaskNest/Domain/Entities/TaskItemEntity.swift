//
//  Task.swift
//  TaskNest
//
//  Created by Tung Le on 20/6/2025.
//

import Foundation
import SwiftData

struct TaskItemEntity {
  let id: UUID
  var title: String
  var isCompleted: Bool
  var createdAt: Date
  var categoryId: UUID
  var userId: String
  
  init(
    id: UUID = .init(),
    title: String,
    isCompleted: Bool = false,
    createdAt: Date = .now,
    categoryId: UUID,
    userId: String
  ) {
    self.id = id
    self.title = title
    self.isCompleted = isCompleted
    self.createdAt = createdAt
    self.categoryId = categoryId
    self.userId = userId
  }
}

extension TaskItemEntity {
  static let taskItem1 = TaskItemEntity(title: "Task 1", isCompleted: false, categoryId: CategoryEntity.work.id, userId: "116688")
  static let taskItem2 = TaskItemEntity(title: "Task 2", isCompleted: true, categoryId: CategoryEntity.work.id, userId: "116688")
  static let taskItem3 = TaskItemEntity(title: "Task 3", isCompleted: false, categoryId: CategoryEntity.work.id, userId: "116688")
  static let taskItem4 = TaskItemEntity(title: "Task 1", isCompleted: false, categoryId: CategoryEntity.personal.id, userId: "116688")
  static let taskItem5 = TaskItemEntity(title: "Task 2", isCompleted: false, categoryId: CategoryEntity.personal.id, userId: "116688")
  
  static var all: [TaskItemEntity] = [taskItem1, taskItem2, taskItem3, taskItem4, taskItem5]
}
