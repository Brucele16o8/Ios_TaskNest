//
//  DatabaseError.swift
//  TaskNest
//
//  Created by Tung Le on 28/6/2025.
//
import Foundation

enum DatabaseError: LocalizedError {
  case notFound(message: String)
  case saveFailed(message: String)
  case deleteFailed(message: String)
  case fetchFailed(message: String)
  
  case unknown(message: String)
  
  // 🧩
  public var errorDescription: String? {
    switch self {
    case .notFound(let message):
      return "Data not found. \(message)"
    case .saveFailed(let message):
      return "Unable to save data. \(message)"
    case .deleteFailed(let message):
      return "Unable to delete data. \(message)"
    case .fetchFailed(let message):
      return "Unable to fetch data. \(message)"
    case .unknown(let message):
      return "Database Error: \(message)"
    }
  }
  
  // 🧩
  public var debugDescription: String {
    switch self {
    case .notFound(let message):
      return ".notFound: \(message)"
    case .saveFailed(let message):
      return ".saveFailed: \(message)"
    case .deleteFailed(let message):
      return ".deleteFailed: \(message)"
    case .fetchFailed(let message):
      return ".fetchFailed: \(message)"
    case .unknown(let message):
      return "Unkown database issue: \(message)"
    }
  }
  
  
  
  
}
