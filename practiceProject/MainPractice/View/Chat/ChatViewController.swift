import UIKit
import SnapKit

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
    
    // MARK: Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(centerLabel)
        view.backgroundColor = .white
        
        centerLabel.snp.makeConstraints { make in
            make.center.equalTo(view.center)
        }
    }
}
