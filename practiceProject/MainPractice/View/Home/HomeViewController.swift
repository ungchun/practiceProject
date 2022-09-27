import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    // TableViewCell안에 각자 CollectionViewCell을 가지고 있는 CollectionView이 들어감
    
    // HomeTableViewCellOne -> 가로로 무한히 도는 Carousel 가로 배너
    // HomeTableViewCellTwo -> horizontal 컬렉션 뷰
    // HomeTableViewCellThree -> vertical 컬렉션 뷰
    
    // MARK: Properties
    //
    weak var coordinator: HomeCoordinator?
    
    static let sectionTopPaddingValue = 10.0
    static let contentHorizontalPaddingValue = 10.0
    
    // MARK: Views
    //
    private lazy var homeTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(HomeTableViewCellOne.self, forCellReuseIdentifier: HomeTableViewCellOne.reuseIdentifier)
        //        tableView.register(HomeTableViewCellTwo.self, forCellReuseIdentifier: HomeTableViewCellTwo.reuseIdentifier)
        tableView.register(HomeTableViewCellTwo_DiffableDataSource.self, forCellReuseIdentifier: HomeTableViewCellTwo_DiffableDataSource.reuseIdentifier)
        tableView.register(HomeTableViewCellThree.self, forCellReuseIdentifier: HomeTableViewCellThree.reuseIdentifier)
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.bounces = true
        tableView.contentInset = .zero
        return tableView
    }()
    
    // MARK: Life Cylce
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(homeTableView)
        
        homeTableView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        homeTableView.dataSource = self
        homeTableView.delegate = self
    }
}

// MARK: Extension
//
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    // TableViewCell 3개
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // index에 맞춰 Cell return
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCellOne.reuseIdentifier, for: indexPath) as! HomeTableViewCellOne
            return cell
        case 1:
            //            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCellTwo.reuseIdentifier, for: indexPath) as! HomeTableViewCellTwo
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCellTwo_DiffableDataSource.reuseIdentifier, for: indexPath) as! HomeTableViewCellTwo_DiffableDataSource
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCellThree.reuseIdentifier, for: indexPath) as! HomeTableViewCellThree
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    // 각 Cell의 높이만큼 뷰에 보이게 함
    //
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.item {
        case 0:
            return HomeTableViewCellOne.cellOneHeight
        case 1:
            //            return HomeTableViewCellTwo.cellTwoHeight
            return HomeTableViewCellTwo_DiffableDataSource.cellTwoHeight
        case 2:
            return (UIScreen.main.bounds.width / 2 - (HomeTableViewCellThree.cellTwoHorizontalValue * 2 - (HomeTableViewCellThree.cellTwoHorizontalValue / 2))) * 5 + 100
        default:
            return CGFloat()
        }
    }
}
