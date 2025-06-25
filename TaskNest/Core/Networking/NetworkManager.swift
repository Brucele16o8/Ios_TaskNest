//
//  NetworkManager.swift
//  TaskNest
//
//  Created by Tung Le on 25/6/2025.
//

import Foundation

final class NetworkManager: NetworkService {
  static let shared = NetworkManager()
  private init() { }
  
  // ✅
  func request<T, R>(
    endpoint: String,
    method: HTTPMethod, body: T?,
    headers: [String : String],
    authToken: String?
  ) async throws -> R where T : Decodable, T : Encodable, R : Decodable
  {
    guard let  baseUrl = URL(string: APIConfig.baseURL) else {
      throw AppError.network(.unknown(message: "Invalid base URL: \(APIConfig.baseURL)"))
    }
    
    let fullURL = baseUrl.appendingPathComponent(endpoint)
    var request = URLRequest(url: fullURL)
    request.httpMethod = method.rawValue
    applyHeader(to: &request, headers: headers, authToken: authToken)
    
    do {
      if let body = body {
        request.httpBody = try JSONEncoder().encode(body)
      }
      
      let (data, response) = try await URLSession.shared.data(for: request)
      
      guard let httpResponse = response as? HTTPURLResponse else {
        throw AppError.network(.unknown(message: "Invalid reponse object type: \(type(of: response))"), underlyingError: nil)
      }
      
      guard (200...299).contains(httpResponse.statusCode) else {
        throw AppError.network(.invalidResponse(code: httpResponse.statusCode), underlyingError: nil)
      }
      
      return try JSONDecoder().decode(R.self, from: data)
    } catch {
      throw ErrorMapper.map(error)
    }
  }
  
  // ✅
  func requestWithoutResponse<T>(
    endpoint: String,
    method: HTTPMethod,
    body: T?, headers: [String : String],
    authToken: String?
  ) async throws where T : Decodable, T : Encodable
  {
    guard let  baseUrl = URL(string: APIConfig.baseURL) else {
      throw AppError.network(.unknown(message: "Invalid base URL: \(APIConfig.baseURL)"))
    }
    
    let fullURL = baseUrl.appendingPathComponent(endpoint)
    var request = URLRequest(url: fullURL)
    request.httpMethod = method.rawValue
    applyHeader(to: &request, headers: headers, authToken: authToken)
    
    do {
      if let body = body {
        request.httpBody = try JSONEncoder().encode(body)
      }
      
      let (_, response) = try await URLSession.shared.data(for: request)
      
      guard let httpResponse = response as? HTTPURLResponse else {
        throw AppError.network(.unknown(message: "Invalid response object type: \(type(of: response))"))
      }
      
      guard (200..<300).contains(httpResponse.statusCode) else {
        throw AppError.network(.invalidResponse(code: httpResponse.statusCode))
      }
    } catch {
      throw ErrorMapper.map(error)
    }
  }
  
  /// ✅ Helper func
  private func applyHeader(
    to request: inout URLRequest,
    headers: [String: String],
    authToken: String?
  ) {
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    headers.forEach { key, value in
      request.setValue(value, forHTTPHeaderField: key)
    }
    
    if let authToken = authToken {
      request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
    }
  }
  
} // 🧱
