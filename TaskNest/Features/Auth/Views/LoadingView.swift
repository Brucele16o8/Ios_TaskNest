//
//  LoadingView.swift
//  TaskNest
//
//  Created by Tung Le on 16/6/2025.
//

import SwiftUI

struct LoadingView: View {
  @ObservedObject var loadingViewModel: LoadingViewModel
  @Namespace private var animationNamespace
  
  var body: some View {
    ZStack {
      BackgroundGridView()
      
      VStack {
        Spacer()
        Text("TaskNest")
          .font(.system(size: 68, weight: .bold, design: .rounded))
          .foregroundStyle(.headingText)
          .scaleEffect(loadingViewModel.showText ? 1 : 0.8)
          .opacity(loadingViewModel.showText ? 1 : 0)
          .matchedGeometryEffect(id: "title", in: animationNamespace)
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle(tint: .white))
          .scaleEffect(1.3)
          .padding(.top, 20)
        Spacer()
      }
      .onAppear {
        loadingViewModel.startAnimation()
      }
    }
  }
}

#Preview {
  let viewModel = AppDIContainer.shared.container.resolve(LoadingViewModel.self)!
  LoadingView(loadingViewModel: viewModel)
}
