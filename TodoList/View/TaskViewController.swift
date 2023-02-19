//
//  ViewController.swift
//  TodoList
//
//  Created by Evgeni Meleshin on 10.02.2023.
//

import UIKit

/// Контроллер задач 
class TaskViewController: UIViewController {
	
	let tasksAdapter = TasksAdapter()
	let tasksTableView = UITableView()
	let presenter: ITasksPresenter
	
	init(presenter: ITasksPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "To-do List"
		presenter.addView(view: self)
		tasksAdapter.presenter = presenter
		setupTableView()
		setupTableViewConstraints()
		presenter.getTasks()
	}
	
	private func setupTableView() {
		tasksTableView.translatesAutoresizingMaskIntoConstraints = false
		tasksTableView.delegate = tasksAdapter.self
		tasksTableView.dataSource = tasksAdapter
		tasksTableView.backgroundColor = .white
		tasksTableView.register(TaskViewCell.self, forCellReuseIdentifier: tasksAdapter.identifier)
		view.addSubview(tasksTableView)
	}
		
	private func setupTableViewConstraints() {
		tasksTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
		tasksTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
		tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
	}
	
}

extension TaskViewController: ITasksView {
		
	func render(viewDataArray: [ViewData]) {
		tasksAdapter.viewDataArray = viewDataArray
		tasksTableView.reloadData()
	}
	
}


