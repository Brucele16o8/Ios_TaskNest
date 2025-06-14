//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 14/6/2025.
//

extension ValidationError {
  var toAppError: AppError {
    ErrorMapper.mapValidationError(self)
  }
}
