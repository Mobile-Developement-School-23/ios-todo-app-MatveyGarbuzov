//
//  ToDoCell.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 17.06.2023.
//

import UIKit
import SnapKit

class ToDoCell: UITableViewCell {
  
  // MARK: - Properties
  static let id = "ToDoCell"
  var viewModel: ToDoCellViewModel? {
    didSet {
      configure(with: viewModel!)
    }
  }

  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.textAlignment = .left
    return label
  }()
  
  private let doneButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 15
    button.layer.borderWidth = 1.5
    button.layer.borderColor = UIColor.gray.cgColor
    button.backgroundColor = .red
    return button
  }()
  
  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(doneButton)
    addSubview(nameLabel)
    doneButton.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
    
    doneButton.snp.makeConstraints { make in
      make.left.equalToSuperview()
      make.centerY.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.3)
      make.width.equalTo(doneButton.snp.height)
    }
    
    nameLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.left.equalTo(doneButton.snp.right).offset(16)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with viewModel: ToDoCellViewModel) {
    nameLabel.text = "\(viewModel.id) \(viewModel.createdAt.formatted())"
  }
  
  @objc func didTapDoneButton() {
    viewModel?.isDone.toggle()
    doneButton.backgroundColor = (viewModel?.isDone ?? false) ? .green : .red
  }
}
