import UIKit

class HomeTableViewCellTwo: UITableViewCell {
    
    // MARK: Properties
    //
    static let reuseIdentifier = String(describing: HomeTableViewCellTwo.self)
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
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.delegate = self
        
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

// MARK: Extension
//
extension HomeTableViewCellTwo: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCellTwo.reuseIdentifier, for: indexPath) as! HomeCollectionViewCellTwo
        cell.uiView.backgroundColor = .lightGray
        return cell
    }
}

extension HomeTableViewCellTwo: UICollectionViewDelegateFlowLayout {
    // 각 cell의 width, height 값 세팅
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
