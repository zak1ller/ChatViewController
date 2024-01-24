//
//  RandomManager.swift
//  ChatViewController
//
//  Created by Min-Su Kim on 1/25/24.
//

import Foundation

struct RandomManager {
  static func chooseRandomly(a: Int, b: Int) -> Int {
    return Int.random(in: a...b)
  }
}
