import UIKit
import SnapKit

class RootTabBarViewController: UITabBarController {
        
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
