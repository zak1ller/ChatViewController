//
//  ChatOtherCell.swift
//  ChatViewController
//
//  Created by Min-Su Kim on 1/24/24.
//

import Foundation
import UIKit

final class ChatOtherCell: UITableViewCell {
  
  lazy var containerView = UIView().then {
    $0.layer.cornerRadius = 16
    $0.backgroundColor = .systemPink
  }
  
  lazy var messageLabel = UILabel().then {
    $0.textColor = .white
    $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    $0.numberOfLines = 0
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    transform = CGAffineTransform(scaleX: 1, y: -1)
    selectionStyle = .none
    setUI()
    setConstraint()
  }
  
  func configure(item: ChatModel) {
    messageLabel.text = item.message
  }
}

// MARK: - SET UI
extension ChatOtherCell {
  private func setUI() {
    contentView.addSubview(containerView)
    containerView.addSubview(messageLabel)
  }
  
  private func setConstraint() {
    containerView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(4)
      make.width.lessThanOrEqualTo(230)
      make.left.equalToSuperview().offset(24)
      make.bottom.equalToSuperview().offset(-4)
    }
    
    messageLabel.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(16)
      make.right.equalToSuperview().offset(-16)
      make.top.equalToSuperview().offset(12)
      make.bottom.equalToSuperview().offset(-12)
    }
  }
}

