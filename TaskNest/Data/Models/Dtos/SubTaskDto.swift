//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 24/6/2025.
//

import Foundation

struct SubTaskDto: Codable, Identifiable {
  let id: UUID
  let title: String
  let isCompleted: Bool
  let createdAt: Date
  let taskId: UUID // foreign key to TaskItem
}
