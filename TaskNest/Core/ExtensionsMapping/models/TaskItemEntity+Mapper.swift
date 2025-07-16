//
//  TaskItemEntiry+Mapper.swift
//  TaskNest
//
//  Created by Tung Le on 4/7/2025.
//

extension TaskItemEntity {
  var mapToTaskItem: TaskItem {
    TaskItemMapper.fromEntityToSwiftData(self)
  }
  
  var maptoTaskItemItem: TaskItemItem {
    TaskItemMapper.fromEntityToItem(self)
  }
}
