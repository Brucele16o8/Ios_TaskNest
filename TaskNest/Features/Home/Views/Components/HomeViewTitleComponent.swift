//
//  HomeView.swift
//  TaskNest
//
//  Created by Tung Le on 23/6/2025.
//

import SwiftUI

struct HomeViewTitleComponent: View {
  let title: String = "Manage your Tasks Well"
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 20.0, style: .continuous)
        .fill(Color.topBar.opacity(0.9))
        .frame(height: 100)
        .shadow(radius: 4)
      
      HStack(spacing: 16) {
        Text(title)
          .font(.system(size: 25, weight: .semibold))
          .multilineTextAlignment(.center)
          .foregroundStyle(.white)
        
        Image(systemName: "cursorarrow.click.2")
          .font(.system(size: 40))
          .foregroundStyle(.white)
          .fontWeight(.bold)
      }
      .padding(.horizontal)
    }
    .padding(.horizontal)
  }
}

#Preview {
  HomeViewTitleComponent()
}
