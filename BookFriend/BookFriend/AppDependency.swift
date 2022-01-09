//
//  AppDependency.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/27.
//

import Foundation
import Swinject

// App에 필요한 의존성들
class AppDependency {
    var window: UIWindow
    var appCoordinator: AppCoordinator
    let container = Container()
    
    init(
        window: UIWindow,
        appCoordinator: AppCoordinator
    ) {
        self.window = window
        self.appCoordinator = AppCoordinator(rootView: <#T##UINavigationController#>)
    }
    
    func resolve() {
        
    }
}
