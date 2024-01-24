//
//  PaddingTextField.swift
//  ChatViewController
//
//  Created by Min-Su Kim on 1/24/24.
//

import Foundation
import UIKit

final class PaddingTextField: UITextField {
  
  var textPadding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: textPadding)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: textPadding)
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: textPadding)
  }
}
