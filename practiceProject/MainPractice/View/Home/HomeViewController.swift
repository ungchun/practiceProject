import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    // MARK: Properties
    //
    
    // MARK: Views
    //
    private lazy var homeTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(HomeTableViewCellOne.self, forCellReuseIdentifier: HomeTableViewCellOne.reuseIdentifier)
        tableView.register(HomeTableViewCellTwo.self, forCellReuseIdentifier: HomeTableViewCellTwo.reuseIdentifier)
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
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        homeTableView.dataSource = self
        homeTableView.delegate = self
        //        homeTableView.rowHeight = 300
        
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("indexPath.item \(indexPath.item)")
        
        if indexPath.item == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCellOne.reuseIdentifier, for: indexPath) as! HomeTableViewCellOne
            return cell
        } else if indexPath.item == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCellTwo.reuseIdentifier, for: indexPath) as! HomeTableViewCellTwo
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCellThree.reuseIdentifier, for: indexPath) as! HomeTableViewCellThree
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0 {
            return HomeTableViewCellOne.cellOneHeight
        } else if indexPath.item == 1 {
            return HomeTableViewCellTwo.cellTwoHeight
        } else {
            return (UIScreen.main.bounds.width / 2 - (HomeTableViewCellThree.cellTwoHorizontalValue * 2 - (HomeTableViewCellThree.cellTwoHorizontalValue / 2))) * 5 + 100
        }
    }
}
