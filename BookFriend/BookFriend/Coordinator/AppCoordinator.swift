//
//  AppCoordinator.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/27.
//

import UIKit

final class AppCoordinator: CoordinatorType {
    var navigationController: UINavigationController?
    var parentCoordinator: CoordinatorType? = nil
    var childCoordinators: [CoordinatorType] = []
    
    init(rootView: UINavigationController) {
        self.navigationController = rootView
    }
    
    func start() {
        guard let rootViewController = window?.rootViewController as? UINavigationController else { return false }
        guard let vc = rootViewController.viewControllers.first as? BookListViewController else { return false }
        
        let manager = NetworkManager(urlSession: URLSession.shared)
        
        vc.reactor = BookListReactor(manager: manager)
        
        let newPush = UIViewController()
        navigationController?.pushViewController(newPush, animated: true)
        // newPush.start()
    }
}
