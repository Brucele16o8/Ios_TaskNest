//
//  CategoryEntity+Mapper.swift
//  TaskNest
//
//  Created by Tung Le on 2/7/2025.
//

extension CategoryEntity {
  var mapToCategory: Category {
    CategoryMapper.fromEntityToSwiftData(self)
  }
  
  var mapToCategotyItem: CategoryItem {
    CategoryMapper.fromEntityToItem(self)
  }
}
