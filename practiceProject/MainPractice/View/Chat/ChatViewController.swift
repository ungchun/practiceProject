import UIKit
import SnapKit
import SendbirdUIKit

class ChatViewController: UIViewController {
    
    // MARK: Properties
    //
    weak var coordinator: ChatCoordinator?
    
    // MARK: Views
    //
    private let centerLabel: UILabel = {
        let label = UILabel()
        label.text = "ChatViewController"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    @objc func testClick(sender: UITapGestureRecognizer) {
        let groupChannelListVC = SBUGroupChannelListViewController()
        let naviVC = UINavigationController(rootViewController: groupChannelListVC)
        self.present(naviVC, animated: true)
    }
    
    // MARK: Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(centerLabel)
        view.backgroundColor = .white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(testClick))
        centerLabel.addGestureRecognizer(tap)
        centerLabel.snp.makeConstraints { make in
            make.center.equalTo(view.center)
        }
    }
}
