//
//  CategoryMapper.swift
//  TaskNest
//
//  Created by Tung Le on 24/6/2025.
//

enum CategoryMapper {
  static func fromDTO(_ dto: CategoryDTO) -> Category {
    Category(id: dto.id, title: dto.title, createdAt: dto.createdAt)
  }
}
