//
//  Category.swift
//  TaskNest
//
//  Created by Tung Le on 9/6/2025.
//

import Foundation
import SwiftData

@Model
class Category {
  @Attribute(.unique) var id: UUID
  var title: String
  var createdAt: Date
  var userId: String
  @Relationship(deleteRule: .cascade) var tasks: [TaskItem] = []
  
  init(id: UUID = .init(), title: String, createdAt: Date = .now, userId: String) {
    self.id = id
    self.title = title
    self.createdAt = createdAt
    self.userId = userId
  }
}
