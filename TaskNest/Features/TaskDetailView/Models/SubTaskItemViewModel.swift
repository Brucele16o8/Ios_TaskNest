//
//  SubTaskItemViewModel.swift
//  TaskNest
//
//  Created by Tung Le on 16/7/2025.
//

import Foundation
import SwiftUI

@Observable
final class SubTaskItemViewModel {
  var subTaskItem: SubTaskItem
  
  // State
  private(set) var subTaskItemUiState: SubTaskItemUiState = SubTaskItemUiState()
  var uiState: SubTaskItemUiState { subTaskItemUiState }
  
  // Use cases
  private var updateSubTaskUseEntityCase: UpdateSubTaskUseEntityCase
  private var getAllPhotoAttachmentEntitiesOfSubTaskId: GetAllPhotoAttachmentEntitiesOfSubTaskId
  private var deleteSubTaskEntityUseCase: DeleteSubTaskEntityUseCase
  
  
  init(
    subTaskItem: SubTaskItem,
    getAllSubTaskEntitiesOfTaskId: GetAllSubTaskEntitiesOfTaskIdUseCase,
    updateSubTaskUseEntityCase: UpdateSubTaskUseEntityCase,
    getAllPhotoAttachmentEntitiesOfSubTaskId: GetAllPhotoAttachmentEntitiesOfSubTaskId,
    deleteSubTaskEntityUseCase: DeleteSubTaskEntityUseCase
  ) {
    self.subTaskItem = subTaskItem
    self.updateSubTaskUseEntityCase = updateSubTaskUseEntityCase
    self.getAllPhotoAttachmentEntitiesOfSubTaskId = getAllPhotoAttachmentEntitiesOfSubTaskId
    self.deleteSubTaskEntityUseCase = deleteSubTaskEntityUseCase
  }
  
  func start() async {
    subTaskItemUiState.isLoading = true
    do {
      subTaskItemUiState.photoAttachments = try await getAllPhotoAttachmentEntitiesOfSubTaskId(subTaskItem.id)
        .map { $0.mapToPhotoAttachmentItem }
        .sorted { $0.createdAt > $1.createdAt }        
    } catch let appError as AppError {
      subTaskItemUiState.errorMessage = appError.localizedDescription
    } catch {
      subTaskItemUiState.errorMessage = "Error when fetching photoAttachment items"
    }
  }
  
  // ✅ - Check completion
  func toggleCompletion() async {
    subTaskItem.isCompleted.toggle()
    do {
      try await updateSubTaskUseEntityCase(subTaskEntity: subTaskItem.mapToEntity)
    } catch let appError as AppError {
      subTaskItemUiState.errorMessage = appError.localizedDescription
    } catch {
      subTaskItemUiState.errorMessage = "Error when updating photoAttachment items"
    }
  }
  
   // ✅ - updateTitle
  func updateTitle(_ newTitle: String) async {
    guard newTitle.count > 0 else {
      subTaskItemUiState.errorMessage = "Title must not be empty"
      return
    }
    subTaskItem.title = newTitle
    do {
      try await updateSubTaskUseEntityCase(subTaskEntity: subTaskItem.mapToEntity)
    } catch let appError as AppError {
      subTaskItemUiState.errorMessage = appError.localizedDescription
    } catch {
      subTaskItemUiState.errorMessage = "Error when updating photoAttachment items"
    }
  }
  
  // ✅ - Delete SubTask
  func deleteTaskSubTask() async {
    do {
      try await deleteSubTaskEntityUseCase(id: subTaskItem.id)
    } catch let appError as AppError {
      subTaskItemUiState.errorMessage = appError.localizedDescription
    } catch {
      subTaskItemUiState.errorMessage = "Error when deleting subtask item."
    }
  }
  
  // ✅
  func addPhoto(_ image: UIImage) {
    let localPath = saveImageToLocalDirectory(image: image)
    if localPath.isEmpty { return } // more to handle empty    
    
    let _ = PhotoAttachmentItem(
      id: UUID(),
      localPath: localPath,
      remoteURL: nil,
      subTaskID: subTaskItem.id,
      createdAt: Date()
    )
  }
  
  // ++ Helper
  private func saveImageToLocalDirectory(image: UIImage) -> String {
    do {
      guard let data = image.jpegData(compressionQuality: 0.8) else {
        throw AppError.image(.invalidData)
      }
      
      let filename = UUID().uuidString + ".jpg"
      let folder = try URL.photoCacheDirectory()
      let fileURL = folder.appendingPathComponent(filename)
      
      try data.write(to: fileURL)
      return fileURL.path
    }
    catch let appError as AppError {
      subTaskItemUiState.errorMessage = appError.localizedDescription
    } catch {
      subTaskItemUiState.errorMessage = "Failed to save image error"
    }
    return ""
  }
  
  // MARK: Navigate 
  
} // 🧱
