//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 16/7/2025.
//

import Foundation

struct SubTaskItemUiState: Equatable {
  var isLoading: Bool = false
  var errorMessage: String = ""
  var photoAttachments: [PhotoAttachmentItem] = []  
}
