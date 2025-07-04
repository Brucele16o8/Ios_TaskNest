//
//  Task.swift
//  TaskNest
//
//  Created by Tung Le on 20/6/2025.
//

import Foundation
import SwiftData

@Model
final class TaskItem {
  @Attribute(.unique) var id: UUID
  var title: String
  var isCompleted: Bool
  var createdAt: Date
  @Relationship(inverse: \Category.tasks) var category: Category?
  @Relationship(deleteRule: .cascade) var subTasks: [SubTask] = []
  
  init(
    id: UUID = .init(),
    title: String,
    isCompleted: Bool = false,
    createdAt: Date = .now,
    category: Category? = nil
  ) {
    self.id = id
    self.title = title
    self.isCompleted = isCompleted
    self.createdAt = createdAt
    self.category = category
  }
}

