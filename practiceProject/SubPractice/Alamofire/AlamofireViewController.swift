import UIKit

class AlamofireViewController: UIViewController {
    
    private let centerLabel: UILabel = {
        let label = UILabel()
        label.text = "alamofire"
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
        
        //        AlamofireManager().getAPIWeatherData { result in
        //            print("completion = \(result)")
        //        }
        
        AlamofireManager().getAPIUsersData { result in
            print("completion = \(result)")
        }
    }
}
