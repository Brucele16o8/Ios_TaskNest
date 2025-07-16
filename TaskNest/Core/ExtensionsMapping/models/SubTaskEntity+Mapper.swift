//
//  SubTaskEntiry+Mapper.swift
//  TaskNest
//
//  Created by Tung Le on 4/7/2025.
//

extension SubTaskEntity {
  var mapToSubTask: SubTask {
    SubTaskMapper.fromEntityToSwiftData(self)
  }
  
  var mapToSubTaskItem: SubTaskItem {
    SubTaskMapper.fromEntityToItem(self)
  }
}
