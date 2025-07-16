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
  let subTaskItem: SubTaskItem
  
  // State
  private(set) var subTaskItemUiState: SubTaskItemUiState = SubTaskItemUiState()
  var uiState: SubTaskItemUiState { subTaskItemUiState }
  
  init(subTaskItem: SubTaskItem) {
    self.subTaskItem = subTaskItem
  }
  
  // ✅
  func addPhoto(_ image: UIImage) {
    let localPath = saveImageToLocalDirectory(image: image)
    if localPath.isEmpty { return } // more to handle empty
    
    
    let newPhoto = PhotoAttachmentItem(
      id: UUID(),
      localPath: localPath,
      remoteURL: nil,
      subTaskID: subTaskItem.id
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

  
} // 🧱
