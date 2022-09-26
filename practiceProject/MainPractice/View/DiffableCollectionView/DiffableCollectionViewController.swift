import UIKit
import SnapKit

class DiffableCollectionViewController: UIViewController {
    
    // MARK: Properties
    //
    weak var coordinator: CollectionCoordinator?
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var arr = ["Zedd", "Alan Walker", "David Guetta", "Avicii", "Marshmello", "Steve Aoki", "R3HAB", "Armin van Buuren", "Skrillex", "Illenium", "The Chainsmokers", "Don Diablo", "Afrojack", "Tiesto", "KSHMR", "DJ Snake", "Kygo", "Galantis", "Major Lazer", "Vicetone"
    ]
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    // 1. Connect a diffable data source to your collection view.
    enum Section: CaseIterable {
        case main
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    // MARK: Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(0)
        }
        self.setupSearchController()
        self.setupDataSource()
        self.performQuery(with: nil)
    }
    
    // MARK: functions
    //
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.searchResultsUpdater = self
        self.navigationItem.title = "Search DJ"
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupDataSource() {
        // MARK: - Way 1
        // 2. Implement a cell provider to configure your collection view's cells.
        self.collectionView.register(DJCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.dataSource =
        UICollectionViewDiffableDataSource<Section, String>(collectionView: self.collectionView) { (collectionView, indexPath, dj) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DJCollectionViewCell else { preconditionFailure() }
            cell.configure(text: dj)
            return cell
        }
    }
    
    // 3. Generate the current state of the data.
    func performQuery(with filter: String?) {
        let filtered = self.arr.filter { $0.hasPrefix(filter ?? "") }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filtered)
        // 4. Display the data in the UI.
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            let contentSize = layoutEnvironment.container.effectiveContentSize
            let columns = contentSize.width > 800 ? 3 : 2
            let spacing = CGFloat(10)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(32))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            group.interItemSpacing = .fixed(spacing)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            return section
        }
        return layout
    }
}

extension DiffableCollectionViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text
        self.performQuery(with: text)
    }
}

class DJCollectionViewCell: UICollectionViewCell {
    
    weak var label: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.backgroundColor = .lightGray
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor.black.cgColor
        
        let label = UILabel()
        label.textAlignment = .center
        label.frame = self.contentView.frame
        self.contentView.addSubview(label)
        self.label = label
    }
    
    func configure(text: String) {
        self.label?.text = text
    }
}
