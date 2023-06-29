//
//  TableViewContainer.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 28.06.2023.
//



import UIKit

final class TableViewContainer: UIView {
  
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    customInit()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func customInit() {
    addAction()
    setupConstraints()
    setupTableView()
  }
  
  private func addAction() {
    
  }
  
  private func setupConstraints() {
    
  }
  
  private func setupTableView() {
//    toDoListTableView.delegate = self
//    toDoListTableView.dataSource = self
//    toDoListTableView.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.id)
  }
}
