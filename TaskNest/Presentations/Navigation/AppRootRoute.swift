//
//  AppRootRoute.swift
//  TaskNest
//
//  Created by Tung Le on 8/7/2025.
//

enum AppRootRoute: Equatable, Hashable {
  case loading
  case auth(authRoute: AuthRoute)
  case main
  
  static func ==(lhs: AppRootRoute, rhs: AppRootRoute) -> Bool {
    switch (lhs, rhs) {
    case (.loading, .loading):
      return true
    case (.auth(let lhsAuthRoute), .auth(let rhsAuthRoute)):
      return lhsAuthRoute == rhsAuthRoute
    case (.main, .main):
      return true
    default:
      return false
    }
  }
  
  func hash(into hasher: inout Hasher) {
    switch self {
    case .loading:
      hasher.combine("loading")
    case .auth(authRoute: let authRoute):
      hasher.combine("auth")
      hasher.combine(authRoute)
    case .main:
      hasher.combine("main")
    }
  }
  
} // 🧱
