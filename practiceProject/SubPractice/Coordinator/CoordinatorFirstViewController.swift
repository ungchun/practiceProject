import UIKit
import SnapKit

class CoordinatorFirstViewController: UIViewController {
    
    weak var coordinator: TestMainCoordinator?
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Coordinator"
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.center.equalTo(view.center)
        }
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
    }
    
    @objc
    func tapAction() {
        // coordinator를 이용해 testValue 데이터를 넘기면서 push
        //
        self.coordinator?.pushSecondView(testValue: "coordinator 데이터 넘김")
    }
}
