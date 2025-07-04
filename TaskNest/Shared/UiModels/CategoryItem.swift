//
//  CategoryItem.swift
//  TaskNest
//
//  Created by Tung Le on 2/7/2025.
//

import Foundation

struct CategoryItem: Identifiable, Equatable, Sendable, Hashable {
  let id: UUID
  let title: String
  let createdAt: Date
  
  init(id: UUID = .init(), title: String, createdAt: Date = Date()) {
    self.id = id
    self.title = title
    self.createdAt = createdAt
  }
}


