//
//  Category.swift
//  TaskNest
//
//  Created by Tung Le on 9/6/2025.
//

import Foundation
import SwiftData

@Model
class Category: Identifiable {
  @Attribute(.unique) var id: UUID
  var title: String
  var createdAt: Date
  @Relationship(deleteRule: .cascade) var tasks: [TaskItem] = []
  
  init(id: UUID = .init(), title: String, createdAt: Date = .now) {
    self.id = id
    self.title = title
    self.createdAt = createdAt
  }
}


extension Category {
  static let work = Category(title: "Work")
  static let personal = Category(title: "Personal")
  static let shopping = Category(title: "Shopping")
  static let study = Category(title: "Study")
  
  static let all: [Category] = [work, personal, shopping, study]
}
