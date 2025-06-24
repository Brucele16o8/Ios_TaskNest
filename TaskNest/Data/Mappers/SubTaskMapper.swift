//
//  SubTaskMapper.swift
//  TaskNest
//
//  Created by Tung Le on 25/6/2025.
//

import Foundation
import SwiftData

enum SubTaskMapper {
  static func fromDTOs(_ dtos: [SubTaskDTO], taskMap: [UUID : TaskItem]) -> [SubTask] {
    dtos.compactMap { dto in
      guard let task = taskMap[dto.taskId] else { return nil }
      return SubTask(
        id: dto.id,
        title: dto.title,
        isCompleted: dto.isCompleted,
        createdAt: dto.createdAt,
        task: task
      )
    }
  }
}
