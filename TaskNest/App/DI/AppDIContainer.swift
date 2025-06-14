//
//  AppDIContainer.swift
//  TaskNest
//
//  Created by Tung Le on 9/6/2025.
//

import Foundation
import Swinject

final class AppDIContainer {
  let container = Container()
  
  
  
  private func registerServices() {
    registerDataSources()
    registerRepositories()
  }
  
  // ✅ - Data sources
  private func registerDataSources() {
    container.register(Auth0RemoteDataSource.self) { _ in Auth0RemoteDataSource()
    }
  }
  
  // ✅ - Repositories
  private func registerRepositories() {
    container.register(AuthRepository.self) { r in
      AuthRepositoryImpl(remote: r.resolve(Auth0RemoteDataSource.self)!) }
  }
  
  // ✅ - Use cases
  private func registerUseCases() {
    container.register(LoginUseCase.self) { r in
      LoginUseCase(repository: r.resolve(AuthRepository.self)!)
    }
  }
  
  // ✅ - View Model
  @MainActor
  private func registerViewModels() {
    container.register(LoginViewModel.self) { r in
      LoginViewModel(loginUseCase: r.resolve(LoginUseCase.self)!)
    }
  }
  
} // 🧱
