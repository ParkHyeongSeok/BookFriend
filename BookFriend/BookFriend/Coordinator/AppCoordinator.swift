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
        let newPush = UIViewController()
        navigationController?.pushViewController(newPush, animated: true)
        // newPush.start()
    }
}
