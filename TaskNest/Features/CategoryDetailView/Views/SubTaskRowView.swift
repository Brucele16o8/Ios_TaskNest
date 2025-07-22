//
//  SubTaskRowView.swift
//  TaskNest
//
//  Created by Tung Le on 15/7/2025.
//

import SwiftUI

struct SubTaskRowView: View {
  @Bindable private(set) var viewModel: SubTaskItemViewModel
  
  
  @State private var showGallery: Bool = false
  @State private var selectedIndex: Int = 0
  @State private var showPhotoPicker = false
  @State private var isEditing = false
  @FocusState private var isFocused: Bool
  @State private var editedTitle = ""
  
  var body: some View {
    let uiState = viewModel.uiState
    let subTaskItem = viewModel.subTaskItem
    
    VStack(alignment: .leading, spacing: 6) {
      HStack(spacing: 12) {
        Button {
          Task {
            await viewModel.toggleCompletion()
          }
        } label: {
          Image(systemName: subTaskItem.isCompleted ? "checkmark.circle.fill" : "circle")
            .foregroundStyle(.blue)
            .font(.system(size: 23))
        }
        
        /// Edit the subtask title
        if isEditing {
            TextField("Edit subtask", text: $editedTitle, onCommit: {
              Task {
                await viewModel.updateTitle(editedTitle)
                isEditing = false
              }
            })
            .focused($isFocused)
            .onAppear {
              editedTitle = subTaskItem.title
              isFocused = true
            }
          
        } else {
          Text(subTaskItem.title)
            .font(.subheadline)
            .foregroundStyle(subTaskItem.isCompleted ? .gray : .black)
            .strikethrough(subTaskItem.isCompleted)
            .onTapGesture {
              isEditing = true
            }
        }
        
        Spacer()
        
        Button{
          
        } label: {
          Image(systemName: "photo")
        }
      }
      
      Spacer(minLength: 0)
      
      HStack {
        
        /// ScrollView for thumpnail
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 8) {
            ForEach(uiState.photoAttachments.indices, id: \.self) { index in
              let photoAttachmentItem = uiState.photoAttachments[index]
              if let thumnailImage = photoAttachmentItem.thumbnail {
                Image(uiImage: thumnailImage)
                  .resizable()
                  .aspectRatio(1, contentMode: .fill)
                  .frame(width: 60, height: 60)
                  .clipped()
                  .cornerRadius(8)
                  .onTapGesture {
                    selectedIndex = index
                    showGallery = true
                  }
              }
            }
          }
        }
        
      }
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(Color(uiColor: .systemBackground))
    )
    .overlay {
      RoundedRectangle(cornerRadius: 10)
        .stroke(Color.blue, lineWidth: 1)
    }
    .contentShape(Rectangle())
    .swipeActions(content: {
      Button(role: .destructive) {
        Task {
          await viewModel.deleteTaskSubTask()
        }
      } label: {
        Label("Delete", systemImage: "trash")
      }

    })
    .fullScreenCover(isPresented: $showGallery) {
      PhotoViewerView(
        startIndex: selectedIndex,
        photos: uiState.photoAttachments
      )
    }
    .padding(.horizontal, 4)
  }
}

#Preview {
  let container = AppDIContainer.shared.container
  let subTaskItem = SubTaskItem(
    id: UUID(),
    title: "Test",
    isCompleted: false,
    createdAt: Date(),
    taskId: UUID())
  
  SubTaskRowView(
    viewModel: SubTaskItemViewModel(
      subTaskItem: subTaskItem,
      getAllSubTaskEntitiesOfTaskId: container.resolve(GetAllSubTaskEntitiesOfTaskIdUseCase.self)!,
      updateSubTaskUseEntityCase: container.resolve(UpdateSubTaskUseEntityCase.self)!,
      getAllPhotoAttachmentEntitiesOfSubTaskId: container.resolve(GetAllPhotoAttachmentEntitiesOfSubTaskId.self)!, deleteSubTaskEntityUseCase: container.resolve(DeleteSubTaskEntityUseCase.self)!
    ),
  )  
}
