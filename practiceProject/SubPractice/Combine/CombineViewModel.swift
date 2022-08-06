import Foundation
import Combine

class CombineViewModel: ObservableObject {
    
    @Published var combineValue: String = "sunghun"
    
    func updateValue() {
        self.combineValue = "ungchun"
    }
}
