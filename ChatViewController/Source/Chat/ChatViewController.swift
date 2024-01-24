//
//  ViewController.swift
//  ChatViewController
//
//  Created by Min-Su Kim on 1/24/24.
//

import UIKit
import RxSwift
import RxCocoa

final class ChatViewController: UIViewController {

  lazy var titleLabel = UILabel().then {
    $0.text = "채팅"
    $0.textColor = .black
    $0.textAlignment = .center
    $0.font = UIFont.systemFont(ofSize: 17, weight: .medium)
  }
  
  lazy var tableView = UITableView().then {
    $0.transform = CGAffineTransform(scaleX: 1, y: -1)
    $0.register(ChatMyCell.self, forCellReuseIdentifier: "ChatMyCell")
    $0.register(ChatOtherCell.self, forCellReuseIdentifier: "ChatOtherCell")
    $0.delegate = self
    $0.dataSource = self
    $0.backgroundColor = .blue
    $0.rowHeight = UITableView.automaticDimension
    $0.separatorStyle = .none
    $0.backgroundColor = .clear
  }
  
  lazy var messageInputTextField = PaddingTextField().then {
    $0.placeholder = "메세지를 입력해주세요."
    $0.backgroundColor = .systemGray6
  }
  
  let viewModel = ChatViewModel()
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    setConstraint()
    action()
    bind()
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow),
      name: UIWindow.keyboardWillShowNotification,
      object: nil
    )
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillHide(_:)),
      name: UIWindow.keyboardWillHideNotification,
      object: nil
    )
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    adjustTableViewInset()
  }
  
  @objc func keyboardWillShow(_ notificaiton: Notification) {
    if let keyboardFrame: NSValue = notificaiton.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      let keyboardHeight = keyboardFrame.cgRectValue.height
      self.messageInputTextField.snp.updateConstraints { make in
        make.bottom.equalTo(self.view.layoutMarginsGuide.snp.bottom).offset(-keyboardHeight + (SizeManager.getSafeArea(.bottom) ?? 0 / 2) - 24)
      }
    }
  }
  
  @objc func keyboardWillHide(_ notification: Notification) {
    self.messageInputTextField.snp.updateConstraints { make in
      make.bottom.equalTo(self.view.layoutMarginsGuide.snp.bottom)
    }
  }
  
  private func action() {
    messageInputTextField.rx.controlEvent(.editingDidEndOnExit)
      .asObservable()
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        self.viewModel.sendMessage(
          message: self.messageInputTextField.text ?? "",
          uid: RandomManager.chooseRandomly(a: 1, b: 2)
        )
      })
      .disposed(by: disposeBag)
  }
  
  private func bind() {
    viewModel.sentNewMessage
      .subscribe(onNext: { [weak self] isSent in
        if isSent {
          self?.tableView.reloadData()
          self?.adjustTableViewInset()
        }
      })
      .disposed(by: disposeBag)
  }
  
  private func adjustTableViewInset() {
    let tableViewHeight = tableView.frame.height
    let contentHeight = tableView.contentSize.height
    let inset = max(0, tableViewHeight - contentHeight)
    tableView.contentInset = UIEdgeInsets(top: inset, left: 0, bottom: 0, right: 0)
  }
}

// MARK: - SET UI
extension ChatViewController {
  private func setUI() {
    view.backgroundColor = .white
    
    view.addSubview(titleLabel)
    view.addSubview(messageInputTextField)
    view.addSubview(tableView)
  }
  
  private func setConstraint() {
    titleLabel.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(24)
      make.right.equalToSuperview().offset(-24)
      make.top.equalTo(self.view.layoutMarginsGuide.snp.top)
    }
    
    messageInputTextField.snp.makeConstraints { make in
      make.height.equalTo(40)
      make.left.equalToSuperview().offset(24)
      make.right.equalToSuperview().offset(-24)
      make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom)
    }
    
    tableView.snp.makeConstraints { make in
      make.left.equalToSuperview()
      make.right.equalToSuperview()
      make.top.equalTo(titleLabel.snp.bottom).offset(16)
      make.bottom.equalTo(messageInputTextField.snp.top)
    }
  }
}

// MARK: - UITableView Delegate & DataSource
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.chats.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = viewModel.chats[indexPath.item]
    if item.uid == 1 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMyCell", for: indexPath) as! ChatMyCell
      cell.configure(item: item)
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "ChatOtherCell", for: indexPath) as! ChatOtherCell
      cell.configure(item: item)
      return cell
    }
  }
}
