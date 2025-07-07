//
//  AppRoute.swift
//  TaskNest
//
//  Created by Tung Le on 8/6/2025.
//

enum AppRoute: Hashable {
  case auth(authRoute: AuthRoute)
  case home
  case category(categoryItem: CategoryItem)
  case photoViewer(startingAt: Int, photos: [String])
}
