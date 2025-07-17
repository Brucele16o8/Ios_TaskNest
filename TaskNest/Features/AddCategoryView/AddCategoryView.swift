//
//  AddCategoryView.swift
//  TaskNest
//
//  Created by Tung Le on 17/7/2025.
//

import SwiftUI

struct AddCategoryView: View {
  @Environment(\.dismiss) var dismiss
  @Bindable private(set) var viewModel: AddCategoryViewModel
  
  // callbacks
  let onSave: (String) async -> Void
  let onCancel: () -> Void
  
  var body: some View {
    VStack {
      Spacer()
      
      Text("Add New Category")
        .font(.title)
        .fontWeight(.bold)
        .foregroundColor(.blue.opacity(0.6))
        .padding(.top, 20)
      
      TextFieldFormGeneral(
        title: "Enter category ttile",
        bindingText: $viewModel.title,
        keyboardType: .default)
      .onSubmit {
        Task {
          await viewModel.save(onSave: onSave) {
            dismiss()
          }
        }
      }
      
      if !viewModel.errorMessage.isEmpty {
        Text(viewModel.errorMessage)
          .font(.caption)
          .foregroundColor(.red)
      }
      
      // Save button
      Button {
        Task {
          await viewModel.save(onSave: onSave) {
            dismiss()
          }
        }
      } label: {
        if viewModel.isSaving {
          ProgressView()
            .frame(maxWidth: .infinity)
            .padding()
        } else {
          Text("Create Category")
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .padding()
        }
      }
      .background(viewModel.isValid ? Color.accentColor : Color.gray)
      .foregroundColor(.white)
      .cornerRadius(10)
      .disabled(!viewModel.isValid || viewModel.isSaving)
      .padding(.top, 10)
      
      Spacer()
      Spacer()
    }
    .padding()
    .background(Color.backgroundColor3)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button("Cancel") {
          onCancel()
          dismiss()
        }
      }
    }
  }
}

#Preview {
  AddCategoryView(
    viewModel: AddCategoryViewModel(),
    onSave: { _ in print("onSave") },
    onCancel: { }
  )
}
