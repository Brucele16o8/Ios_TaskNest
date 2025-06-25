//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 25/6/2025.
//

import Foundation

protocol NetworkService {
  func request<T: Codable, R: Decodable>(
    endpoint: String,
    method: HTTPMethod,
    body: T?,
    headers: [String : String],
    authToken: String?
  ) async throws -> R
  
  func requestWithoutResponse<T: Codable>(
    endpoint: String,
    method: HTTPMethod,
    body: T?,
    headers: [String : String],
    authToken: String?
  ) async throws
}
