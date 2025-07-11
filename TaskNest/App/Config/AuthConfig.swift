//
//  AuthConfig.swift
//  TaskNest
//
//  Created by Tung Le on 9/6/2025.
//

enum Auth0Config {
  static let clientId = "uq2wrFpmKgvP5rGUdgQz43cVQ8jQupoZ"
  static let domain = "dev-8l8znsqbywijyhtf.au.auth0.com"
  static let scheme = "brucetasknest"
  static let callbackURLString = "\(scheme)://callback"
  static let logoutUrl = "\(scheme)://logout"
  static let databaseRealm = "Username-Password-Auth-TaskNest"
  static let googleConnection = "google-oauth2"
  static let audience = "com.brucele.tt168.tasknest"
}

