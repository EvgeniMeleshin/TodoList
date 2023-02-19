//
//  TasksAdapter.swift
//  TodoList
//
//  Created by Evgeni Meleshin on 18.02.2023.
//

import UIKit

/// Класс адаптера
final class TasksAdapter : NSObject, UITableViewDelegate, UITableViewDataSource {
	let identifier = "cell"
	var viewDataArray: [ViewData]?
	var presenter: ITasksPresenter? = nil
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		SectionsTypes(rawValue: section)?.description
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		SectionsTypes.allCases.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let viewDataArray = viewDataArray else { return 0 }
		let rowsInSection = viewDataArray.filter ({ $0.section == section })
		return rowsInSection.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TaskViewCell
		guard let viewDataArray = viewDataArray else { return cell }
		guard let task = viewDataArray.first (where: { item in item.section == indexPath.section && item.row == indexPath.row })
		else { return cell}
		cell.item = task
		let pinkColor = #colorLiteral(red: 1, green: 0.8035419583, blue: 0.8338577151, alpha: 1)
		cell.backgroundColor = task.overdue ? pinkColor : .white
		cell.checkbox.isChecked = task.completed
		cell.checkbox.toggle()
		cell.completeAction = { [weak self] isChecked in
			guard let adapter = self else { return }
			adapter.presenter?.completeTask(id: task.id)
		}
		return cell
	}
	
}
