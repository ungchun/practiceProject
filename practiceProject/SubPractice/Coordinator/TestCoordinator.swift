import Foundation
import UIKit

// Coordinator Protocol
//
protocol TestCoordinator: AnyObject {
    var childCoordinators: [TestCoordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

// 부모가 되는 제일 상단 Coordinator 각 그룹의 ChildCoordinator들을 가지고 있음
//
class TestMainCoordinator: TestCoordinator {
    
    var childCoordinators = [TestCoordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // SceneDelegate에서 rootVC -> navController 넘어오면 보여줄 첫 화면
    //
    func start(){
        print("ParentCoordinator start")
        let vc = CoordinatorFirstViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    // MainCoordinator - ChildCoordinator 관계를 맺어줌
    //
    func pushSecondView(testValue: String) {
        let child = TestSecondCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        child.testValue = testValue
        childCoordinators.append(child)
        child.start()
    }
    
    // ParentCoordinator에서 ChildCoordinator 제거
    // 부모 코디네이터네서는 파라미터로 넘어온 자식 코디네이터를 찾아서 제거한다.
    //
    func childDidFinish(_ child: TestCoordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

// MainCoordinator로만 관리하면 불필요한 화면 전환 메서드까지 가진다.
// 이렇게 ChildCoordinator로 분리시키면 각 Coordinator는 현재 필요로 하는 화면전환 메서드만 보유한다.
//
class TestSecondCoordinator: TestCoordinator {
    
    // 부모 코디네이터와 자식 코디네이터는 서로를 알기 때문에 메모리 참조 순환 문제가 발생한다.
    // 이를 해결하기 위해서는 weak 키워드를 붙여주어야 한다.
    //
    weak var parentCoordinator: TestMainCoordinator?
    
    var childCoordinators = [TestCoordinator]()
    var navigationController: UINavigationController
    
    var testValue: String?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("TestSecondCoordinator start")
        let vc = CoordinatorSecondViewController()
        vc.coordinator = self
        vc.receiveValue = testValue
        navigationController.pushViewController(vc, animated: false)
    }
    
    // ChildCoordinator는 일을 다하고, 부모에게 자신이 종료 되었음을 알린다.
    //
    func didFinishSecond() {
        parentCoordinator?.childDidFinish(self)
    }
}


