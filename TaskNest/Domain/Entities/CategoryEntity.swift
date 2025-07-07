//
//  Category.swift
//  TaskNest
//
//  Created by Tung Le on 9/6/2025.
//

import Foundation
import SwiftData

struct CategoryEntity: Identifiable {
  let id: UUID
  var title: String
  var createdAt: Date
  var userId: String
  
  init(id: UUID = .init(), title: String, createdAt: Date = .now, userId: String) {
    self.id = id
    self.title = title
    self.createdAt = createdAt
    self.userId = userId
  }
}

extension CategoryEntity {
  static let work = CategoryEntity(title: "Work", userId: "116688")
  static let personal = CategoryEntity(title: "Personal", userId: "116688")
  static let shopping = CategoryEntity(title: "Shopping", userId: "116688")
  static let study = CategoryEntity(title: "Study", userId: "116688")
  
  static var all: [CategoryEntity] = [work, personal, shopping, study]
}
