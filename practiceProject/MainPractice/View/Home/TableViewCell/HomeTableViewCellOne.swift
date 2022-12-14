import UIKit

class HomeTableViewCellOne: UITableViewCell {
    
    // MARK: Properties
    //
    static let reuseIdentifier = String(describing: HomeTableViewCellOne.self)
    static let cellOneHeight = 300.0
    let colors: [UIColor] = [.red, .orange, .yellow, .green, .blue]
    var progress: Progress?
    var timer: Timer?
    
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
    
    // MARK: Life Cycle
    //
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
        
        // colors * 3 ?????? index 0?????? ?????? ????????? index??? ???????????? ???
        //
        let segmentSize = colors.count
        carouselCollectionView.scrollToItem(at: IndexPath(item: segmentSize, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: functions
    //
    // progress ??????
    //
    private func configureProgressView() {
        carouselProgressView.progress = 0.0
        progress = Progress(totalUnitCount: Int64(colors.count))
        progress?.completedUnitCount = 1
        carouselProgressView.setProgress(Float(progress!.fractionCompleted), animated: false)
    }
    
    // ????????? ?????????
    //
    private func invalidateTimer() {
        timer?.invalidate()
    }
    
    // ????????? ??????
    //
    private func activateTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
    }
    
    // ?????? ????????? content??? IndexPath
    //
    private func visibleCellIndexPath() -> IndexPath {
        return carouselCollectionView.indexPathsForVisibleItems[0]
    }
    
    // ??????????????? ?????? ???????????? ?????????
    //
    @objc
    func timerCallBack() {
        var item = visibleCellIndexPath().item
        
        // ?????? ????????? ?????? ??? ?????? ???????????? ??????????????? ??????
        //
        if item == colors.count * 3 - 1 {
            carouselCollectionView.scrollToItem(at: IndexPath(item: colors.count * 2 - 1, section: 0), at: .centeredHorizontally, animated: false)
            item = colors.count * 2 - 1
        }
        
        item += 1
        
        // ?????????????????? ??????????????? custome cell ??????????????? ????????? ????????? scrollToItem ?????? ???????????? ?????????..
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
// ??? ????????? ????????? ??????????????? ??? ?????? ?????? ????????? -> ????????? 0??? ?????????.
// cell list??? 3?????? ??????????????? ????????? ????????? ???????????? ?????? ??????.
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
        
        // ?????? ?????? ?????? ?????? ????????? ?????? ??? ?????? ???????????? ??????????????? ??????
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
