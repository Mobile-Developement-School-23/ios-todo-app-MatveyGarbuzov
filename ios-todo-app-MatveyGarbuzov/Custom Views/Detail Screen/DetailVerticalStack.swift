//
//  DetailVerticalStack.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 20.06.2023.
//

import UIKit

protocol DetailVStackDelegate: AnyObject {
    func didReceiveNewValue(_ value: Date)
}

final class DetailVerticalStack: UIView {
  
  weak var delegate: DetailVStackDelegate?
  
  var isCalendarHidden = true

  private lazy var mainVStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .center
    stack.spacing = 0
    
    return stack
  }()
  
  private lazy var importanceHStack = ImportanceHorizontalStack()
  private lazy var deadlineHStack = DeadlineHorizontalStack()
  
  private lazy var datePickerView: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .date
    datePicker.preferredDatePickerStyle = .inline
    datePicker.calendar.firstWeekday = 2
    let calendar = Calendar.current
    datePicker.minimumDate = calendar.startOfDay(for: Date())
    
    return datePicker
  }()
  
  private lazy var spacer1: UIView = {
    let spacer = UIView()
    spacer.backgroundColor = .aSeparator
    
    return spacer
  }()
  
  private lazy var spacer2: UIView = {
    let spacer = UIView()
    spacer.backgroundColor = .aSeparator
    
    return spacer
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    customInit()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setImportance(with importance: Importance) {
    importanceHStack.setImportance(importance)
  }
  
  func setDeadline(with date: Date?) {
    deadlineHStack.setDeadline(date)
  }
  
  func getImportance() -> Importance {
    importanceHStack.getImportance()
  }
  
  func getDeadline() -> Date? {
    deadlineHStack.getDeadline()
  }
  
  private func customInit() {
    setup()
    setupMainVStack()
    setupConstraints()
    addActions()
  }
  
  private func setupConstraints() {
    addSubview(mainVStack)
    
    mainVStack.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    importanceHStack.snp.makeConstraints { make in
      make.height.equalTo(56)
      make.leading.trailing.top.equalToSuperview()
    }
    
    spacer1.snp.makeConstraints { make in
      make.height.equalTo(1)
      make.leading.trailing.equalToSuperview().inset(16)
    }
    
    deadlineHStack.snp.makeConstraints { make in
      make.height.equalTo(56)
      make.leading.trailing.equalToSuperview()
    }
    
    spacer2.snp.makeConstraints { make in
      make.height.equalTo(0)
      make.leading.trailing.equalToSuperview().inset(16)
    }
    
    datePickerView.snp.makeConstraints { make in
      make.height.equalTo(0)
      make.leading.trailing.equalToSuperview().inset(8)
    }
  }
  
  private func setup() {
    backgroundColor = .aBackSecondary
    layer.cornerRadius = 15
    
    deadlineHStack.delegate = self
  }
  
  private func addActions() {
    datePickerView.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
  }
  
  private func setupMainVStack() {
    mainVStack.addArrangedSubview(importanceHStack)
    mainVStack.addArrangedSubview(spacer1)
    mainVStack.addArrangedSubview(deadlineHStack)
    mainVStack.addArrangedSubview(spacer2)
    mainVStack.addArrangedSubview(datePickerView)
  }
  
  @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
    delegate?.didReceiveNewValue(sender.date)
    
    // Обрабатываем выбранную дату
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM yyyy"
    let selectedDate = dateFormatter.string(from: sender.date)
    print("Выбранная дата: \(selectedDate)")
    print("--Выбранная дата: \(sender.date)")
  }
}

extension DetailVerticalStack: ToggleDatePickerDelegate {
  
  func hideDatePicker() {
    isCalendarHidden = true
    hideCalendar()
    animateChanging()
  }
  
  func toggleDatePicker() {
    isCalendarHidden.toggle()

    isCalendarHidden ? hideCalendar() : showCalendar()
    
    animateChanging()
  }
  
  private func showCalendar() {
    datePickerView.snp.updateConstraints { make in
      make.height.equalTo(330)
    }
    datePickerView.alpha = 1
    
    spacer2.snp.updateConstraints { make in
      make.height.equalTo(1)
    }
  }
  
  private func hideCalendar() {
    datePickerView.snp.updateConstraints { make in
      make.height.equalTo(0)
    }
    datePickerView.alpha = 0
    
    spacer2.snp.updateConstraints { make in
      make.height.equalTo(0)
    }
  }
  
  private func animateChanging() {
    UIView.animate(withDuration: 0.3) {
      self.superview?.layoutIfNeeded()
    }
  }
}
