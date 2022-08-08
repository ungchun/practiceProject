import UIKit
import SnapKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: HomeCollectionViewCell.self)
    
    // MARK: Views
    //
    var uiView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: Life Cylce
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(uiView)
        uiView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(0)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
