//
//  SceneDelegate.swift
//  TodoList
//
//  Created by Evgeni Meleshin on 10.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		let presenter: ITasksPresenter = TasksPresenter()
		let taskViewController = TaskViewController(presenter: presenter)
		let navigationController = UINavigationController(rootViewController: taskViewController)
		self.window = UIWindow(windowScene: windowScene)
		self.window?.rootViewController = navigationController
		self.window?.makeKeyAndVisible()
	}
	
}
