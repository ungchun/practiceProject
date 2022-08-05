import Foundation

struct UserElement: Codable {
    let createdAt: String
    let avatar: String
    let id: String
    
    @AccepitStringToInt
    var viewCount: Int
}

// 만약 서버 쪽에서 기존에
// viewCount : Int 자료로 보내줘야하는데
// viewCount : String 으로 보내주면 앱 쓰던 유저들은 앱이 다 죽는다.
// 그런걸 방지하기 위해 이렇게 @propertyWrapper로 다른 타입들도 받을 수 있게 하면 피치못한 에러를 방지할 수 있다.
//
@propertyWrapper
struct AccepitStringToInt : Codable {
    let wrappedValue : Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let stringValue = try? container.decode(String.self) {
            self.wrappedValue = Int(stringValue) ?? 0
        } else {
            self.wrappedValue = try container.decode(Int.self)
        }
    }
}
