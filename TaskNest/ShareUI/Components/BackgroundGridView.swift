//
//  BackgroundGridView.swift
//  TaskNest
//
//  Created by Tung Le on 16/6/2025.
//

import SwiftUI

struct BackgroundGridView: View {
  let imageNames: [String]
  
  init(imageNames: [String] = AppAssets.Backgrounds.splashImages) {
    self.imageNames = imageNames
  }
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        /// Images
        VStack(spacing: 0) {
          ForEach(0..<3) { row in
            HStack(spacing: 0) {
              ForEach(0..<2) { col in
                let index = row * 2 + col
                Image(imageNames[index])
                  .resizable()
                  .scaledToFill()
                  .frame(
                    width: geometry.size.width / 2,
                    height: geometry.size.height / 3
                  )
                  .clipped()
              }
            }
          }
        }
      }
      /// Gradient
      LinearGradient(
        gradient: Gradient(stops: [
          .init(color: Color.backgroundColor1.opacity(0.5), location: 0.0),
          .init(color: Color.backgroundColor2, location: 0.9),
          .init(color: Color.backgroundColor2, location: 1.0),
        ]),
        startPoint: .top,
        endPoint: .bottom)
      
    }
    .ignoresSafeArea()
  }
}

#Preview {
  BackgroundGridView(imageNames: AppAssets.Backgrounds.splashImages)
}
