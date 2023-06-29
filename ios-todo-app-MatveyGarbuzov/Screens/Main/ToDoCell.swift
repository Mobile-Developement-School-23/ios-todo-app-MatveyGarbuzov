//
//  ToDoCell.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 17.06.2023.
//

import UIKit
import SnapKit

final class ToDoCell: UITableViewCell {
  
  // MARK: - Properties
  static let id = "ToDoCell"
  private var viewModel: ToDoCellViewModel?

  private lazy var mainContainer = UIView()
  private lazy var textContainer = UIView()
  
  private lazy var importanceIndicator: UIImageView = {
    let imageView = UIImageView()
    
    return imageView
  }()
  
  private lazy var textVStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .leading
    
    return stack
  }()
  
  private lazy var taskTextLabel: UILabel = {
    let label = UILabel.body(with: "")
    label.numberOfLines = 3
    
    return label
  }()
  
  private lazy var deadlineHStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.alignment = .center
    stack.isHidden = true
    stack.spacing = 2
    
    return stack
  }()
  
  private lazy var deadlineDateLabel: UILabel = {
    let label = UILabel.subhead(with: "")
    label.textColor = .aLabelTertiary
    
    return label
  }()
  
  private lazy var deadlineImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "Calendar")?.withTintColor(.aLabelTertiary)
    
    return imageView
  }()
  
  private lazy var chevronImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "Chevron")
    
    return imageView
  }()

  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    customInit()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func customInit() {
    setupConstraints()
    backgroundColor = .clear
    selectionStyle = .none
  }
  
  private func setupConstraints() {
    addSubview(mainContainer)
    mainContainer.addSubview(importanceIndicator)
    mainContainer.addSubview(textVStack)
    mainContainer.addSubview(chevronImageView)
    
    textVStack.addArrangedSubview(taskTextLabel)
    textVStack.addArrangedSubview(deadlineHStack)
    
    deadlineHStack.addArrangedSubview(deadlineImageView)
    deadlineHStack.addArrangedSubview(deadlineDateLabel)
    
    mainContainer.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.height.greaterThanOrEqualTo(56)
    }
    
    importanceIndicator.snp.makeConstraints { make in
      make.centerY.equalTo(textVStack.snp.centerY)
      make.leading.equalToSuperview().inset(16)
      make.height.width.equalTo(24)
    }
    
    chevronImageView.snp.makeConstraints { make in
      make.centerY.equalTo(textVStack.snp.centerY)
      make.trailing.equalToSuperview().inset(16)
      make.height.equalTo(11.9)
      make.width.equalTo(6.95)
    }

    textVStack.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(52)
      make.trailing.equalToSuperview().inset(38.95)
      make.top.bottom.equalToSuperview().inset(16)
    }
    
    deadlineHStack.snp.makeConstraints { make in
      make.height.equalTo(20)
      make.leading.bottom.equalToSuperview()
    }
    
    deadlineImageView.snp.makeConstraints { make in
      make.width.height.equalTo(16)
    }
    
    taskTextLabel.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.bottom.equalTo(deadlineHStack.snp.top)
    }
  }
  
  func configure(with viewModel: ToDoCellViewModel) {
    self.viewModel = viewModel
    
    taskTextLabel.text = viewModel.getText
    importanceIndicator.image = viewModel.getImportanceImage
    deadlineDateLabel.text = viewModel.getDeadlineDate
    
    deadlineHStack.isHidden = viewModel.deadline == nil
  }
  
  @objc func didTapDoneButton() {
    viewModel?.isDone.toggle()
  }
}
