//
//  AppRoute.swift
//  TaskNest
//
//  Created by Tung Le on 8/6/2025.
//

enum AppRoute: Hashable {
  case auth(authuRoute: AuthRoute)
  case home
  case category(category: Category)
  case photoViewer(startingAt: Int, photos: [String])
}
