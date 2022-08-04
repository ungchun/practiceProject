import Foundation

struct WeatherModel: Codable {
    var weather: [Weather]
    let main: Main
    let wind: Wind
    let name: String
    let visibility: Int // 시정
}

struct Main: Codable {
    let temp: Double // 현재 기온
    let feels_like: Double // 체감 기온
    let temp_min: Double // 최저 기온
    let temp_max: Double // 최고 기온
    let humidity: Int // 현재 습도
    let pressure: Int // 기압
}

struct Wind: Codable {
    let speed: Double // 풍속
}

struct Weather: Codable {
    let id: Int
    let main: String // 날씨
    let description: String // 날씨설명
    let icon: String // 아이콘
}
