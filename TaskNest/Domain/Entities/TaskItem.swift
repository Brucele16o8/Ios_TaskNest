//
//  Task.swift
//  TaskNest
//
//  Created by Tung Le on 20/6/2025.
//

import Foundation
import SwiftData

@Model
final class Task {
  @Attribute(.unique) var id: UUID
  var title: String
  var isCompleted: Bool
  var createdAt: Date
  var category: Category? /// for inverse relationship
  @Relationship(deleteRule: .cascade) var subTasks: [SubTask] = []
  
  init (
    id: UUID = .init(),
    title: String,
    isCompleted: Bool = false,
    createdAt: Date = .now
  ) {
    self.id = id
    self.title = title
    self.isCompleted = isCompleted
    self.createdAt = createdAt
    self.subTasks = []
  }
}
