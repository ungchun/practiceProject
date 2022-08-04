import UIKit

class SecondViewController: UIViewController {
    
    weak var delegate: (TapDelegate)?
    
    private let centerLabel: UILabel = {
        let label = UILabel()
        label.text = "secondVC delegate"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        view.self.addSubview(centerLabel)
        
        centerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        centerLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        centerLabel.addGestureRecognizer(tap)
    }
    
    @objc
    func tapAction() {
        print("secondVC tapAction")
        delegate?.delegateTapAction(value: "hi delegate")
    }
}
