import UIKit
import SnapKit

class HomeTableViewCellThree: UITableViewCell {
    
    // MARK: Properties
    //
    static let reuseIdentifier = String(describing: HomeTableViewCellThree.self)
    static let cellTwoHorizontalValue = 5.0
    
    // MARK: Views
    //
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "vertical 컬렉션 뷰"
        label.font = UIFont(name: label.font.fontName, size: 20)
        return label
    }()
    private lazy var verticalCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
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
        stackView.addArrangedSubview(verticalCollectionView)
        
        verticalCollectionView.register(HomeCollectionViewCellThree.self, forCellWithReuseIdentifier: HomeCollectionViewCellThree.reuseIdentifier)
        verticalCollectionView.dataSource = self
        verticalCollectionView.delegate = self
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(self.safeAreaLayoutGuide).inset(HomeViewController.sectionTopPaddingValue * 2)
            make.left.right.equalTo(self.safeAreaLayoutGuide).inset(HomeTableViewCellThree.cellTwoHorizontalValue)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Extension
//
extension HomeTableViewCellThree: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCellThree.reuseIdentifier, for: indexPath) as! HomeCollectionViewCellThree
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
}

extension HomeTableViewCellThree: UICollectionViewDelegate {
    
}

extension HomeTableViewCellThree: UICollectionViewDelegateFlowLayout {
    // 각 cell의 width, height
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = UIScreen.main.bounds.width / 2 - (HomeTableViewCellThree.cellTwoHorizontalValue * 2 - (HomeTableViewCellThree.cellTwoHorizontalValue / 2))
        let size = CGSize(width: width, height: width)
        return size
    }
}
