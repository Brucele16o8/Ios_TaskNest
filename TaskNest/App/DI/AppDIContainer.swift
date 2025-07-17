//
//  AppDIContainer.swift
//  TaskNest
//
//  Created by Tung Le on 9/6/2025.
//

import Foundation
import Swinject
import SwiftData

@MainActor
final class AppDIContainer {
  static private(set) var shared: AppDIContainer = AppDIContainer()
  let container = Container()
  
  init() {
    registerServices()
  }
  
  private func registerServices() {
    registerSwiftDataContainer()
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
  
  
  // ✅ - SwiftData container
  private func registerSwiftDataContainer() {
    container.register(ModelContainer.self) { _ in
      SwiftDataContainer.shared.container
    }.inObjectScope(.container)
  }

  
  // ✅ - Data sources
  private func registerDataSources() {
    /// Remote data sources
    container.register(Auth0RemoteDataSource.self) { r in
      Auth0RemoteDataSource(networkService: r.resolve(NetworkService.self)!)
    }.inObjectScope(.container)
    
    container.register(CategoryRemoteSource.self) { r in
      CategoryRemoteSourceImpl(
        categoryApi: CategoryApiClient(
          networkService: r.resolve(NetworkService.self)!,
          authManager: r.resolve(AuthManager.self)!)
      )
    }.inObjectScope(.container)
    
    container.register(TaskItemRemoteSource.self) { r in
      TaskItemRemoteSourceImpl(
        taskItemApi: TaskItemApiClient(
          networkService: r.resolve(NetworkService.self)!,
          authManager: r.resolve(AuthManager.self)!)
      )
    }.inObjectScope(.container)
    
    container.register(SubTaskRemoteSource.self) { r in
      SubTaskRemoteSourceImpl(
        subTaskApi: SubTaskApiClient(
          networkservice: r.resolve(NetworkService.self)!,
          authManager: r.resolve(AuthManager.self)!)
      )
    }.inObjectScope(.container)
    
    container.register(PhotoAttachmentRemoteSource.self) { r in
      PhotoAttachmentRemoteSourceImpl(
        phototAttachmentApi: PhotoAttachmentApiClient(
          networkService: r.resolve(NetworkService.self)!,
          authManager: r.resolve(AuthManager.self)!)
      )
    }.inObjectScope(.container)
    
    /// Local Data Sources
    container.register(AppModelActor.self) { r in
      AppModelActor(modelContainer: r.resolve(ModelContainer.self)!)
    }.inObjectScope(.container)
    
    Logger.d(tag: "DIContainer", message: "Successful registerDataSources")
  }
  
  // ✅ - Repositories
  private func registerRepositories() {
    container.register(AuthRepository.self) { r in
      AuthRepositoryImpl(remote: r.resolve(Auth0RemoteDataSource.self)!)
    }.inObjectScope(.container)
    
    container.register(CategoryRepository.self) { r in
      CategoryRepositoryImpl(
        categoryRemoteSource: r.resolve(CategoryRemoteSource.self)!,
        categoryLocalDb: r.resolve(AppModelActor.self)!)
    }.inObjectScope(.container)
    
    container.register(TaskItemRepository.self) { r in
      TaskItemRepositoryImpl(
        taskItemRemoteSource: r.resolve(TaskItemRemoteSource.self)!,
        taskItemLocalDb: r.resolve(AppModelActor.self)!)
    }.inObjectScope(.container)
    
    container.register(SubTaskRepository.self) { r in
      SubTaskRepositoryImpl(
        subTaskRemoteSource: r.resolve(SubTaskRemoteSource.self)!,
        subTaskModelActor: r.resolve(AppModelActor.self)!)
    }.inObjectScope(.container)
    
    container.register(PhotoAttachmentRepository.self) { r in
      PhotoAttachmentRepositoryImpl(
        photoAttachmentRemoteSource: r.resolve(PhotoAttachmentRemoteSource.self)!,
        photoAttachmentLocalDb: r.resolve(AppModelActor.self)!)
    }.inObjectScope(.container)
    
    Logger.d(tag: "DIContainer", message: "Successful registerRepositories")
  }
  
  // ✅ - Use cases
  private func registerUseCases() {
    container.register(AuthUseCase.self) { r in
      AuthUseCase(repository: r.resolve(AuthRepository.self)!)
    }.inObjectScope(.container)
    
    /// Use cases for Category
    container.register(GetAllCategoryEntitiesUseCase.self) { r in
      GetAllCategoryEntitiesUseCase(categoryRepository: r.resolve(CategoryRepository.self)!)
    }.inObjectScope(.container)
    
    container.register(GetCategoryEntityUseCase.self) { r in
      GetCategoryEntityUseCase(categoryRepository: r.resolve(CategoryRepository.self)!)
    }.inObjectScope(.container)
    
    container.register(SaveCategoryEntityUseCase.self) { r in
      SaveCategoryEntityUseCase(categoryRepository: r.resolve(CategoryRepository.self)!)
    }.inObjectScope(.container)
    
    container.register(UpdateCategoryEntityUserCase.self) { r in
      UpdateCategoryEntityUserCase(categoryRepository: r.resolve(CategoryRepository.self)!)
    }.inObjectScope(.container)
    
    container.register(DeleteCategoryEntityUseCase.self) { r in
      DeleteCategoryEntityUseCase(categoryRepository: r.resolve(CategoryRepository.self)!)
    }.inObjectScope(.container)
    
    /// Use cases for Task
    container.register(GetTaskItemEntitiesByCategoryEntityUseCase.self) { r in
      GetTaskItemEntitiesByCategoryEntityUseCase(taskItemRepository: r.resolve(TaskItemRepository.self)!)
    }.inObjectScope(.container)
    
    
    Logger.d(tag: "DIContainer", message: "Successful registerUseCases")
  }
  
  // ✅ - View Models
  private func registerViewModels() {
    container.register(LoginViewModel.self) { r in
      LoginViewModel(
        authUseCase: r.resolve(AuthUseCase.self)!,
        authManager: r.resolve(AuthManager.self)!,
        appCoordinator: r.resolve(AppCoordinator.self)!
      )
    }.inObjectScope(.container)
    
    container.register(LoadingViewModel.self) { r in
      LoadingViewModel()
    }.inObjectScope(.container)
    
    container.register(SignUpViewModel.self) {  r in // TODO: - more later
      SignUpViewModel(
        authManager: r.resolve(AuthManager.self)!,
        authUseCase: r.resolve(AuthUseCase.self)!,
        appCoordinator: r.resolve(AppCoordinator.self)!)
    }.inObjectScope(.container)
    
    container.register(HomeViewModel.self) { r in /// Home View Model
      HomeViewModel(
        authManager: r.resolve(AuthManager.self)!,
        authUseCase: r.resolve(AuthUseCase.self)!,
        appCoordinator: r.resolve(AppCoordinator.self)!,
        getAllCategoriesUseCase: r.resolve(GetAllCategoryEntitiesUseCase.self)!,
        deleteCategoryUseCase: r.resolve(DeleteCategoryEntityUseCase.self)!,
        saveCategoryUseCase: r.resolve(SaveCategoryEntityUseCase.self)!
      )
    }.inObjectScope(.container)
    
    container.register(ForgotPasswordViewModel.self) { r in // Forgot View Model
      ForgotPasswordViewModel(
        authUseCase: r.resolve(AuthUseCase.self)!
      )
    }.inObjectScope(.container)
    
    container.register(CategoryDetailViewModel.self) { (r: Resolver, categoryItem: CategoryItem )in
      CategoryDetailViewModel(
        categoryItem: categoryItem,
        appCoordinator: r.resolve(AppCoordinator.self)!,
        getTaskItemEntitiesByCategoryEntityUseCase: r.resolve(GetTaskItemEntitiesByCategoryEntityUseCase.self)!
      )
    }.inObjectScope(.graph)
    
    Logger.d(tag: "DIContainer", message: "Successful registerViewModels")
  }
  
  
  // ✅ - Manager
  private func registerManagers() {
    container.register(AuthManager.self) { r in
      AuthManager(authUseCase: r.resolve(AuthUseCase.self)!)
    }.inObjectScope(.container)
    
    container.register(NetworkService.self) { _ in
      NetworkManager()
    }.inObjectScope(.container)
    
    Logger.d(tag: "DIContainer", message: "Successful registerManagers")
  }
  
} // 🧱
