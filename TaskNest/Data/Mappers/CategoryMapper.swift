//
//  CategoryMapper.swift
//  TaskNest
//
//  Created by Tung Le on 24/6/2025.
//

enum CategoryMapper {
  
  // MARK: - From Dto
  static func fromDtoToSwiftData(_ dto: CategoryDto) -> Category {
    Category(id: dto.id, title: dto.title, createdAt: dto.createdAt, userId: dto.userID)
    // todo: More to come since involve matching and syncing with SwiftData
  }
  
  
  // MARK: - From Item
  static func fromItemToEntity(_ categoryItem: CategoryItem) -> CategoryEntity {
    CategoryEntity(id: categoryItem.id, title: categoryItem.title, createdAt: categoryItem.createdAt, userId: categoryItem.userId)
  }
  
  // MARK: - From Entity
  static func fromEntityToDto(_ categoryEntity: CategoryEntity) -> CategoryDto {
    CategoryDto(id: categoryEntity.id, title: categoryEntity.title, createdAt: categoryEntity.createdAt, userID: categoryEntity.userId)
  }
  
  static func fromEntityToItem(_ categoryEntity: CategoryEntity) -> CategoryItem {
    CategoryItem(id: categoryEntity.id, title: categoryEntity.title, createdAt: categoryEntity.createdAt, userId: categoryEntity.userId)
  }
  
  static func fromEntityToSwiftData(_ categoryEntity: CategoryEntity) -> Category {
    Category(id: categoryEntity.id, title: categoryEntity.title, createdAt: categoryEntity.createdAt, userId: categoryEntity.userId)
  }
  
  // MARK: - From SwifData
  static func fromSwiftDataToEntity(_ category: Category) -> CategoryEntity {
    CategoryEntity(id: category.id, title: category.title, createdAt: category.createdAt, userId: category.userId)
  }
}
