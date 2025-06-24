//
//  TaskItemMapper.swift
//  TaskNest
//
//  Created by Tung Le on 25/6/2025.
//

import Foundation
import SwiftData

enum TaskItemMapper {
  static func fromDTOs(_ dtos: [TaskItemDTO], categoryMap: [UUID : Category]) -> [TaskItem] {
    dtos.compactMap { dto in
      guard let category = categoryMap[dto.categoryId] else { return nil }
      return TaskItem(
        id: dto.id,
        title: dto.title,
        isCompleted: dto.isCompleted,
        createdAt: dto.createdAt,
        category: category
      )
    }
  }
}
