//
//  Logger.swift
//  TaskNest
//
//  Created by Tung Le on 11/6/2025.
//

enum Logger {
  
  // Debug - For development details
  static func d(tag: String,
                message: String,
                file: String = #fileID,
                function: String = #function,
                line: Int = #line) {
    #if DEBUG
        print("🐛 [DEBUG] [\(tag)] \(message) (\(file):\(line) - \(function))")
    #endif
  }
  
  
  // Info - For high-level checkpoints
  static func i(tag: String,
                message: String,
                file: String = #fileID,
                function: String = #function,
                line: Int = #line) {
    #if DEBUG
    print("ℹ️ [INFO] [\(tag)] \(message) (\(file):\(line) - \(function))")
    #endif
  }
  
  // Warning - Something unexpected but not fatal
  static func w(tag: String,
                message: String,
                file: String = #fileID,
                function: String = #function,
                line: Int = #line) {
      #if DEBUG
      print("⚠️ [WARN] [\(tag)] \(message) (\(file):\(line) - \(function))")
      #endif
  }

  // Error - Critical issues or failures
  static func e(tag: String,
                message: String,
                error: Error? = nil,
                file: String = #fileID,
                function: String = #function,
                line: Int = #line) {
      #if DEBUG
      print("🛑 [ERROR] [\(tag)] \(message) (\(file):\(line) - \(function))")
      if let error = error {
          print("    ↪︎ \(error.localizedDescription)")
      }
      #endif
  }

  // Verbose - Noisy logging, very detailed (e.g., networking payloads)
  static func v(tag: String,
                message: String,
                file: String = #fileID,
                function: String = #function,
                line: Int = #line) {
      #if DEBUG
      print("🔍 [VERBOSE] [\(tag)] \(message) (\(file):\(line) - \(function))")
      #endif
  }
}

