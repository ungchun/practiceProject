import UIKit
import SnapKit
import SendbirdUIKit

class ChannelListVC: SBUGroupChannelListViewController {
    override init() {
        super.init()
        self.headerComponent!.rightBarButton?.isEnabled = true
        self.headerComponent!.titleView = self.createCustomTitleLabel()
    }
    func createCustomTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = "Your Chat List"
        return titleLabel
    }
    @objc @MainActor required init(channelListQuery: GroupChannelListQuery? = nil) {
        fatalError("init(channelListQuery:) has not been implemented")
    }
}

class createUserVC: SBUCreateChannelViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override init() {
        super.init()
    }
    
    @MainActor required init(users: [SBUUser]? = nil, type: ChannelCreationType = .group) {
        fatalError("init(users:type:) has not been implemented")
    }
    
    override func createViewModel(users: [SBUUser]? = nil, type: ChannelCreationType = .group) {
        print("createViewModel createViewModel")
    }
    
}

class ChatViewController: UIViewController {
    
    // MARK: Properties
    //
    weak var coordinator: ChatCoordinator?
    
    // MARK: Views
    //
    private let centerLabel: UILabel = {
        let label = UILabel()
        label.text = "ChatViewController"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    @objc func testClick(sender: UITapGestureRecognizer) {
        // ChannelListVC 로 이동
        //
        //        let channelListVC = ChannelListVC()
        //        let naviVC = UINavigationController(rootViewController: channelListVC)
        //        naviVC.modalPresentationStyle = .fullScreen
        //        present(naviVC, animated: true)
        
        // 리스트가 아닌 채널 기준으로 이동
        //
        //        let testUrl = "channel url"
        //        let channelVC = SBUGroupChannelViewController(channelURL: testUrl)
        //        let naviVC = UINavigationController(rootViewController: channelVC)
        //        present(naviVC, animated: true)
        
        let userA = "leedool8008"
        //        let userB = "leedool3003"
        
        // 만약 채팅 그룹을 만드려고 하면 connect 확인한 다음에 해야함
        // 1:1 채팅은 그룹 채널을 대상에 상대방 한명만 넣으면 1:1로 만들어짐
        //
        SendbirdUI.connect { user, error in
            guard let user = user, error == nil else {
                return // Handle error.
            }
            print("current user \(user)")
            
            let params = GroupChannelCreateParams()
            params.name = "CHANNEL_NAME"
            params.userIds = [userA]
            params.isDistinct = true
            //        params.coverImage = FILE            // Or .coverURL
            //            params.customType = "CUSTOM_TYPE"
            
            GroupChannel.createChannel(params: params) { channel, error in
                guard error == nil else {
                    print("error \(error!)")
                    return
                }
                print("channel \(channel!)")
            }
        }
    }
    
    // MARK: Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(centerLabel)
        view.backgroundColor = .white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(testClick))
        centerLabel.addGestureRecognizer(tap)
        centerLabel.snp.makeConstraints { make in
            make.center.equalTo(view.center)
        }
    }
}
