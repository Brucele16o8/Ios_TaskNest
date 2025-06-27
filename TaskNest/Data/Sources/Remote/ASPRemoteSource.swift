//
//  ASPTaskRemoteSourceImpl.swift
//  TaskNest
//
//  Created by Tung Le on 25/6/2025.
//

import Foundation

protocol ASPAPIRemoteSourceProtocol {
  // MARK: - Fully Sync
  func fullySync() async throws -> FullSyncDTO
  
  // MARK: - Category
  func getAllCategories() async throws -> [CategoryDto]
  func createCategory(_ categoryDto: CategoryDto) async throws
  func updateCategory(_ categoryDto: CategoryDto) async throws
  func deleteCategory(id: UUID) async throws
  func getTasksByCategoryId(_ id: UUID) async throws -> [TaskItemDto]
  
  // MARK: - TaskItem
  func getAllTasks() async throws -> [TaskItemDto]
  func createTask(_ taskItemDto: TaskItemDto) async throws
  func updateTask(_ taskItemDto: TaskItemDto) async throws
  func deleteTask(id: UUID) async throws
  func getSubTasksByTaskId(_ id: UUID) async throws -> [SubTaskDto]
  
  // MARK: - SubTask
  func createSubTask(_ subTaskDto: SubTaskDto) async throws
  func updateSubTask(_ subTaskDto: SubTaskDto) async throws
  func deleteSubTask(id: UUID) async throws
  func getPhotoAttachmentsBySubTaskId(_ id: UUID) async throws -> [PhotoAttachmentDto]
  
  // MARK: - PhotoAttachment
  func getAllPhotoAttachments() async throws -> [PhotoAttachmentDto]
  func createPhotoAttachment(_ photoAttachmentDto: PhotoAttachmentDto) async throws
  func updatePhotoAttachment(_ photoAttachmentDto: PhotoAttachmentDto) async throws
  func deletePhotoAttachment(id: UUID) async throws
  
} // 🧱


//// 📁 TaskNestApp/
//// └── Data/
////     └── Sources/
////         ├── Remote/
////         │   └── TaskRemoteDataSource.swift
////         └── Local/
////             └── TaskLocalDataSource.swift
//
//
//
//// MARK: - Remote Source Protocol
//
//protocol TaskRemoteDataSource {
//    func fetchAll(userId: UUID) async throws -> FullSyncDTO
//    func fetchTask(by id: UUID) async throws -> TaskItemDTO
//    func create(task: TaskItemDTO) async throws
//    func update(task: TaskItemDTO) async throws
//    func delete(taskId: UUID) async throws
//}
//
//final class TaskRemoteDataSourceImpl: TaskRemoteDataSource {
//    private let network: NetworkService
//
//    init(network: NetworkService = NetworkManager.shared) {
//        self.network = network
//    }
//
//    func fetchAll(userId: UUID) async throws -> FullSyncDTO {
//        try await network.request(
//            endpoint: "api/fullsync",
//            method: .get,
//            body: Optional<Data>.none,
//            headers: ["X-User-Id": userId.uuidString],
//            authToken: nil
//        )
//    }
//
//    func fetchTask(by id: UUID) async throws -> TaskItemDTO {
//        try await network.request(
//            endpoint: "api/tasks/\(id)",
//            method: .get,
//            body: Optional<Data>.none,
//            headers: [:],
//            authToken: nil
//        )
//    }
//
//    func create(task: TaskItemDTO) async throws {
//        try await network.requestWithoutResponse(
//            endpoint: "api/tasks",
//            method: .post,
//            body: task,
//            headers: [:],
//            authToken: nil
//        )
//    }
//
//    func update(task: TaskItemDTO) async throws {
//        try await network.requestWithoutResponse(
//            endpoint: "api/tasks/\(task.id)",
//            method: .put,
//            body: task,
//            headers: [:],
//            authToken: nil
//        )
//    }
//
//    func delete(taskId: UUID) async throws {
//        try await network.requestWithoutResponse(
//            endpoint: "api/tasks/\(taskId)",
//            method: .delete,
//            body: Optional<Data>.none,
//            headers: [:],
//            authToken: nil
//        )
//    }
//}
//
//// MARK: - Local Source Protocol
//
//protocol TaskLocalDataSource {
//    func saveAll(from syncDTO: FullSyncDTO) throws
//    func fetchAll(strategy: DataAccessStrategy) throws -> FullSyncDTO
//    func fetchTask(by id: UUID) throws -> TaskItem?
//    func create(task: TaskItem) throws
//    func update(task: TaskItem) throws
//    func delete(task: TaskItem) throws
//}
//
//final class TaskLocalDataSourceImpl: TaskLocalDataSource {
//    private let context: ModelContext
//
//    init(context: ModelContext) {
//        self.context = context
//    }
//
//    func saveAll(from syncDTO: FullSyncDTO) throws {
//        let categoryMap = Dictionary(uniqueKeysWithValues: syncDTO.categories.map { ($0.id, CategoryMapper.fromDTO($0)) })
//        let taskMap = Dictionary(uniqueKeysWithValues: syncDTO.tasks.map { ($0.id, TaskMapper.fromDTO($0, categoryMap: categoryMap)) })
//        let subtaskMap = Dictionary(uniqueKeysWithValues: syncDTO.subtasks.map { ($0.id, SubTaskMapper.fromDTO($0, taskMap: taskMap)) })
//        let photoAttachments = syncDTO.attachments.compactMap { PhotoAttachmentMapper.fromDTO($0, subtaskMap: subtaskMap) }
//
//        let allModels: [any PersistentModel] =
//            Array(categoryMap.values) + Array(taskMap.values) + Array(subtaskMap.values) + photoAttachments
//
//        for model in allModels {
//            context.insert(model)
//        }
//        try context.save()
//    }
//
//    func fetchAll(strategy: DataAccessStrategy) throws -> FullSyncDTO {
//        FullSyncDTO(
//            categories: try context.fetch(FetchDescriptor<Category>()).map(CategoryMapper.toDTO),
//            tasks: try context.fetch(FetchDescriptor<TaskItem>()).map { TaskMapper.toDTO($0) },
//            subtasks: try context.fetch(FetchDescriptor<SubTask>()).map(SubTaskMapper.toDTO),
//            attachments: try context.fetch(FetchDescriptor<PhotoAttachment>()).map(PhotoAttachmentMapper.toDTO)
//        )
//    }
//
//    func fetchTask(by id: UUID) throws -> TaskItem? {
//        try context.fetch(FetchDescriptor<TaskItem>(predicate: #Predicate { $0.id == id })).first
//    }
//
//    func create(task: TaskItem) throws {
//        context.insert(task)
//        try context.save()
//    }
//
//    func update(task: TaskItem) throws {
//        // SwiftData auto tracks changes
//        try context.save()
//    }
//
//    func delete(task: TaskItem) throws {
//        context.delete(task)
//        try context.save()
//    }
//}
//
