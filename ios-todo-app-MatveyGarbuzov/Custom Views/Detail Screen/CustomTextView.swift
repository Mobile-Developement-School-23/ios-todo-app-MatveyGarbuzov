//
//  CustomTextView.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 19.06.2023.
//

import UIKit

final class CustomTextView : UITextView {
  
  private lazy var placeholderLabel: UILabel = {
    let label = UILabel.body(with: "Что надо сделать?")
    label.sizeToFit()
    label.textColor = UIColor.aLabelTertiary
    return label
  }()
  
  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    
    customInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    customInit()
  }
  
  private func customInit() {
    setup()
    setupPlaceholder()
  }
  
  private func setup() {
    isScrollEnabled = false
    layer.cornerRadius = 16
    delegate = self
    textContainerInset = UIEdgeInsets(top: 17, left: 16, bottom: 17, right: 16)
    font = .systemFont(ofSize: 16)
  }
  
  private func setupPlaceholder() {
    addSubview(placeholderLabel)
    let leftInset = self.textContainerInset.left
    let topInset = self.textContainerInset.top
    
    placeholderLabel.frame.origin = CGPoint(x: leftInset, y: topInset)
  }
}

extension CustomTextView : UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    placeholderLabel.isHidden = !textView.text.isEmpty
  }
  func textViewDidEndEditing(_ textView: UITextView) {
    placeholderLabel.isHidden = !textView.text.isEmpty
  }
  func textViewDidBeginEditing(_ textView: UITextView) {
    placeholderLabel.isHidden = !textView.text.isEmpty
  }
}
