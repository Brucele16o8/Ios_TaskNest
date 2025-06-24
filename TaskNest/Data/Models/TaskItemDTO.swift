//
//  TaskItemDTO.swift
//  TaskNest
//
//  Created by Tung Le on 24/6/2025.
//

import Foundation

struct TaskItemDTO: Codable, Identifiable {
  let id: UUID
  let title: String
  let isCompleted: Bool
  let createdAt: Date
  let category: UUID // foreign key to Category
}
