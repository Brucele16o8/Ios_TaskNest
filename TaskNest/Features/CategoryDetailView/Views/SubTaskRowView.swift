//
//  SubTaskRowView.swift
//  TaskNest
//
//  Created by Tung Le on 15/7/2025.
//

import SwiftUI

struct SubTaskRowView: View {
  @Bindable private(set) var viewMOdel: SubTaskItemViewModel
  
  
  @State var showGallery: Bool = false
  @State var selectedIndex: Int = 0
  @State private var showPhotoPicker = false
  
  var body: some View {
    let uiState = viewMOdel.uiState
    let subTaskItem = viewMOdel.subTaskItem
    
    VStack(alignment: .leading) {
      Text(subTaskItem.title)
        .font(.subheadline)
        .fontWeight(.medium)
      
      HStack {
        /// Camera Button
        Button {
          showPhotoPicker = true
        } label: {
          Label("Add photo", systemImage: "camera")
        }
        
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
    .fullScreenCover(isPresented: $showGallery) {
      PhotoViewerView(
        startIndex: selectedIndex,
        photos: uiState.photoAttachments
      )
    }    
  }
}

#Preview {
  
  //  photoAttachmentItems: PhotoAttachmentEntity.all.map { $0.mapToPhotoAttachmentItem },
  //)
  
  
  
  SubTaskRowView(
    viewMOdel: SubTaskItemViewModel(
      subTaskItem: SubTaskItem(
        id: UUID(),
        title: "Subtask 1",
        isCompleted: true,
        createdAt: Date(),
        taskId: UUID()
      )
    ),
  )
  
}
