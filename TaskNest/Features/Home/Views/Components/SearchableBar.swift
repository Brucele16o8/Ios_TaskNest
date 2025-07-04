//
//  SearchableBar.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import SwiftUI

struct SearchableBar: View {
  @Binding var searchText: String
  
  var body: some View {
    TextField("Search all Tasks", text: $searchText)
      .padding(.horizontal, 16)
      .padding(.vertical, 10)
      .background(Color.white)
      .overlay {
        RoundedRectangle(cornerRadius: 12)
          .stroke(Color.blue, lineWidth: 1)
      }
      .cornerRadius(12)
      .shadow(color: Color.gray.opacity(0.6), radius: 4, x: 0, y: 2)
  }
}

#Preview {
  SearchableBar(searchText: .constant(""))
}
