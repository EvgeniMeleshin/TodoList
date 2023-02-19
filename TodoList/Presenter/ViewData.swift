//
//  ViewData.swift
//  TodoList
//
//  Created by Evgeni Meleshin on 18.02.2023.
//

import Foundation

/// Структура view модели
struct ViewData: Hashable {
	let title: String
	var completed: Bool
	let priority: String
	let completionDate: String
	var section: Int
	var row: Int
	var id: String
	let overdue: Bool
	
	init(title: String, completed: Bool, priority: String, completionDate: String, section: Int, row: Int, id: String, overdue: Bool = false) {
		self.title = title
		self.completed = completed
		self.priority = priority
		self.completionDate = completionDate
		self.section = section
		self.row = row
		self.id = id
		self.overdue = overdue
	}
	
}
