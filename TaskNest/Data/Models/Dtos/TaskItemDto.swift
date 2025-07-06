//
//  TaskItemDTO.swift
//  TaskNest
//
//  Created by Tung Le on 24/6/2025.
//

import Foundation

struct TaskItemDto: Codable, Identifiable {
  let id: UUID
  let title: String
  let isCompleted: Bool
  let createdAt: Date
  let categoryId: UUID // foreign key to Category
  let userId: String
}
