//
//  Error+AppError.swift
//  TaskNest
//
//  Created by Tung Le on 14/6/2025.
//

extension Error {
  var toAppError: AppError {
    ErrorMapper.map(self)
  }
}
