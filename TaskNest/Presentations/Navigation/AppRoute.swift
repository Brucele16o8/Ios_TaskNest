//
//  AppRoute.swift
//  TaskNest
//
//  Created by Tung Le on 8/6/2025.
//

enum AppRoute: Hashable, Equatable {
  case auth(authRoute: AuthRoute)
  case home
  case category(categoryItem: CategoryItem)
  case photoViewer(startingAt: Int, photoAttachmentItems: [PhotoAttachmentItem])
  
  static func ==(lhs: AppRoute, rhs: AppRoute) -> Bool {
    switch (lhs, rhs) {
    case (.auth(let lhsAuthRoute), .auth(let rhsAuthRoute)):
      return lhsAuthRoute == rhsAuthRoute
    case (.home, .home):
      return true
      case (.category(let lhsCategoryItem), .category(let rhsCategoryItem)):
      return lhsCategoryItem == rhsCategoryItem
    default:
      return false
    }
  }
  
  func hash(into hasher: inout Hasher) {
    switch self {
    case .auth(authRoute: let authRoute):
      hasher.combine("auth")
      hasher.combine(authRoute)
    case .home:
      hasher.combine("home")
    case .category(categoryItem: let categoryItem):
      hasher.combine("category")
      hasher.combine(categoryItem)
    case .photoViewer(startingAt: let startingAt, photoAttachmentItems: let photoAttachmentItems):
      hasher.combine("photoViewer")
      hasher.combine(startingAt)
      hasher.combine(photoAttachmentItems)
    }
  }
  
} // 🧱
