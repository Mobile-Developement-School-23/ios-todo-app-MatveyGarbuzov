//
//  ToDoListViewController.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 17.06.2023.
//

import UIKit

class ToDoListViewController: UIViewController {
  
  private lazy var tableViewContainer = TableViewContainer()
  
  var viewModel = TasksViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavBar()
    setupConstraints()
    viewModel.loadData()
    setupDelegates()
  }
  
  private func setupDelegates() {
    tableViewContainer.buttonContainerDelegate = self
    tableViewContainer.delegate = self
    tableViewContainer.dataSource = self
  }
  
  private func setupConstraints() {
    view.addSubview(tableViewContainer)
    
    tableViewContainer.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}

extension ToDoListViewController {
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
}

extension ToDoListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let viewModel = viewModel.getDetailViewModel(for: indexPath.row)
    let presentVC = UINavigationController(rootViewController: DetailViewController(viewModel: viewModel))
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

extension ToDoListViewController: ButtonContainerDelegate {
  func plusButtonPressed() {
    let toDoItem = ToDoItem(text: "", importance: .normal, deadline: nil, changedAt: nil)
    let viewModel = DetailViewModel(toDoItem: toDoItem)
    
    let presentVC = UINavigationController(rootViewController: DetailViewController(viewModel: viewModel))
    navigationController?.present(presentVC, animated: true)
  }
}

