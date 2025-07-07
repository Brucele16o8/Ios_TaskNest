//
//  Category+Extension.swift
//  TaskNest
//
//  Created by Tung Le on 2/7/2025.
//

extension Category {
  func applyIfChanged(fromCategoryEntity categoryEntity: CategoryEntity) -> Bool {
    var didChange = false
    
    if self.title != categoryEntity.title {
      self.title = categoryEntity.title
      didChange = true
    }
    
    if self.createdAt != categoryEntity.createdAt {
      self.createdAt = categoryEntity.createdAt
      didChange = true
    }
    return didChange
  }
  
} // 🧱



// MARK: - Preview Data
extension Category {
  static var empty: Category {
    .init(title: "", userId: "")
  }
}

extension Category {
  static let work = Category(title: "Work", userId: "116688")
  static let personal = Category(title: "Personal", userId: "116688")
  static let shopping = Category(title: "Shopping", userId: "116688")
  static let study = Category(title: "Study", userId: "116688")

  static var all: [Category] = [work, personal, shopping, study]
}
