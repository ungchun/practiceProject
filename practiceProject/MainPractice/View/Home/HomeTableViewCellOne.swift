import UIKit

class HomeTableViewCellOne: UITableViewCell {
    
    static let reuseIdentifier = String(describing: HomeTableViewCellOne.self)
    static let cellOneHeight = 300.0
    
    // MARK: Properties
    //
    let colors: [UIColor] = [.red, .orange, .yellow, .green, .blue]
    var progress: Progress?
    var timer: Timer?
    var viewDidLayoutCheck = false
    
    // MARK: Views
    //
    var carouselCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    private lazy var carouselProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = .gray
        progressView.progressTintColor = .white
        return progressView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(carouselCollectionView)
        contentView.addSubview(carouselProgressView)
        
        carouselCollectionView.register(HomeCollectionViewCellOne.self, forCellWithReuseIdentifier: HomeCollectionViewCellOne.reuseIdentifier)
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        
        carouselCollectionView.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width)
            make.height.equalTo(HomeTableViewCellOne.cellOneHeight)
            make.top.equalTo(self.safeAreaLayoutGuide)
        }
        
        carouselProgressView.snp.makeConstraints { make in
            make.width.equalTo(self.frame.width * 0.8)
            make.centerX.equalTo(self.contentView)
            make.bottom.equalTo(carouselCollectionView.snp.bottom).offset(-20)
        }
        
        configureProgressView()
        activateTimer()
        
        let segmentSize = colors.count
        carouselCollectionView.scrollToItem(at: IndexPath(item: segmentSize, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    override func prepareForReuse() {
    //      super.prepareForReuse()
    //        self.prepare(progress: nil, timer: nil)
    //    }
    //    func prepare(progress: Progress?, timer: Timer?) {
    //        self.progress = progress
    //        self.timer = timer
    //        self.viewDidLayoutCheck = false
    //    }
    
    
    // progress 세팅
    //
    private func configureProgressView() {
        carouselProgressView.progress = 0.0
        progress = Progress(totalUnitCount: Int64(colors.count))
        progress?.completedUnitCount = 1
        carouselProgressView.setProgress(Float(progress!.fractionCompleted), animated: false)
    }
    
    // 타이머 초기화
    //
    private func invalidateTimer() {
        timer?.invalidate()
    }
    // 타이머 세팅
    //
    private func activateTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
    }
    
    // 현재 보이는 content의 IndexPath
    //
    private func visibleCellIndexPath() -> IndexPath {
        return carouselCollectionView.indexPathsForVisibleItems[0]
    }
    
    // 시간지나면 배너 움직이는 매서드
    //
    @objc
    func timerCallBack() {
        var item = visibleCellIndexPath().item
        
        // 제일 끝으로 갔을 때 다시 중간으로 이동시키는 코드
        //
        if item == colors.count * 3 - 1 {
            carouselCollectionView.scrollToItem(at: IndexPath(item: colors.count * 2 - 1, section: 0), at: .centeredHorizontally, animated: false)
            item = colors.count * 2 - 1
        }
        
        item += 1
        
        // 배너형식으로 움직이면서 custome cell 사용하려면 이렇게 안하면 scrollToItem 이거 이상하게 돌아감..
        //
        carouselCollectionView.delegate = self
        carouselCollectionView.reloadData()
        carouselCollectionView.layoutIfNeeded()
        
        carouselCollectionView.scrollToItem(at: IndexPath(item: item, section: 0), at: .centeredHorizontally, animated: true)
        
        let unitCount: Int = item % colors.count + 1
        progress?.completedUnitCount = Int64(unitCount)
        carouselProgressView.setProgress(Float(progress!.fractionCompleted), animated: false)
    }
    
}

// MARK: extension
//
// 맨 처음과 끝에서 드래그하면 그 다음 셀이 보인다 -> 시작이 0이 아니다.
// cell list를 3개를 이어붙여서 시작과 동시에 중간으로 오게 한다.
//
extension HomeTableViewCellOne: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count * 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let color = colors[indexPath.item % colors.count]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCellOne.reuseIdentifier, for: indexPath) as! HomeCollectionViewCellOne
        cell.uiView.backgroundColor = color
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // cell click
    }
}

extension HomeTableViewCellOne: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        invalidateTimer()
        activateTimer()
        
        // 제일 처음 또는 제일 끝으로 갔을 때 다시 중간으로 이동시키는 코드
        //
        var item = visibleCellIndexPath().item
        if item == colors.count * 3 - 1 {
            item = colors.count * 2 - 1
        } else if item == 1 {
            item = colors.count + 1
        }
        
        carouselCollectionView.scrollToItem(at: IndexPath(item: item, section: 0), at: .centeredHorizontally, animated: false)
        
        let unitCount: Int = item % colors.count + 1
        progress?.completedUnitCount = Int64(unitCount)
        carouselProgressView.setProgress(Float(progress!.fractionCompleted), animated: false)
    }
}

extension HomeTableViewCellOne: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: carouselCollectionView.frame.width, height: carouselCollectionView.frame.height)
    }
}
