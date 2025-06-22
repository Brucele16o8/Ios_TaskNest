//
//  AppDIContainer.swift
//  TaskNest
//
//  Created by Tung Le on 9/6/2025.
//

import Foundation
import Swinject

@MainActor
final class AppDIContainer {
  static private(set) var shared: AppDIContainer = AppDIContainer()
  let container = Container()
  
  init() {
    registerServices()
  }
  
  private func registerServices() {
    registerManagers()
    registerAppCoordinators()
    registerDataSources()
    registerRepositories()
    registerUseCases()
    registerViewModels()
  }
  
  // ✅ - App Coordinators
  private func registerAppCoordinators() {
    container.register(AppCoordinator.self) { _ in
      AppCoordinator()
    }.inObjectScope(.container)
    Logger.d(tag: "DIContainer", message: "Successful registerAppCoordinators")
  }

  
  // ✅ - Data sources
  private func registerDataSources() {
    container.register(Auth0RemoteDataSource.self) { _ in
      Auth0RemoteDataSource()
    }.inObjectScope(.container)
    Logger.d(tag: "DIContainer", message: "Successful registerDataSources")
  }
  
  // ✅ - Repositories
  private func registerRepositories() {
    container.register(AuthRepository.self) { r in
      AuthRepositoryImpl(remote: r.resolve(Auth0RemoteDataSource.self)!)
    }.inObjectScope(.container)
    
    Logger.d(tag: "DIContainer", message: "Successful registerRepositories")
  }
  
  // ✅ - Use cases
  private func registerUseCases() {
    container.register(AuthUseCase.self) { r in
      AuthUseCase(repository: r.resolve(AuthRepository.self)!)
    }.inObjectScope(.container)
    
    Logger.d(tag: "DIContainer", message: "Successful registerUseCases")
  }
  
  // ✅ - View Models
  private func registerViewModels() {
    container.register(LoginViewModel.self) { r in
      LoginViewModel(
        loginUseCase: r.resolve(AuthUseCase.self)!,
        authManager: r.resolve(AuthManager.self)!
      )
    }.inObjectScope(.container)
    
    container.register(LoadingViewModel.self) { r in
      LoadingViewModel()
    }.inObjectScope(.container)
    
    container.register(SignUpViewModel.self) {  _ in // TODO: - more later
      SignUpViewModel()
    }.inObjectScope(.container)
    
    container.register(HomeViewModel.self) { r in
      HomeViewModel(
        authManager: r.resolve(AuthManager.self)!,
        authUseCase: r.resolve(AuthUseCase.self)!
      )
    }.inObjectScope(.container)
    
    Logger.d(tag: "DIContainer", message: "Successful registerViewModels")
  }
  
  
  // ✅ - Manager
  private func registerManagers() {
    container.register(AuthManager.self) { r in
      AuthManager(loginUseCase: r.resolve(AuthUseCase.self)!)
    }.inObjectScope(.container)
    Logger.d(tag: "DIContainer", message: "Successful registerManagers")
  }
  
} // 🧱
