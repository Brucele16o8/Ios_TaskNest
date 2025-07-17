//
//  CategoryItem+Mapper.swift
//  TaskNest
//
//  Created by Tung Le on 17/7/2025.
//

extension CategoryItem {
  var mapToEntity: CategoryEntity {
    return CategoryMapper.fromItemToEntity(self)
  }
}
