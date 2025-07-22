//
//  TaskItemItem+Mapper.swift
//  TaskNest
//
//  Created by Tung Le on 20/7/2025.
//

extension TaskItemItem {
  var mapToEntity: TaskItemEntity {
    return TaskItemMapper.fromItemToEntity(self)
  }
}
