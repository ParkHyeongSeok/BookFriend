//
//  SceneDelegate.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/05.
//

import UIKit
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let container = Container()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let rootViewController = window?.rootViewController as? UINavigationController else { return }
        guard let vc = rootViewController.viewControllers.first as? BookListViewController else { return }
        
        let manager = NetworkManager(urlSession: URLSession.shared)
        
        registerContainer()
        
        vc.reactor = BookListReactor(manager: manager)
    }
    
    func registerContainer() {
        container.register(URLSessionType.self, name: "real") { _ in
            return URLSession.shared
        }
        container.register(NetworkManager.self) { r in
            return NetworkManager(urlSession: r.resolve(URLSessionType.self, name: "real")!)
        }
        container.register(BookListReactor.self) { r in
            return BookListReactor(manager: r.resolve(NetworkManager.self)!)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

