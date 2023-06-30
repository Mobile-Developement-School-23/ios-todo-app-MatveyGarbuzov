//
//  TableViewContainer.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 28.06.2023.
//



import UIKit

protocol ButtonContainerDelegate: AnyObject {
  func plusButtonPressed()
}

final class TableViewContainer: UIView {
  
  weak var buttonContainerDelegate: ButtonContainerDelegate?
  
  private lazy var doneHStack = DoneHStack()
  private lazy var toDoListTableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .clear
    tableView.estimatedRowHeight = UITableView.automaticDimension
    tableView.backgroundColor = .aBackSecondary
    tableView.layer.cornerRadius = 16
    tableView.showsVerticalScrollIndicator = false
    tableView.register(ToDoCell.self, forCellReuseIdentifier: "ToDoCell")
    
    return tableView
  }()
  
  private lazy var plusButton = PlusButton()
  
  var dataSource: UITableViewDataSource? {
    get {
      return toDoListTableView.dataSource
    }
    set {
      toDoListTableView.dataSource = newValue
    }
  }
  
  var delegate: UITableViewDelegate? {
    get {
      return toDoListTableView.delegate
    }
    set {
      toDoListTableView.delegate = newValue
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    customInit()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateTableView() {
    print("NOT RELOADING DATA")
    toDoListTableView.reloadData()
  }
  
  private func customInit() {
    addAction()
    setupConstraints()
  }
  
  private func addAction() {
    plusButton.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
  }
  
  private func setupConstraints() {
    addSubview(doneHStack)
    addSubview(toDoListTableView)
    addSubview(plusButton)
    
    doneHStack.snp.makeConstraints { make in
      make.height.equalTo(20)
      make.leading.trailing.equalToSuperview().inset(32)
      make.top.equalTo(safeAreaLayoutGuide).offset(8)
    }
    
    toDoListTableView.snp.makeConstraints { make in
      make.top.equalTo(doneHStack.snp.bottom).offset(12)
      make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(10)
      make.bottom.equalToSuperview()
    }
    
    plusButton.snp.makeConstraints { make in
      make.width.height.equalTo(44)
      make.centerX.equalToSuperview()
      make.bottom.equalTo(safeAreaLayoutGuide)
    }
  }
  
  @objc func plusButtonPressed() {
    buttonContainerDelegate?.plusButtonPressed()
  }
}
