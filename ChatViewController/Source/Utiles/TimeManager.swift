//
//  TimeManager.swift
//  ChatViewController
//
//  Created by Min-Su Kim on 1/24/24.
//

import Foundation

struct TimeManager {
  static func makeCurrentTimeString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let currentDateTimeString = dateFormatter.string(from: Date())
    return currentDateTimeString
  }
  
  static func extractDate(from dateTimeString: String) -> String {
    let components = dateTimeString.split(separator: " ")
    if let firstComponent = components.first {
      return String(firstComponent)
    }
    return ""
  }
}
