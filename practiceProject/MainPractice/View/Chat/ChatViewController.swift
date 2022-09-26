import UIKit
import SnapKit
import SendbirdUIKit


// 이렇게 화면 하나하나 마다 색깔 커스텀이 가능함
//
func channelListTheme() -> SBUChannelListTheme {
    let myChannelListTheme = SBUChannelListTheme()
    myChannelListTheme.navigationBarTintColor = .green
    myChannelListTheme.leftBarButtonTintColor = .red
    return myChannelListTheme
}
func channelTheme() -> SBUChannelTheme {
    let mychannelTheme = SBUChannelTheme()
    mychannelTheme.navigationBarTintColor = .blue
    mychannelTheme.leftBarButtonTintColor = .white
    return mychannelTheme
}

//func messageCellTheme() -> SBUMessageCellTheme {
//    let myMessageCellTheme = SBUMessageCellTheme()
//    return myMessageCellTheme
//}
//
//func messageInputTheme() -> SBUMessageInputTheme {
//    let myMessageInputTheme = SBUMessageInputTheme()
//    return myMessageInputTheme
//}

let newTheme = SBUTheme(
    channelListTheme: channelListTheme(),
    channelTheme: channelTheme()
)

// 채팅 리스트 화면
//
class ChannelListVC: SBUGroupChannelListViewController {
    
    func createCustomTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = "채팅방"
        return titleLabel
    }
    
    override func viewDidLoad() {
        
        // custom color theme set
        //
        SBUTheme.set(theme: newTheme)
        
        // 채팅 리스트 뷰에서 채팅 그룹 추가하는 버튼 삭제
        //
        self.headerComponent!.rightBarButton = nil
        
        // 채팅 리스트 타이틀 이름 변경
        //
        self.headerComponent!.titleView = self.createCustomTitleLabel()
        
        self.headerComponent?.leftBarButton?.tintColor = .green
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func channelListModule(_ listComponent: SBUGroupChannelListModule.List, didSelectRowAt indexPath: IndexPath) {
        let channel = self.channelList[indexPath.row].channelURL
        let channelVC = MessageList(channelUrl: channel)
        let naviVC = UINavigationController(rootViewController: channelVC)
        naviVC.modalPresentationStyle = .fullScreen
        self.present(naviVC, animated: true)
    }
}

// 채팅 리스트에서 채팅 클릭하면 나오는 화면 ( 직접 채팅을 치는 화면 )
//
class MessageList: SBUGroupChannelViewController {
    init(channelUrl: String){
        super.init(channelURL: channelUrl)
        
        // 채팅방 이름
        //
        let myView = UILabel()
        myView.text = "userA"
        self.headerComponent!.titleView = myView
        
        // SBUStringSet 이거 가지고 기본 세팅돼있는 text들 다 바꿀 수 있음. 하나하나씩 다 바꿔야함
        //
        SBUStringSet.Camera = "카메라"
        SBUStringSet.PhotoVideoLibrary = "갤러리"
        SBUStringSet.Document = "파일"
        SBUStringSet.Cancel = "취소"
    }
    @objc @MainActor required init(channel: GroupChannel, messageListParams: MessageListParams? = nil) {
        fatalError("init(channel:messageListParams:) has not been implemented")
    }
    
    @MainActor required init(channelURL: String, startingPoint: Int64? = nil, messageListParams: MessageListParams? = nil) {
        fatalError("init(channelURL:startingPoint:messageListParams:) has not been implemented")
    }
    
    // 오른쪽 버튼 제거
    //
    override func viewDidLoad() {
        self.headerComponent?.rightBarButton = nil
        self.listComponent!.backgroundColor = .green
        self.inputComponent!.backgroundColor = .red
    }
}

// 유저 생성
//
class createUserVC: SBUCreateChannelViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
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
        label.text = "userA와 대화하기"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    @objc func testClick(sender: UITapGestureRecognizer) {
        
        // ChannelListVC 로 이동
        //
        let channelListVC = ChannelListVC()
        let naviVC = UINavigationController(rootViewController: channelListVC)
        naviVC.modalPresentationStyle = .fullScreen
        present(naviVC, animated: true)
        
        // 리스트가 아닌 채널url을 이용해서 채팅방으로 바로 이동
        //
        //        let testUrl = "channel url"
        //        let channelVC = SBUGroupChannelViewController(channelURL: testUrl)
        //        let naviVC = UINavigationController(rootViewController: channelVC)
        //        present(naviVC, animated: true)
        
        // 만약 채팅 그룹을 만드려고 하면 connect 확인한 다음에 해야함
        // 1:1 채팅은 그룹 채널을 대상에 상대방 한명만 넣으면 1:1로 만들어짐
        // 이거 돌리면 1:1 채팅 만들면서 (만약 있다면 그 만들지않고 그 채팅방을 찾음) 채팅방으로 이동
        //
        //        let userA = "testUser2" // 상대방 유저 아이디
        //        SendbirdUI.connect { [weak self] user, error in
        //            guard let self = self else { return }
        //            guard let user = user, error == nil else {
        //                return // Handle error.
        //            }
        //            print("current user \(user)")
        //
        //            let params = GroupChannelCreateParams()
        //            params.name = "userA" // -> 채팅방 이름이니까 1:1 이면 유저 닉네임 사용
        //            params.userIds = [userA]
        //            params.isDistinct = true // true : userID 기준으로 이미 채팅을 만들었던 사용자면 새로 채팅방 생성하지않고 전에 사용했던 채팅방 사용, false : 방 계속 생성
        //            //        params.coverImage = FILE            // Or .coverURL
        //            //            params.customType = "CUSTOM_TYPE"
        //
        //            GroupChannel.createChannel(params: params) { channel, error in
        //                guard error == nil else {
        //                    print("error \(error!)")
        //                    return
        //                }
        //                print("channel \(channel!)")
        //
        //                // 채팅방으로 이동
        //                //
        //                let channel = channel?.channelURL
        //                let channelVC = MessageList(channelUrl: channel!)
        //                let naviVC = UINavigationController(rootViewController: channelVC)
        //                naviVC.modalPresentationStyle = .fullScreen
        //                self.present(naviVC, animated: true)
        //            }
        //        }
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
