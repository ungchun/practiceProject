import UIKit
import SnapKit

class ChatViewController: UIViewController {
    
    private let centerLabel: UILabel = {
        let label = UILabel()
        label.text = "ChatViewController"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(centerLabel)
        view.backgroundColor = .white
        
        centerLabel.snp.makeConstraints { make in
            make.center.equalTo(view.center)
        }

    }
}
