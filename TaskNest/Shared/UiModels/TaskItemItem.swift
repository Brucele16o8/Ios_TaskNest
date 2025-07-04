//
//  TaskItemItem.swift
//  TaskNest
//
//  Created by Tung Le on 2/7/2025.
//

import Foundation

struct TaskItemItem: Identifiable, Equatable, Sendable {
  let id: UUID = UUID()
  let title: String
  let isCompleted: Bool
  let createdAt: Date
  let categoryId: UUID
}
