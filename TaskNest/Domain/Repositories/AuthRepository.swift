//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 12/6/2025.
//

import Auth0

protocol AuthRepository {
  func isAuthenticated() async throws -> Bool
  func loginWithEmailAndPassword(email: String, password: String) async throws -> Credentials
  func loginWithGoogle() async throws -> Credentials
  func logout() async throws
  func getUserInfo(accessToken: String) async throws -> AuthenticatedUser
  func signUpwithEmailAndPassword(email: String, password: String) async throws -> Credentials
  func resetPassword(email: String) async throws
}
