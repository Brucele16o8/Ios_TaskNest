//
//  LoadingView.swift
//  TaskNest
//
//  Created by Tung Le on 16/6/2025.
//

import SwiftUI

struct LoadingView: View {
  @Bindable var loadingViewModel: LoadingViewModel
  @Namespace private var animationNamespace
  
  var body: some View {
    ZStack {
      BackgroundGridView()
      
      VStack {
        Spacer()
        Text("TaskNest")
          .font(.custom("Pacifico-Regular", size: 68).weight(.bold))
          .foregroundStyle(.headingText)
          .scaleEffect(loadingViewModel.showText ? 1 : 0.8)
          .opacity(loadingViewModel.showText ? 1 : 0)
          .matchedGeometryEffect(id: "title", in: animationNamespace)
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle(tint: .white))
          .scaleEffect(1.3)
        Spacer()
        Spacer()
        Spacer()
      }
    }
  }
}

#Preview {
  let viewModel = AppDIContainer.shared.container.resolve(LoadingViewModel.self)!
  LoadingView(loadingViewModel: viewModel)
}
