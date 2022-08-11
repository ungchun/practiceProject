import UIKit
import AVFoundation
import SnapKit

class MediaViewController: UIViewController {
    
    // MARK: Properties
    //
    weak var coordinator: AVPlayerCoordinator?
    
    var player: AVPlayer = {
        guard let url = URL(string: "https://ccrma.stanford.edu/~jos/mp3/harpsi-cs.mp3") else { fatalError() }
        let player = AVPlayer()
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem) // AVPlayer는 한번에 하나씩만 다룰 수 있음
        return player
    }()
    var buttonTitle: String? {
        didSet { self.toggleButton.setTitle(self.buttonTitle, for: .normal) }
    }
    var elapsedTimeSecondsFloat: Float64 = 0 {
        didSet {
            guard self.elapsedTimeSecondsFloat != oldValue else { return }
            let elapsedSecondsInt = Int(self.elapsedTimeSecondsFloat)
            let elapsedTimeText = String(format: "%02d:%02d", elapsedSecondsInt.miniuteDigitInt, elapsedSecondsInt.secondsDigitInt)
            self.elapsedTimeLabel.text = elapsedTimeText
            self.progressValue = self.elapsedTimeSecondsFloat / self.totalTimeSecondsFloat
        }
    }
    var totalTimeSecondsFloat: Float64 = 0 {
        didSet {
            guard self.totalTimeSecondsFloat != oldValue else { return }
            let totalSecondsInt = Int(self.totalTimeSecondsFloat)
            let totalTimeText = String(format: "%02d:%02d", totalSecondsInt.miniuteDigitInt, totalSecondsInt.secondsDigitInt)
            self.totalTimeLabel.text = totalTimeText
        }
    }
    var progressValue: Float64? {
        didSet { self.playSlider.value = Float(self.elapsedTimeSecondsFloat / self.totalTimeSecondsFloat) }
    }
    
    // MARK: Views
    //
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        self.view.addSubview(stackView)
        return stackView
    }()
    private lazy var timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        self.view.addSubview(stackView)
        return stackView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "오디오 재생 테스트"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var elapsedTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var totalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var playSlider: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(didChangeSlide), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    private lazy var toggleButton: UIButton = {
        let button = UIButton()
        button.setTitle("재생", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        timeStackView.addArrangedSubview(elapsedTimeLabel)
        timeStackView.addArrangedSubview(totalTimeLabel)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(playSlider)
        stackView.addArrangedSubview(timeStackView)
        stackView.addArrangedSubview(toggleButton)
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.center.equalTo(view.center)
        }
        self.addPeriodicTimeObserver()
    }
    
    // MARK: functions
    //
    private func addPeriodicTimeObserver() {
        let interval = CMTimeMakeWithSeconds(1, preferredTimescale: Int32(NSEC_PER_SEC))
        self.player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] elapsedTime in
            let elapsedTimeSecondsFloat = CMTimeGetSeconds(elapsedTime)
            let totalTimeSecondsFloat = CMTimeGetSeconds(self?.player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
            guard
                !elapsedTimeSecondsFloat.isNaN,
                !elapsedTimeSecondsFloat.isInfinite,
                !totalTimeSecondsFloat.isNaN,
                !totalTimeSecondsFloat.isInfinite
            else { return }
            self?.elapsedTimeSecondsFloat = elapsedTimeSecondsFloat
            self?.totalTimeSecondsFloat = totalTimeSecondsFloat
        }
    }
    
    @objc private func didTapButton() {
        switch self.player.timeControlStatus {
        case .paused:
            self.player.play()
            self.buttonTitle = "일시정지"
        case .playing:
            self.player.pause()
            self.buttonTitle = "재생"
        default:
            break
        }
    }
    @objc private func didChangeSlide() {
        self.elapsedTimeSecondsFloat = Float64(self.playSlider.value) * self.totalTimeSecondsFloat
        self.player.seek(to: CMTimeMakeWithSeconds(self.elapsedTimeSecondsFloat, preferredTimescale: Int32(NSEC_PER_SEC)))
    }
}

// MARK: Extension
//
extension Int {
    var secondsDigitInt: Int {
        self % 60
    }
    var miniuteDigitInt: Int {
        self / 60
    }
}
