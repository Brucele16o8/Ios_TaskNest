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
  
  init(id: UUID = .init(), title: String, createdAt: Date = .now) {
    self.id = id
    self.title = title
    self.createdAt = createdAt
  }
}

extension CategoryEntity {
  static let work = CategoryEntity(title: "Work")
  static let personal = CategoryEntity(title: "Personal")
  static let shopping = CategoryEntity(title: "Shopping")
  static let study = CategoryEntity(title: "Study")
  
  static var all: [CategoryEntity] = [work, personal, shopping, study]
}
