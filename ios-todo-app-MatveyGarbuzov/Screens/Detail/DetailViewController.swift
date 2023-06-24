//
//  DetailViewController.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 19.06.2023.
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {
  
  var scrollViewBottomConstraint: Constraint?
  
  lazy private var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.isScrollEnabled = true
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    
    return scrollView
  }()

  private lazy var container = ContainerStack()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
    setupConstraints()
    setupKeyboard()
    observer()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    container.layoutIfNeeded()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(
      self,
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    
    NotificationCenter.default.removeObserver(
      self,
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
  }
  
  private func observer() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillHide),
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
  }
  
  private func setup() {
    container.containerHeightDelegate = self
    
    view.backgroundColor = UIColor.aBackPrimary
    title = "Дело"
    
    let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelButtonPressed))
    navigationItem.leftBarButtonItem = cancelButton
    
    let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonPressed))
    navigationItem.rightBarButtonItem = saveButton
  }
  
  private func setupConstraints() {
    view.addSubview(scrollView)
    scrollView.addSubview(container)
    
    scrollView.snp.makeConstraints { make in
      make.edges.equalTo(self.view.safeAreaLayoutGuide)
      scrollViewBottomConstraint = make.bottom.equalTo(self.view).constraint
    }

    container.snp.makeConstraints { make in
      make.top.width.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  func keyboardHeight(notification: Notification) -> CGFloat {
      guard let userInfo = notification.userInfo else { return 0 }
      guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return 0 }
      return keyboardSize.cgRectValue.height
  }
  
  private func setupKeyboard() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
  @objc func cancelButtonPressed() {
    print("Cancel button pressed")
    dismiss(animated: true)
  }
  
  @objc func saveButtonPressed() {
    print("Save button pressed")
    dismiss(animated: true)
  }
  
  @objc func keyboardWillShow(_ notification: Notification) {
    let keyboardHeight = keyboardHeight(notification: notification)
    
    scrollViewBottomConstraint?.update(offset: -keyboardHeight)
    
    UIView.animate(withDuration: 0.5) {
      self.view.layoutIfNeeded()
    }
  }
  
  @objc func keyboardWillHide(_ notification: Notification) {
    scrollViewBottomConstraint?.update(offset: 0)
    
    UIView.animate(withDuration: 0.5) {
      self.view.layoutIfNeeded()
    }
  }
}

extension DetailViewController: UpdateContainerHeightDelegate {
  func update(with height: CGFloat) {
    scrollView.contentSize.height = height
    
    container.snp.remakeConstraints { make in
      make.width.equalTo(view.safeAreaLayoutGuide)
      make.height.equalTo(height)
    }
  }
}

