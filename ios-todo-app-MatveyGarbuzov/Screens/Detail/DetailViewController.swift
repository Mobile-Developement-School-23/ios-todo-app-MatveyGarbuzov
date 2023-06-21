//
//  DetailViewController.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 19.06.2023.
//

import UIKit

final class DetailViewController: UIViewController {
  
  lazy private var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    
    return scrollView
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
    setupConstraints()
    setupKeyboard()
  }
  
  private func setup() {
    view.backgroundColor = UIColor.aBackPrimary
    title = "Дело"
    
    let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelButtonPressed))
    navigationItem.leftBarButtonItem = cancelButton
    
    let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonPressed))
    navigationItem.rightBarButtonItem = saveButton
  }
  
  private func setupConstraints() {
    view.addSubview(textView)
    view.addSubview(vStack)
    view.addSubview(deleteButton)
    
    textView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
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
  
  private func setupKeyboard() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
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
}
