//
//  TaskItemMapper.swift
//  TaskNest
//
//  Created by Tung Le on 25/6/2025.
//

import Foundation
import SwiftData

enum TaskItemMapper {
  
  // From Dtos
  static func fromDTOs(_ dtos: [TaskItemDto], categoryMap: [UUID : Category]) -> [TaskItem] {
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
  
  // From SwiftData
  static func fromSwiftDataToEntity(_ taskItem: TaskItem) throws -> TaskItemEntity {
    guard let categoryId = taskItem.category?.id else {
      throw AppError.database(.missingParent(message: "TaskItem is missing linked parent -> Conversion to TaskEntity failed"))
    }
    
    return TaskItemEntity(
      id: taskItem.id,
      title: taskItem.title,
      isCompleted: taskItem.isCompleted,
      createdAt: taskItem.createdAt,
      categoryId: categoryId)
  }
  
  // From Entity
  static func fromEntityToSwiftData(_ taskItemEntity: TaskItemEntity) -> TaskItem {
    TaskItem(
      id: taskItemEntity.id,
      title: taskItemEntity.title,
      isCompleted: taskItemEntity.isCompleted,
      createdAt: taskItemEntity.createdAt,
      category: nil
    )
  }
  
} // 🧱
