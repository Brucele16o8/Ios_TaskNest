//
//  SubTaskItem+Mapper.swift
//  TaskNest
//
//  Created by Tung Le on 19/7/2025.
//

extension SubTaskItem {
  var mapToEntity: SubTaskEntity {
    SubTaskMapper.fromItemToEntity(self)
  }
}
