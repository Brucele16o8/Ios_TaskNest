//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 17/7/2025.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class AddCategoryViewModel {
  var title = ""
  var errorMessage: String = ""
  var isSaving = false
  
  var isValid: Bool {
    !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }
  
  // ✅
  func validateInput() -> Bool {
    guard isValid else {
      errorMessage = "Title cannot be empty."
      return false
    }
    errorMessage = ""
    return true
  }
  
  // ✅
  func save(
    onSave: (String) async -> Void,
    onDismiss: () -> Void
  ) async {
    Logger.d(tag: "SaveCategory", message: "Inside save - AddCategoryViewModel")
    guard validateInput() else { return }
    isSaving = true
    await onSave(title)
    Logger.d(tag: "SaveCategory", message: "Inside save with title \(title) - AddCategoryViewModel")
    isSaving = false
    onDismiss()
  }
  
} // 🧱

