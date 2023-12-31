//
//  DoneHStack.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 28.06.2023.
//

import UIKit

protocol ShowDoneTasksDelegate: AnyObject {
  func show()
}

final class DoneHStack: UIView {
  
  weak var showDoneTasksDelegate: ShowDoneTasksDelegate?
  private var isShowDoneTasks = false
  
  private lazy var hStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    
    return stack
  }()
  
  private lazy var doneLabel: UILabel = {
    let label = UILabel.subhead(with: "Выполнено — ")
    label.textColor = .aLabelTertiary
    
    return label
  }()
  
  private lazy var showButton: UIButton = {
    var configuration = UIButton.Configuration.plain()
    let attributes = AttributeContainer([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), .kern : -0.24])
    configuration.attributedTitle = AttributedString("Показать", attributes: attributes)
    configuration.baseForegroundColor = .aBlue
    
    let button = UIButton(configuration: configuration)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    customInit()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateTitle(with value: Int) {
    doneLabel.text = "Выполнено — \(value)"
  }
  
  private func customInit() {
    addAction()
    setupConstraints()
  }
  
  private func addAction() {
    showButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
  }
  
  private func setupConstraints() {
    addSubview(hStack)
    
    hStack.addArrangedSubview(doneLabel)
    hStack.addArrangedSubview(UIView()) // Spacer
    hStack.addArrangedSubview(showButton)
    
    hStack.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  @objc func tapped() {
    isShowDoneTasks.toggle()
    let attributes = AttributeContainer([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), .kern : -0.24])
    showButton.configuration?.attributedTitle = AttributedString(isShowDoneTasks ? "Скрыть" : "Показать", attributes: attributes)
    showDoneTasksDelegate?.show()
  }
  
}
