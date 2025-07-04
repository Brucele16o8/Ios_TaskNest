//
//  SubTask+Mapper.swift
//  TaskNest
//
//  Created by Tung Le on 2/7/2025.
//

extension SubTask {
  var mapToSubTaskEntity: SubTaskEntity {
    get throws {
      try SubTaskMapper.fromSwiftDataToEntity(self)
    }
  }
}
