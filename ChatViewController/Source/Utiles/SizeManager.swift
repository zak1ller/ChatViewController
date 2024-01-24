//
//  SizeManager.swift
//  ChatViewController
//
//  Created by Min-Su Kim on 1/24/24.
//

import Foundation
import UIKit

struct SizeManager {
  static func getScreenSize(view: UIView) -> CGSize? {
    return view.window?.windowScene?.screen.bounds.size
  }
  
  static func getSafeArea(_ type: SafeAreaType) -> CGFloat? {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
      return nil
    }
    let window = windowScene.windows.first
    switch type {
    case .top:
      return window?.safeAreaInsets.top
    case .bottom:
      return window?.safeAreaInsets.bottom
    }
  }
}
