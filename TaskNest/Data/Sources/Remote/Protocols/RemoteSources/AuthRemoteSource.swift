//
//  AuthRemoteSource.swift
//  TaskNest
//
//  Created by Tung Le on 26/6/2025.
//

/*
 This file is created for later refactoring for the ease of replacing authentication approach
 The Auth0RemoteDataSource is not yet implemented this protocol to focus on interaction between ASP.NET and frontend atm
 Just for future refactoring and improving
 */


/*
import Foundation
import Auth0

protocol AuthRemoteSource {
    // Email/password login
    func loginWithEmailAndPassword(email: String, password: String, completion: @escaping (Result<Credentials, Error>) -> Void)

    // Google login via WebAuth
    func loginWithGoogle(completion: @escaping (Result<Credentials, Error>) -> Void)

    // Restore session if previously logged in
    func restoreSession(completion: @escaping (Result<Credentials, Error>) -> Void)

    // Logout via WebAuth (Auth0 logout)
    func clearSession(completion: @escaping (Result<Void, Error>) -> Void)

    // Store credentials manually
    @discardableResult
    func store(credentials: Credentials) -> Bool

    // Clear credentials manually
    @discardableResult
    func clearCredentials() -> Bool
}
*/
