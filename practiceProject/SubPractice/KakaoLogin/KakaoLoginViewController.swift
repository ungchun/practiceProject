import UIKit
import SnapKit
import Combine

class KakaoLoginViewController: UIViewController {
    
    var subscriptions = Set<AnyCancellable>()
    
    lazy var kakaoLoginStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인 여부 라벨"
        return label
    }()
    lazy var kakaoLoginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("카카오 로그인", for: .normal)
        btn.configuration = .filled()
        btn.addTarget(self, action: #selector(logoinBtnClicked), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var kakaoLogoutButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("카카오 로그아웃", for: .normal)
        btn.configuration = .filled()
        btn.addTarget(self, action: #selector(logoutBtnClicked), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var kakaoAuthVM: KakaoAuthVM = {
        KakaoAuthVM()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        kakaoLoginStatusLabel.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(70)
        }
        
        stackView.addArrangedSubview(kakaoLoginStatusLabel)
        stackView.addArrangedSubview(kakaoLoginButton)
        stackView.addArrangedSubview(kakaoLogoutButton)
        
        self.view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
        
        setBindings()
    } // viewDidLoad()
    
    @objc
    func logoinBtnClicked() {
        print("logoinBtnClicked() called")
        kakaoAuthVM.kakaoLogin()
    }
    @objc
    func logoutBtnClicked() {
        print("logoutBtnClicked() called")
        kakaoAuthVM.kakaoLogout()
    }
}

// 뷰모델 바인딩
//
extension KakaoLoginViewController {
    func setBindings() {
        
        // 클로저에서 self를 쓰게 되면 strong reference cycle 일어날 수 있다. (메모리 누수 ?)
        // 그래서 클로저 안에서 self를 쓸 일이 있다면 이렇게 [weak self]를 써주면 strong reference cycle 예방할 수 있다.
        // 결론 : 클로저 내부에서 self를 쓴다면 습관적으로 [weak self]를 쓰는 습관을 들이자.
        //
        self.kakaoAuthVM.$isLoggedIn.sink { [weak self] isLoggedIn in
            guard let self = self else { return }
            self.kakaoLoginStatusLabel.text = isLoggedIn ? "로그인 상태" : "로그아웃 상태"
        }.store(in: &subscriptions)
        
        // 원래 위에처럼 많이 쓰지만 이렇게도 가능하다.
        //
        self.kakaoAuthVM.loginStatusInfo
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: self.kakaoLoginStatusLabel)
            .store(in: &subscriptions)
    }
}
