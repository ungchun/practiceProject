import UIKit
import Combine

class CombineViewController: UIViewController {
    
    private let viewModel = CombineViewModel()
    
    var disposalbleBag = Set<AnyCancellable>()
    
    private let centerLabel: UILabel = {
        let label = UILabel()
        label.text = "MVVMCombine"
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
        
        // 뷰모델의 데이터를 뷰컨의 데이터와 연동
        //
        setBindings()
    }
    
    @objc
    func tapAction() {
        print("tapAction")
        viewModel.updateValue()
    }
    
    // 뷰모델의 데이터를 뷰컨의 데이터와 연동
    //
    func setBindings() {
        self.viewModel.$combineValue.sink { updateValue in
            DispatchQueue.main.async {
                self.centerLabel.text = updateValue
            }
        }.store(in: &disposalbleBag)
    }
}
