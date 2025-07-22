//
//  SubTaskMapper.swift
//  TaskNest
//
//  Created by Tung Le on 25/6/2025.
//

import Foundation
import SwiftData

enum SubTaskMapper {
  
  // MARK:  From Dtos
  static func fromDtosToSwiftData(_ subTaskDto: SubTaskDto) -> SubTask {
    SubTask(
      id: subTaskDto.id,
      title: subTaskDto.title,
      isCompleted: subTaskDto.isCompleted,
      createdAt: subTaskDto.createdAt
      
      // TODO: do it later since it involve matching the taskItem of the subTask to the right one in swift database for fully sync
      
    )
    
  }
  
  
  static func fromDTOs(_ dtos: [SubTaskDto], taskMap: [UUID : TaskItem]) -> [SubTask] { /// dtos from micro services -> swift data
    dtos.compactMap { dto in
      guard let task = taskMap[dto.taskId] else { return nil }
      return SubTask(
        id: dto.id,
        title: dto.title,
        isCompleted: dto.isCompleted,
        createdAt: dto.createdAt,
        taskItem: task
      )
      
      // TODO: later as well, use the fromDtosToSwiftData func from above to avoid 
    }
  }
  
  // // MARK: - From Entity
  static func fromEntityToSwiftData(_ entity: SubTaskEntity) -> SubTask {
    SubTask(
      id: entity.id,
      title: entity.title,
      isCompleted: entity.isCompleted,
      createdAt: entity.createdAt
    )
  }
  
  static func fromEntityToItem(_ entity: SubTaskEntity) -> SubTaskItem {
    SubTaskItem(
      id: entity.id,
      title: entity.title,
      isCompleted: entity.isCompleted,
      createdAt: entity.createdAt,
      taskId: entity.taskId
    )
  }
  
  
  // MARK: - From SwiftData
  static func fromSwiftDataToEntity(_ subTask: SubTask) throws -> SubTaskEntity {
    guard let taskId = subTask.taskItem?.id else {
      throw AppError.database(.missingParent(message: "SubTask is missing linked Task parent -> Conversion to SubTaskEntity failed"))
    }
    
    return SubTaskEntity(
      id: subTask.id,
      title: subTask.title,
      isCompleted: subTask.isCompleted,
      createdAt: subTask.createdAt,
      taskId: taskId
    )
  }
  
  // MARK: - From Item to Entity
  static func fromItemToEntity(_ subTaskItem: SubTaskItem) -> SubTaskEntity {
    return SubTaskEntity(
      id: subTaskItem.id,
      title: subTaskItem.title,
      createdAt: subTaskItem.createdAt,
      taskId: subTaskItem.taskId,
    )
  }
  
} // 🧱
