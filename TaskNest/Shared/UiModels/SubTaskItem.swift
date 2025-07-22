//
//  SubTaskItem.swift
//  TaskNest
//
//  Created by Tung Le on 2/7/2025.
//

import Foundation

struct SubTaskItem: Identifiable, Equatable, Sendable {
  let id: UUID
  var title: String
  var isCompleted: Bool
  let createdAt: Date
  let taskId: UUID
}
