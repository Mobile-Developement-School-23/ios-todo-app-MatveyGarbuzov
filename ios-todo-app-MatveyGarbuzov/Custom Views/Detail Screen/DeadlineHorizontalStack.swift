//
//  DeadlineHorizontalStack.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 20.06.2023.
//

import UIKit

protocol ToggleCalendarViewDelegate: AnyObject {
  func toggleCalendarView()
  func hideCalendarView()
}

final class DeadlineHorizontalStack: UIView {
  
  weak var delegate: ToggleCalendarViewDelegate?
  weak var deadlineDateDelegate: NewDeadlineSetDelegate?
  
  lazy private var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMMM yyyy"
    dateFormatter.timeZone = TimeZone.gmt
    
    return dateFormatter
  }()
  
  lazy private var hStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.distribution = .fill
    stack.alignment = .center
    
    return stack
  }()
  
  lazy private var deadlineLabelVStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .leading
    stack.spacing = 0
    
    return stack
  }()
  
  lazy private var deadlineLabel = UILabel.body(with: "Сделать до")
  lazy private var deadlineDateLabel: UILabel = {
    let date = Date().nextDayInString()
    let label = UILabel.footnote(with: "\(date)")
    label.textColor = .aBlue
    label.isUserInteractionEnabled = true
    
    return label
  }()

  lazy private var spacer = UIView()
  lazy private var deadlineSwitch: UISwitch = {
    let deadlineSwitch = UISwitch()
    
    return deadlineSwitch
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    customInit()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setDeadline(_ deadlineDate: String) {
    deadlineDateLabel.text = deadlineDate
    if deadlineDateLabel.text != "" {
      deadlineSwitch.isOn = true
      switchStateChanged(deadlineSwitch)
    } else {
      deadlineDateLabel.text = Date().nextDayInString()
    }
  }

  func setLabel(with value: String) {
    deadlineDateLabel.text = value
  }
  
  private func customInit() {
    setupVStack()
    addActions()
    setupConstraints()
  }
  
  private func setupConstraints() {
    addSubview(hStack)
    hStack.addArrangedSubview(deadlineLabelVStack)
    hStack.addArrangedSubview(spacer)
    hStack.addArrangedSubview(deadlineSwitch)

    hStack.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.trailing.equalToSuperview().inset(14)
      make.top.bottom.equalToSuperview().inset(9)
    }
    
    deadlineLabelVStack.snp.makeConstraints { make in
      make.height.equalTo(40)
      make.width.equalToSuperview().multipliedBy(0.5)
    }
    
    deadlineLabel.snp.makeConstraints { make in
      make.height.equalTo(22)
    }
    
    deadlineDateLabel.snp.makeConstraints { make in
      make.height.equalTo(0)
    }
  }
  
  private func setupVStack() {
    deadlineLabelVStack.addArrangedSubview(deadlineLabel)
    deadlineLabelVStack.addArrangedSubview(deadlineDateLabel)
  }
  
  private func addActions() {
    deadlineSwitch.addTarget(self, action: #selector(switchStateChanged), for: .valueChanged)
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dateLabelTapped))
    deadlineDateLabel.addGestureRecognizer(tapGesture)
  }
  
  private func showDeadlineDate() {
    deadlineDateLabel.snp.updateConstraints { make in
      make.height.equalTo(18)
    }
  }
  
  private func hideDeadlineDate() {
    deadlineDateLabel.snp.updateConstraints { make in
      make.height.equalTo(0)
    }
  }
  
  private func animateChanging() {
    UIView.animate(withDuration: 0.3) {
      self.deadlineLabelVStack.layoutIfNeeded()
    }
  }
  
  @objc func switchStateChanged(_ sender: UISwitch) {
    if sender.isOn {
      let date = deadlineDateLabel.text?.stringToDate()
      deadlineDateDelegate?.newDeadlineDate(date)
      deadlineDateDelegate?.isDeadlineSet(true)
      showDeadlineDate()
    } else {
      deadlineDateDelegate?.newDeadlineDate(nil)
      deadlineDateDelegate?.isDeadlineSet(false)
      delegate?.hideCalendarView()
      hideDeadlineDate()
    }
    animateChanging()
  }
  
  @objc func dateLabelTapped() {
    delegate?.toggleCalendarView()
  }
}

extension Date {
  func nextDayInString() -> String {
    let calendar = Calendar.current
    guard let tomorrowDate = calendar.date(byAdding: .day, value: 1, to: self) else {
        return ""
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMMM yyyy"
    dateFormatter.timeZone = TimeZone.gmt
    let dateString = dateFormatter.string(from: tomorrowDate)
    return dateString
  }
  
  func toFormattedString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMMM yyyy"
    formatter.timeZone = TimeZone.gmt
    return formatter.string(from: self)
  }
}

extension String {
  func stringToDate() -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMMM yyyy"
    dateFormatter.timeZone = TimeZone.gmt

    return dateFormatter.date(from: self)
  }
}
