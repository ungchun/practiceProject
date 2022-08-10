import UIKit

class CoordinatorSecondViewController: UIViewController {
    
    weak var coordinator: TestSecondCoordinator?
    
    var receiveValue: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        print("CoordinatorSecondViewController \(receiveValue!)")
    }
    
    // ChildCoordinator는 일을 다하고, 부모에게 자신이 종료 되었음을 알린다.
    //
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("CoordinatorSecondViewController viewDidDisappear")
        coordinator?.didFinishSecond()
    }
}
