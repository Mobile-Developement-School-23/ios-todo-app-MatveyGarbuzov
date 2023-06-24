//
//  ContainerStack.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 21.06.2023.
//

import UIKit

//protocol ChangeHeightOfScrollView {
//  func show()
//  func hide()
//}

protocol UpdateContainerHeightDelegate: AnyObject {
  func update(with height: CGFloat)
}

final class ContainerStack: UIView {
  
  weak var containerHeightDelegate: UpdateContainerHeightDelegate?
  
  private lazy var stack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .center
    
    return stack
  }()
  
  private let textView = CustomTextView()
  private let vStack = DetailVerticalStack()
  
  private lazy var deleteButton: UIButton = {
    var configuration = UIButton.Configuration.filled()
    configuration.attributedTitle = AttributedString(
      "Удалить", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.aBody])
    )
    configuration.baseForegroundColor = .aLabelTertiary
    configuration.baseBackgroundColor = .aBackSecondary
    configuration.background.cornerRadius = 16
    configuration.cornerStyle = .fixed
    
    let deleteButton = UIButton(configuration: configuration)
    
    return deleteButton
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    customInit()
    
    textView.keyboardDelegate = self
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func customInit() {
    addSubview(textView)
    addSubview(vStack)
    addSubview(deleteButton)
    
    textView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(16)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.greaterThanOrEqualTo(120)
    }
    
    vStack.snp.makeConstraints { make in
      make.top.equalTo(textView.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(16)
    }
    
    deleteButton.snp.makeConstraints { make in
      make.top.equalTo(vStack.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(56)
    }
  }
  
  override func layoutIfNeeded() {
    super.layoutIfNeeded()
    print("layoutIfNeeded from Container: \(deleteButton.frame.maxY)")
    containerHeightDelegate?.update(with: deleteButton.frame.maxY)
  }
}


extension ContainerStack: KeyboardShowOrHide {
  func show() {
    print("Show keyboard")
  }
  
  func hide() {
    print("Hide keyboard")
  }
}
