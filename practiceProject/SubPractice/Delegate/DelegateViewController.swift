import UIKit

protocol TapDelegate: AnyObject {
    func delegateTapAction(value: String)
}

class DelegateViewController: UIViewController {
    
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
    }
    
    @objc
    func tapAction() {
        print("tapAction")
        let secondVC = SecondViewController()
        secondVC.delegate = self
        self.present(secondVC, animated: true, completion: nil)
    }
}

extension DelegateViewController: TapDelegate {
    func delegateTapAction(value: String) {
        print("delegate : \(value)")
    }
}
