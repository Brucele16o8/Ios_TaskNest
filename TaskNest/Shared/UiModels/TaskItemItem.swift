//
//  TaskItemItem.swift
//  TaskNest
//
//  Created by Tung Le on 2/7/2025.
//

import Foundation

struct TaskItemItem: Identifiable, Equatable, Sendable, Hashable {
  let id: UUID = UUID()
  var title: String
  var isCompleted: Bool
  let createdAt: Date
  let categoryId: UUID
  let userId: String
}
