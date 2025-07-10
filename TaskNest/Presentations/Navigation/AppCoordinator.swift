//
//  AppCoordinator.swift
//  TaskNest
//
//  Created by Tung Le on 9/6/2025.
//

import SwiftUI

@Observable
final class AppCoordinator {
  var navigationPath = [AppRoute]()
  var currentRootRoute: AppRootRoute = .loading
  private var isNavigating = false
  
  // ✅
  func navigate(to route: AppRoute, allowDuplicate: Bool = false) {
    guard !isNavigating else {
      Logger.w(tag: "AppCoordinator", message: "Already navigating. Ignoring navigation to \(route).")
      return
    }
    
    guard currentRootRoute == .main else {
      Logger.w(tag: "AppCoordinator", message: "Cannot navigate to \(route) while not in .main root route. Current root route is \(currentRootRoute).")
      return
    }
    isNavigating = true
    defer { isNavigating = false }
    
    // Avoid duplicate route if already in stack
    if !allowDuplicate, let _ = navigationPath.firstIndex(of: route) {
      Logger.d(tag: "AppCoordinator", message: "Route \(route) already exists. Popping back to it.")
      popTo(route, isInternalCall: true)
      return
    }
    Logger.d(tag: "AppCoordinator", message: "Path: \(navigationPath) before append")
    Logger.d(tag: "AppCoordinator", message: "Navigating to: \(route)")
    navigationPath.append(route)
    Logger.d(tag: "AppCoordinator", message: "path: \(navigationPath) after append")
  }
  
  // ✅ Go back one screen
  func goBack() {
    guard !navigationPath.isEmpty else {
      Logger.w(tag: "AppCoordinator", message: "Path is already empty. Ignoring goBack().")
      return
    }
    
    Logger.d(tag: "AppCoordinator", message: "Going back from: \(navigationPath.last!)")
    navigationPath.removeLast()
  }
  
  // ✅ Reset navigation to root screen
  func clearPath() {
    Logger.d(tag: "AppCoordinator", message: "Resetting path to root")
    navigationPath.removeAll()
  }
  
  // ✅ Set RootRoute
  func setRootRoute(_ rootRoute: AppRootRoute) {
    guard !isNavigating else {
      Logger.w(tag: "AppCoordinator", message: "Already navigating. Ignoring setRootRoute(\(rootRoute)).")
      return
    }
    isNavigating = true
    defer { isNavigating = false }
    
    if rootRoute != .main {
      clearPath()
    }
    currentRootRoute = rootRoute
  }
  
  // ✅ Pop to a specific route if it exists in the stack
  func popTo(_ route: AppRoute, isInternalCall: Bool = false) {
    guard isInternalCall || !isNavigating else {
      Logger.w(tag: "AppCoordinator", message: "Navigation in progress, ignoring popTo: \(route)")
      return
    }
    
    guard let index = navigationPath.firstIndex(of: route) else {
      Logger.w(tag: "AppCoordinator", message: "Route \(route) not found. Cannot pop to it.")
      return
    }
    
    Logger.d(tag: "AppCoordinator", message: "Popping to existing route: \(route) at index: \(index)")
    navigationPath.removeLast(navigationPath.count - index - 1)
  }
  
  // ✅
  func logOut() {
    Logger.d(tag: "AppCoordinator", message: "Logging out and navigating to login")
    setRootRoute(.auth(authRoute: .login))
  }
  
  // ✅
  func restoreSession(usingAuthUseCase authUseCase: AuthUseCase) async {
    guard !isNavigating else {
      Logger.w(tag: "AppCoordinator", message: "Already navigating. Ignoring restoreSession.")
      return
    }
    
    isNavigating = true
    defer { isNavigating = false }
    
    do {
      let isAuthenticated = try await authUseCase.isAuthenticated()
      setRootRoute(isAuthenticated ? .main : .auth(authRoute: .login))
      Logger.d(tag: "AppCoordinator", message: "Session restored: \(isAuthenticated ? "Authenticated" : "Unauthenticated")")
    } catch {
      let appError = ErrorMapper.map(error)
      setRootRoute(.auth(authRoute: .login))
      Logger.e(tag: "AppCoordinator", message: "Session restoration failed: \(appError.debugDescription)")
    }
    
  }
  
  // ✅
  func handleDeepLink(url: URL) {
      guard !isNavigating else {
          Logger.w(tag: "AppCoordinator", message: "Already navigating. Ignoring deep link: \(url)")
          return
      }
      
      isNavigating = true
      defer { isNavigating = false }
      
      if url.pathComponents.contains("signup") {
          setRootRoute(.auth(authRoute: .signUp))
      } else if url.pathComponents.contains("forgot-password") {
          setRootRoute(.auth(authRoute: .forgotPassword))
      } else if url.pathComponents.contains("main") || url.pathComponents.contains("home") {
          setRootRoute(.main)
      } else if url.pathComponents.contains("category") {
        let categoryId = URLComponents(url: url, resolvingAgainstBaseURL: false)?
            .queryItems?
            .first(where: { $0.name == "id" })?
            .value
            .flatMap { UUID(uuidString: $0) } ?? UUID()
        // more later -> need adjustment
        // solution 1: get category from here
        // create a place holder like categoryItem = CategoryItem(...) and fetch from view later
        let categoryItem = CategoryItem(id: categoryId, title: "Category from Deep Link", userId: "Place holder")
        navigate(to: .category(categoryItem: categoryItem))
      }
      Logger.d(tag: "AppCoordinator", message: "Handled deep link: \(url)")
  }
  
} // 🧱
