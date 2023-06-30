//
//  DetailViewController.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 19.06.2023.
//

import UIKit
import SnapKit

protocol NewDeadlineSetDelegate: AnyObject {
  func isDeadlineSet(_ value: Bool)
  func newDeadlineDate(_ date: Date?)
}

protocol NewSegmentedIndexSetDelegate: AnyObject {
  func setNewIndex(_ value: Int)
}

protocol NewTextSetDelegate: AnyObject {
  func setNewText(_ value: String)
}


final class DetailViewController: UIViewController {
  
  weak var toDoItemDelegate: ToDoItemDelegate?
  var scrollViewBottomConstraint: Constraint?
  var viewModel: DetailViewModel?
  
  lazy private var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.isScrollEnabled = true
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    
    return scrollView
  }()
  
  private lazy var container = ContainerStack()
  
  init(viewModel: DetailViewModel) {
    self.viewModel = viewModel
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadToDoItem()
    
    setup()
    setupConstraints()
    setupKeyboard()
    observer()
    
    setValues()
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
  
  private func loadToDoItem() {
    
  }
  
  private func setValues() {
    container.setValues(
      text: viewModel?.text ?? "",
      importanceIndex: viewModel?.importanceLevel ?? 0,
      deadlineDate: viewModel?.deadlineDate ?? Date().nextDayInString()
    )
  }
  
  private func saveItem() {
    guard let viewModel else { return }
    viewModel.saveItem()
    print(viewModel.toDoItem)
    
    toDoItemDelegate?.saveItem(at: viewModel.index, toDoItem: viewModel.toDoItem)
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
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(updateButtonColor),
      name: NSNotification.Name("somethingChanged"),
      object: nil
    )
  }
  
  @objc func updateButtonColor() {
    navigationItem.rightBarButtonItem?.tintColor = viewModel?.somethingChanged ?? false ? .aBlue : .aLabelTertiary
  }
  
  private func setup() {
    setupDelegates()
    
    view.backgroundColor = UIColor.aBackPrimary
    title = "Дело"
    
    setupNavBar()
  }
  
  private func setupNavBar() {
    let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelButtonPressed))
    navigationItem.leftBarButtonItem = cancelButton
    
    let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonPressed))
    saveButton.tintColor = .aLabelTertiary
    navigationItem.rightBarButtonItem = saveButton
  }
  
  private func setupDelegates() {
    container.toDoItemDelegate = self
    container.containerHeightDelegate = self
    container.isDeadlineSetDelegate = self
    container.newSegmentedIndexSetDelegate = self
    container.newTextSetDelegate = self
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
    saveItem()
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

extension DetailViewController: ToDoItemDelegate {
  func saveItem(at index: Int, toDoItem: ToDoItem) {}
  
  func deleteItem(at index: Int) {
    guard let viewModel else { return }
    toDoItemDelegate?.deleteItem(at: viewModel.index)
    dismiss(animated: true)
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

extension DetailViewController {
  func isSomethingChanged()  {
    guard let viewModel else { return }
    
    // Changing Save button status
    viewModel.somethingChanged = viewModel.isSomethingChanged
    
    if viewModel.isSomethingChanged == true {
      print(); print()
      print("RESULT OF NEW VALUES")
      print("TEXT: \(String(describing: viewModel.newText))")
      print("IMPORTANCE: \(String(describing: viewModel.importanceLevel))")
      print("DEADLINE: \(String(describing: viewModel.newDeadlineDate))")
    }
  }
}

extension DetailViewController: NewDeadlineSetDelegate {
  func isDeadlineSet(_ value: Bool) {
    viewModel?.isDeadlineSet = value
    isSomethingChanged()
  }
  
  func newDeadlineDate(_ date: Date?) {
    viewModel?.newDeadlineDate = date
    isSomethingChanged()
  }
}

extension DetailViewController: NewSegmentedIndexSetDelegate {
  func setNewIndex(_ value: Int) {
    switch value {
    case 0:
      viewModel?.newImportance = .unimportant
    case 2:
      viewModel?.newImportance = .important
    default:
      viewModel?.newImportance = .normal
    }
    
    isSomethingChanged()
  }
}

extension DetailViewController: NewTextSetDelegate {
  func setNewText(_ value: String) {
    viewModel?.newText = value
    isSomethingChanged()
  }
}
