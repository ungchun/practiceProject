import Foundation
import Alamofire

final class AlamofireManager {
    enum API {
        static let WEATHER_BASE_URL: String = "https://api.openweathermap.org/data/2.5/weather"
        static let WEATHER_CLIENT_ID: String = "key value"
        
        static let USERS_BASE_URL: String = "https://62eca362818ab252b6ff3bc3.mockapi.io/users"
    }
    
    // Weather API
    //
    func getAPIWeatherData(completion: @escaping(DataResponse<WeatherModel, AFError>) -> Void) {
        let url = API.WEATHER_BASE_URL
        
        // 키, 밸류 형식의 딕셔너리
        // BASE_URL 뒤에 ?appid=keyValue&q=Daegu&units=metric 이렇게 쿼리가 붙음
        //
        let queryParam = ["appid" : API.WEATHER_CLIENT_ID, "q" : "Daegu", "units" : "metric"]
        
        AF.request(url, method: .get, parameters: queryParam)
            .validate(statusCode: 200..<500) //200~500사이 상태만 허용
            .validate(contentType: ["application/json"]) //JSON 포맷만 허용
            .responseDecodable(of: WeatherModel.self) { response in
                switch response.result {
                case .success(let response):
                    print("getAPIData = \(response)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                completion(response)
            }
    }
    
    // @propertyWrapper 적용한 MockAPI
    //
    func getAPIUsersData(completion: @escaping(DataResponse<[UserElement], AFError>) -> Void) {
        
        let url = API.USERS_BASE_URL
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: [UserElement].self) { response in
                switch response.result {
                case .success(let response):
                    print("getAPIData = \(response)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                completion(response)
            }
    }
}
