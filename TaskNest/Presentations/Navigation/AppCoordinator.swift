//
//  AppCoordinator.swift
//  TaskNest
//
//  Created by Tung Le on 9/6/2025.
//

import SwiftUI

@Observable
final class AppCoordinator {
  var navigationPath = NavigationPath()
  private var routeHistory: [AppRoute] = []
  var currentRootRoute: AppRootRoute = .loading
  private var isNavigating = false
  
  // ✅ ✅ Handling and keep route history in sync
  private func append(_ route: AppRoute) {
    navigationPath.append(route)
    routeHistory.append(route)
  }
  
  private func removeLast() {
    navigationPath.removeLast()
    routeHistory.removeLast()
  }
  
  private func removeAll() {
    while !navigationPath.isEmpty {
      navigationPath.removeLast()
    }
    routeHistory.removeAll()
  }
  
  // ✅
  func navigate(to route: AppRoute, allowDuplicate: Bool = false, isInternalCall: Bool = false) {
    guard isInternalCall || !isNavigating else {
      Logger.d(tag: "AppCoordinator", message: "Route \(route) already exists at index \(index). Popping back to it.")
      return
    }
    
    isNavigating = true
    defer { isNavigating = false }
    
    /// Check for duplicates in routeHistory
    if !allowDuplicate, let _ = routeHistory.firstIndex(of: route) {
      popTo(route, isInternalCall: true)
      return
    }
    
    Logger.d(tag: "AppCoordinator", message: "Navigating to: \(route)")
    withAnimation(.easeInOut(duration: 0.3)) {
      append(route)
    }
  }
  
  // ++ Heper method: Pop to a specific route if it exists in the stack
  private func popTo(_ route: AppRoute, isInternalCall: Bool = false) {
    guard let index = routeHistory.firstIndex(of: route) else {
      Logger.w(tag: "AppCoordinator", message: "Route \(route) not found. Cannot pop to it.")
      return
    }
    
    Logger.d(tag: "AppCoordinator", message: "Popping to existing route: \(route) at index: \(index)")
    let countToRemove = navigationPath.count - index - 1
    guard countToRemove > 0 else { return }
    withAnimation {
      for _ in 0..<countToRemove {
        removeLast()
      }
    }
  }
  
  // ✅ Go back one screen
  func goBack() {
    guard !navigationPath.isEmpty else {
      Logger.w(tag: "AppCoordinator", message: "Path is already empty. Ignoring goBack().")
      return
    }
    withAnimation(.easeInOut(duration: 0.3)) {
      removeLast()
    }
  }
  
  // ✅ Reset navigation to root screen
  func clearPath() {
    Logger.d(tag: "AppCoordinator", message: "Resetting path to root")
    withAnimation {
      removeAll()
    }
  }
  
  // ✅ Set RootRoute
  func setRootRoute(_ rootRoute: AppRootRoute, isInternalCall: Bool = false) {
    guard isInternalCall || !isNavigating else {
      Logger.w(tag: "AppCoordinator", message: "Already navigating. Ignoring setRootRoute(\(rootRoute)).")
      Logger.w(tag: "AppCoordinator", message: "isInternalCall: \(isInternalCall), isNavigating: \(isNavigating)")
      return
    }
    isNavigating = true
    defer { isNavigating = false }
    clearPath()
    
    if rootRoute != currentRootRoute {
      currentRootRoute = rootRoute
    }
  }
  
  // ✅
  func logOut() {
    setRootRoute(.auth(authRoute: .login))
  }
  
  // ✅
  func restoreSession(usingAuthUseCase authUseCase: AuthUseCase) async {
    guard !isNavigating else {
      return
    }
    isNavigating = true
    defer { isNavigating = false }
    
    do {
      let isAuthenticated = try await authUseCase.isAuthenticated()
      setRootRoute(isAuthenticated ? .main : .auth(authRoute: .login), isInternalCall: true)
    }
    catch {      
      var appError: AppError
      if case let error as AppError = error {
        appError = error
      } else {
        appError = ErrorMapper.map(error)
      }
      Logger.e(tag: "LoginViewModel", message: "Login failed: \(appError.debugDescription)")
      setRootRoute(.auth(authRoute: .login))
    }
  }
  
  // ✅
  func handleDeepLink(url: URL) {
      guard !isNavigating else {
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
  
//  func syncRouteHistory() {
//    /// Manual handling the case using provided default back button
//    while routeHistory.count > navigationPath.count {
//      routeHistory.removeLast()
//    }
//    
//    /// If navigationPath grows unexpectedly (unlikely), notify to handle it
//    if routeHistory.count < navigationPath.count {
//      Logger.w(tag: "AppCoordinator", message: "navigationPath has more items than routeHistory. Possible manual path manipulation.")
//    }
//  }
  
} // 🧱
