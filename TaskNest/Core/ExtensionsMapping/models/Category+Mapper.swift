//
//  Category+Mapper.swift
//  TaskNest
//
//  Created by Tung Le on 2/7/2025.
//

extension Category {
  var mapToCategoryEntity: CategoryEntity {
    CategoryMapper.fromSwiftDataToEntity(self)
  }
}
