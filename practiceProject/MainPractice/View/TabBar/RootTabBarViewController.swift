import UIKit
import SnapKit

class RootTabBarViewController: UITabBarController {
    
    //        let mainViewController = RootTabBarViewController() // 맨 처음 보여줄 ViewController
    //
    //        let homeVC = CoordinatorFirstViewController()
    //        let chatVC = ChatViewController()
    //
    //        // 탭바컨트롤러에 컨텐츠 컨트롤러 뷰 추가
    //        mainViewController.setViewControllers([homeVC, chatVC], animated: false)
    //
    //        homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), tag: 0)
    //        chatVC.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(systemName: "message"), tag: 1)
    //        homeVC.coordinator = self
    //        navigationController.pushViewController(mainViewController, animated: false)
        
    // MARK: Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.prompt = "UITabBarController"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
