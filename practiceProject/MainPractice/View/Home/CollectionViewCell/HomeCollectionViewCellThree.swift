import UIKit
import SnapKit

class HomeCollectionViewCellThree: UICollectionViewCell {
    
    // MARK: Properties
    //
    static let reuseIdentifier = String(describing: HomeCollectionViewCellThree.self)
    
    // MARK: Views
    //
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ungchun"
        return label
    }()
    private lazy var uiView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()
    
    // MARK: Life Cylce
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackView)
        stackView.addArrangedSubview(uiView)
        stackView.addArrangedSubview(label)
        
        stackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(0)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
