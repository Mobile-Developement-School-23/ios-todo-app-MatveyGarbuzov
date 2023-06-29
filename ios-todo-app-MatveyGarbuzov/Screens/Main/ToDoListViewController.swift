//
//  ToDoListViewController.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 17.06.2023.
//

import UIKit

class ToDoListViewController: UIViewController {
  
  private lazy var doneHStack = DoneHStack()
  
  private lazy var toDoListTableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .clear
    tableView.estimatedRowHeight = UITableView.automaticDimension
    tableView.backgroundColor = .aBackSecondary
    tableView.layer.cornerRadius = 16
    tableView.showsVerticalScrollIndicator = false
    
    return tableView
  }()
  
//  private lazy var toDoListTableView = TableViewContainer()
  private lazy var plusButton = PlusButton()
  
  var viewModel = TasksViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavBar()
    setupConstraints()
    addAction()
    viewModel.loadData()
//    plusButtonPressed()
    setupTableView()
  }
  
  private func setupNavBar() {
    view.backgroundColor = .aBackIOSPrimary
    title = "Мои дела"
    
    let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 34), .kern: 0.37]
    navigationController?.navigationBar.largeTitleTextAttributes = attributes
    navigationController?.navigationBar.prefersLargeTitles = true
   
    if var margins = navigationController?.navigationBar.layoutMargins {
        margins.left = 32
        navigationController?.navigationBar.layoutMargins = margins
    }
  }
  
  private func setupTableView() {
    toDoListTableView.delegate = self
    toDoListTableView.dataSource = self
    toDoListTableView.register(ToDoCell.self, forCellReuseIdentifier: "ToDoCell")
  }
  
  private func setupConstraints() {
    view.addSubview(doneHStack)
    view.addSubview(toDoListTableView)
    view.addSubview(plusButton)
    
    doneHStack.snp.makeConstraints { make in
      make.height.equalTo(20)
      make.leading.trailing.equalToSuperview().inset(32)
      make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
    }
    
    toDoListTableView.snp.makeConstraints { make in
      make.top.equalTo(doneHStack.snp.bottom).offset(12)
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
      make.bottom.equalToSuperview()
    }
    
    plusButton.snp.makeConstraints { make in
      make.width.height.equalTo(44)
      make.centerX.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  private func addAction() {
    plusButton.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
  }
  
  @objc func plusButtonPressed() {
    let presentVC = UINavigationController(rootViewController: DetailViewController())
    navigationController?.present(presentVC, animated: true)
  }
}

extension ToDoListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let presentVC = UINavigationController(rootViewController: DetailViewController())
    navigationController?.present(presentVC, animated: true)
  }
}

extension ToDoListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.toDoItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.id, for: indexPath) as? ToDoCell else {
      return UITableViewCell()
    }
    
    let viewModel = viewModel.getCellViewModel(for: indexPath.row)
    cell.configure(with: viewModel)
    
    return cell
  }
}
