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
    registerDataSources()
    registerRepositories()
    registerUseCases()
    registerViewModels()
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
    container.register(LoginUseCase.self) { r in
      LoginUseCase(repository: r.resolve(AuthRepository.self)!)
    }.inObjectScope(.container)
    Logger.d(tag: "DIContainer", message: "Successful registerUseCases")
  }
  
  // ✅ - View Model
  private func registerViewModels() {
    container.register(LoginViewModel.self) { r in
      LoginViewModel(loginUseCase: r.resolve(LoginUseCase.self)!)
    }.inObjectScope(.container)
    Logger.d(tag: "DIContainer", message: "Successful registerViewModels")
  }
  
} // 🧱
