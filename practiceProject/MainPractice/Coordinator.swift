import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

// HomeTab의 MainCoordinator
//
class HomeCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("HomeCoordinator start")
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), tag: 0)
        homeVC.coordinator = self
        navigationController.pushViewController(homeVC, animated: false)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

// AVPlayerTab의 MainCoordinator
//
class AVPlayerCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("AVPlayerCoordinator start")
        
        // AudioViewController
        //
        // let audioVC = AudioViewController()
        // audioVC.tabBarItem = UITabBarItem(title: "AVPlayer", image: UIImage(systemName: "video"), tag: 1)
        // audioVC.coordinator = self
        // navigationController.pushViewController(audioVC, animated: false)
        
        // VideoViewController
        //
        let videoVC = VideoViewController()
        videoVC.tabBarItem = UITabBarItem(title: "AVPlayer", image: UIImage(systemName: "video"), tag: 1)
        videoVC.coordinator = self
        navigationController.pushViewController(videoVC, animated: false)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}


// ChatTab의 MainCoordinator
//
class ChatCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("ChatCoordinator start")
        let chatVC = ChatViewController()
        chatVC.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(systemName: "message"), tag: 1)
        chatVC.coordinator = self
        navigationController.pushViewController(chatVC, animated: false)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

// DiffableCollectionView
//
class CollectionCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("CollectionCoordinator start")
        let collectionVC = DiffableCollectionViewController()
        collectionVC.tabBarItem = UITabBarItem(title: "Diffable 1", image: UIImage(systemName: "pencil"), tag: 1)
        collectionVC.coordinator = self
        navigationController.pushViewController(collectionVC, animated: false)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

