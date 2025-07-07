//
//  CategoryDTO.swift
//  TaskNest
//
//  Created by Tung Le on 24/6/2025.
//

import Foundation

struct CategoryDto: Codable, Identifiable {
  let id: UUID
  let title: String
  let createdAt: Date
  let userID: String
}
