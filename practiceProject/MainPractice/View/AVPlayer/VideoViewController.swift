import UIKit
import AVKit
import AVFoundation

class VideoViewController: UIViewController {
    
    // MARK: Properties
    //
    weak var coordinator: AVPlayerCoordinator?
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private let url: String = "https://bitmovin-a.akamaihd.net/content/art-of-motion_drm/m3u8s/11331.m3u8"
    
    var elapsedTimeSecondsFloat: Float64 = 0 {
        didSet {
            guard self.elapsedTimeSecondsFloat != oldValue else { return }
            self.progressValue = self.elapsedTimeSecondsFloat / self.totalTimeSecondsFloat
        }
    }
    var totalTimeSecondsFloat: Float64 = 0
    var progressValue: Float64? {
        didSet {
            self.slider.value = Float(self.elapsedTimeSecondsFloat / self.totalTimeSecondsFloat) }
    }
    
    // MARK: Views
    //
    private lazy var videoBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    // MARK: Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(videoBackgroundView)
        view.addSubview(slider)
        
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            self.videoBackgroundView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.videoBackgroundView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.videoBackgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -200),
            self.videoBackgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.slider.topAnchor.constraint(equalTo: self.videoBackgroundView.bottomAnchor, constant: 16),
            self.slider.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.slider.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setAVPlayer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        player!.pause()
        player!.replaceCurrentItem(with: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.playerLayer!.frame = self.videoBackgroundView.bounds
    }
    
    // MARK: functions
    //
    func setAVPlayer() {
        self.slider.minimumValue = 0
        guard let url = URL(string: self.url) else { return }
        let item = AVPlayerItem(url: url)
        self.player = AVPlayer(playerItem: item)
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.frame = self.videoBackgroundView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.playerLayer = playerLayer
        self.videoBackgroundView.layer.addSublayer(playerLayer)
        self.player!.play()
        
        let interval = CMTimeMakeWithSeconds(1, preferredTimescale: Int32(NSEC_PER_SEC))
        self.player!.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { [weak self] elapsedSeconds in
            let elapsedTimeSecondsFloat = CMTimeGetSeconds(elapsedSeconds)
            let totalTimeSecondsFloat = CMTimeGetSeconds(self?.player!.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
            print(elapsedTimeSecondsFloat, totalTimeSecondsFloat)
            self?.elapsedTimeSecondsFloat = Double(elapsedTimeSecondsFloat)
            self?.totalTimeSecondsFloat = Double(Float((totalTimeSecondsFloat)))
        })
    }
    
    @objc private func changeValue() {
        self.elapsedTimeSecondsFloat = Float64(self.slider.value) * self.totalTimeSecondsFloat
        self.player!.seek(to: CMTimeMakeWithSeconds(self.elapsedTimeSecondsFloat, preferredTimescale: Int32(NSEC_PER_SEC)))
    }
}
