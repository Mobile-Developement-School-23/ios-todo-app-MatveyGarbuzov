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
  weak var isDeadlineSetDelegate: NewDeadlineSetDelegate?
  weak var newSegmentedIndexSetDelegate: NewSegmentedIndexSetDelegate?
  weak var newTextSetDelegate: NewTextSetDelegate?
    
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
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setValues(text: String, importanceIndex: Int, deadlineDate: String) {
    textView.setText(with: text)
    vStack.setImportance(with: importanceIndex)
    vStack.setDeadline(with: deadlineDate)
  }
  
  private func customInit() {
    setupDelegates()
    setupConstraints()
  }
  
  private func setupDelegates() {
    vStack.deadlineDateDelegate = self
    vStack.newSegmentedIndexSetDelegate = self
    textView.newTextSetDelegate = self
  }
  
  private func setupConstraints() {
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
    containerHeightDelegate?.update(with: deleteButton.frame.maxY)
  }
}

extension ContainerStack: NewDeadlineSetDelegate {
  func isDeadlineSet(_ value: Bool) {
    isDeadlineSetDelegate?.isDeadlineSet(value)
  }
  
  func newDeadlineDate(_ date: Date?) {
    isDeadlineSetDelegate?.newDeadlineDate(date)
  }
}

extension ContainerStack: NewSegmentedIndexSetDelegate {
  func setNewIndex(_ value: Int) {
    newSegmentedIndexSetDelegate?.setNewIndex(value)
  }
}

extension ContainerStack: NewTextSetDelegate {
  func setNewText(_ value: String) {
    newTextSetDelegate?.setNewText(value)
  }
}
