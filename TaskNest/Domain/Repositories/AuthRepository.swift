//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 12/6/2025.
//

import Auth0

public protocol AuthRepository {
  func loginWithEmailAndPassword(email: String, password: String, completion: @escaping (Result<Credentials, Error>) -> Void)
  func loginWithGoogle(completion: @escaping (Result<Credentials, Error>) -> Void)
  func logout()
  func restoreSession(completion: @escaping (Result<Credentials, Error>) -> Void)
}
