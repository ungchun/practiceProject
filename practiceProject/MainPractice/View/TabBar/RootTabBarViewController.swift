import UIKit
import SnapKit

class RootTabBarViewController: UITabBarController {
    
    let home = HomeCoordinator(navigationController: UINavigationController.init())
    let media = AVPlayerCoordinator(navigationController: UINavigationController.init())
    let chat = ChatCoordinator(navigationController: UINavigationController.init())
    
    // MARK: Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        home.start()
        media.start()
        chat.start()
        
        // tabBar controller의 viewControllers -> Interface
        //
        viewControllers = [home.navigationController, media.navigationController, chat.navigationController]
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
