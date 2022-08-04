import UIKit

class EscapingViewController: UIViewController {
    
    private let centerLabel: UILabel = {
        let label = UILabel()
        label.text = "delegate"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.self.addSubview(centerLabel)
        
        centerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        centerLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        centerLabel.addGestureRecognizer(tap)
        
        demoCompletin { escapingValue in
            print("escapingValue = \(escapingValue)")
        }
    }
    
    @objc
    func tapAction() {
        print("tapAction")
        
        demoCompletin { escapingValue in
            print("escapingValue = \(escapingValue)")
        }
    }
    
    func demoCompletin(completion: @escaping(String) -> ()) {
        print("call demoCompletin")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion("sunghun")
        }
    }
}
