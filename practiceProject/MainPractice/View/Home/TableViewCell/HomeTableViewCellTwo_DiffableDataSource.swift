import UIKit

enum Section: CaseIterable {
    case main
}

struct Mountain: Hashable {
    let name: String
    let height: Int
    let identifier = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

// HomeTableViewCellTwo 컬렉션뷰 DiffableDataSource 버전
//
class HomeTableViewCellTwo_DiffableDataSource: UITableViewCell {
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Mountain>!
    
    // MARK: Properties
    //
    static let reuseIdentifier = String(describing: HomeTableViewCellTwo_DiffableDataSource.self)
    static let cellTwoHeight = 150.0
    
    // MARK: Views
    //
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .white
        stackView.spacing = 5
        return stackView
    }()
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "horizontal 컬렉션 뷰"
        label.font = UIFont(name: label.font.fontName, size: 20)
        return label
    }()
    
    private lazy var horizontalCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 5 // 행과 열 사이 간격
        flowLayout.minimumInteritemSpacing = 0 // 행 사이 간격
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    // MARK: Life Cycle
    //
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(horizontalCollectionView)
        
        horizontalCollectionView.register(HomeCollectionViewCellTwo.self, forCellWithReuseIdentifier: HomeCollectionViewCellTwo.reuseIdentifier)
        
        self.dataSource =
        UICollectionViewDiffableDataSource<Section, Mountain>(collectionView: self.horizontalCollectionView) { (collectionView, indexPath, dj) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCellTwo.reuseIdentifier, for: indexPath) as? HomeCollectionViewCellTwo else { preconditionFailure() }
            cell.uiView.backgroundColor = .red
            return cell
        }
        
        let mountain = Mountain(name: "name", height: 123)
        let mountain1 = Mountain(name: "name", height: 123)
        let mountain2 = Mountain(name: "name", height: 123)
        let mountainArray: Array<Mountain> = [mountain, mountain1, mountain2]
        var snapshot = NSDiffableDataSourceSnapshot<Section, Mountain>()
        snapshot.appendSections([.main])
        snapshot.appendItems(mountainArray)
        
        //        for section in [.main] {
        //          snapshot.appendItems(storage.modelsForSection(section), toSection: section)
        //        }
        
        dataSource.apply(snapshot)
        
        stackView.snp.makeConstraints { make in
            make.height.equalTo(HomeTableViewCellTwo.cellTwoHeight)
            make.top.equalTo(self.safeAreaLayoutGuide).inset(HomeViewController.sectionTopPaddingValue)
            make.left.right.equalTo(self.safeAreaLayoutGuide).inset(HomeViewController.contentHorizontalPaddingValue)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
