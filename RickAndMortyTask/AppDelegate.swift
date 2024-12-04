//
//  AppDelegate.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    public var rootCoordinator: BaseCoordinatorProtocol?
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = AppWindow.shared
        window?.backgroundColor = .white
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        
        openSplashCoordinator()
        
        return true
    }

    func openSplashCoordinator() {
        guard let window = self.window else {
            return
        }
        struct UseCase: CharacterListCoordinatorUseCaseProtocol {
            var window: UIWindow
        }
        let root = CharacterListCoordinator(useCase: UseCase(window: window))
        rootCoordinator = root
        root.start()
    }


}

class AppWindow {
    static let shared = UIWindow(frame: UIScreen.main.bounds)
}

let appDelegate = UIApplication.shared.delegate as? AppDelegate
