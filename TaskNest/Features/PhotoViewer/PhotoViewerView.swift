//
//  SubTaskPhotoView.swift
//  TaskNest
//
//  Created by Tung Le on 20/6/2025.
//

import SwiftUI

struct PhotoViewerView: View {
  let startIndex: Int
  let photos: [PhotoAttachmentItem]
  
  @Environment(\.dismiss)  var dismiss
  @State private var currentIndex: Int
  
  init(startIndex: Int, photos: [PhotoAttachmentItem]) {
    self.photos = photos
    self.startIndex = startIndex
    self._currentIndex = State(initialValue: startIndex)
  }
  
  var body: some View {
    TabView(selection: $currentIndex) {
      ForEach(photos.indices, id: \.self) { index in
        if let fullImage = photos[index].fullImage {
          Image(uiImage: fullImage)
            .resizable()
            .scaledToFit()
            .tag(index)
            .background(Color.black)
        }
      }
    }
    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    .background(Color.backgroundColor3.ignoresSafeArea())
    .overlay(alignment: .topTrailing) {
      Button(action: { dismiss() }) {
        Image(systemName: "xmark.circle.fill")
          .font(.system(size: 28))
          .padding()
          .foregroundColor(.black)
      }
    }
  }
  
} // 🧱

#Preview {
  PhotoViewerView(
    startIndex: 1,
    photos: PhotoAttachmentEntity.all.map { $0.mapToPhotoAttachmentItem },
  )
}
