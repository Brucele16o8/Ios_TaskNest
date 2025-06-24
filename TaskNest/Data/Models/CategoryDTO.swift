//
//  CategoryDTO.swift
//  TaskNest
//
//  Created by Tung Le on 24/6/2025.
//

import Foundation

struct CategoryDTO: Codable, Identifiable {
  let id: UUID
  let title: String
  let createdAt: Date
}
