//
//  CoordinatorType.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/27.
//

import Foundation
import UIKit

protocol CoordinatorType {
    var navigationController: UINavigationController? { get set }
    var parentCoordinator: CoordinatorType? { get set }
    var childCoordinators: [CoordinatorType] { get set }
    func start()
}
