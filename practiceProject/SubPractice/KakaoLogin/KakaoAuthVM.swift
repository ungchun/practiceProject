import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser

class KakaoAuthVM: ObservableObject {
    
    var subscriptions = Set<AnyCancellable>()
    
    @Published var isLoggedIn : Bool = false
    
    lazy var loginStatusInfo : AnyPublisher<String?, Never> = $isLoggedIn.compactMap{
        $0 ? "로그인 상태" : "로그아웃 상태"
    }.eraseToAnyPublisher()
    
    init() {
        print("KakaoAuthVM - init called")
    }
    
    // Swift 5.5 부터 async/await 키워드가 도입
    // @MainActor, async/await, withCheckedContinuation -> 모두 다 같이 관련돼있음
    // 더 자세한 내용은 노션에서 확인
    //
    @MainActor
    func kakaoLogin() {
        print("KakaoAuthVM - handleKakaoLogin() called")
        Task {
            // 카카오톡 설치 여부 확인
            //
            if (UserApi.isKakaoTalkLoginAvailable()) {
                // 카카오톡 앱으로 로그인 인증
                //
                isLoggedIn = await kakaoLoginWithApp()
            } else { // 카톡이 설치가 안되어 있으면
                // 카카오 계정으로 로그인 인증
                //
                isLoggedIn = await kakaoLoginWithAccount()
            }
        }
    }
    
    @MainActor
    func kakaoLogout() {
        print("KakaoAuthVM - handleKakaoLogout() called")
        Task {
            if await handleKakaoLogout() {
                self.isLoggedIn = false
            }
        }
    }
    
    // 카카오 앱으로 인증
    //
    func kakaoLoginWithApp() async -> Bool {
        await withCheckedContinuation{ continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    //do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    // 카카오 계정으로 로그인
    //
    func kakaoLoginWithAccount() async -> Bool {
        await withCheckedContinuation{ continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    //do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    // 카카오 로그아웃
    //
    func handleKakaoLogout() async -> Bool {
        await withCheckedContinuation{ continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
        }
    }
}
