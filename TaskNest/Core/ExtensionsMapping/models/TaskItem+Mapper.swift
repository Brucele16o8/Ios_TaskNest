//
//  TaskItem+Mapper.swift
//  TaskNest
//
//  Created by Tung Le on 4/7/2025.
//

extension TaskItem {
  var mapToTaskItemEntity: TaskItemEntity {
    get throws {
      return try TaskItemMapper.fromSwiftDataToEntity(self)
    }
  }
}
