import UIKit
import CoreData

class CoreDataViewController: UIViewController {
    
    // MARK: Properties
    //
    weak var coordinator: AVPlayerCoordinator?
    
    // MARK: Views
    //
    private let centerLabel: UILabel = {
        let label = UILabel()
        label.text = "CoreData"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    // MARK: Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.self.addSubview(centerLabel)
        
        centerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        centerLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        centerLabel.addGestureRecognizer(tap)
        
    }
    
    // MARK: Functions
    //
    @objc func tapAction() {
        print("tapAction")
        
        // CoreData 값 저장
        //        if saveCoreData(name: "엉춘", email: "leedool3003@naver.com") {
        //            print("성공")
        //        } else {
        //            print("실패")
        //        }
        
        // CoreData 특정 값 삭제
        //        if deleteCoreData() {
        //            print("성공")
        //        } else {
        //            print("실패")
        //        }
        
        // CoreData 특정 값 업데이트
        //        if updateCoreData(name: "성훈") {
        //            print("성공")
        //        } else {
        //            print("실패")
        //        }
        
        readCoreData()
    }
    
    func saveCoreData(name: String, email: String) -> Bool {
        // App Delegate 호출
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        
        // App Delegate 내부에 있는 viewContext 호출
        let context = appDelegate.persistentContainer.viewContext
        
        // context 내부에 있는 entity 호출
        let entity = NSEntityDescription.entity(forEntityName: "CoreDataUsers", in: context)!
        
        // entity 객체 생성
        let object = NSManagedObject(entity: entity, insertInto: context)
        
        // 값 설정
        object.setValue(name, forKey: "name")
        object.setValue(email, forKey: "email")
        object.setValue(UUID(), forKey: "id")
        
        do {
            // context 내부의 변경사항 저장
            try context.save()
            return true
        } catch let error as NSError {
            // 에러 발생시
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func updateCoreData(name: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "CoreDataUsers")
        
        // 이렇게 특정 값을 지정해서 업데이트 가능
        // id나 특정 값을 받아와서 세팅하면 됨
        //
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let result = try context.fetch(fetchRequest)
            let object = result[0] as! NSManagedObject
            
            object.setValue("히히", forKey: "name")
            object.setValue("이메일입니다", forKey: "email")
            
            try context.save()
            return true
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func deleteCoreData() -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "CoreDataUsers")
        
        // 이렇게 특정 값을 지정해서 삭제 가능
        // id나 특정 값을 받아와서 세팅하면 됨
        //
        fetchRequest.predicate = NSPredicate(format: "name = %@", "엉춘")
        
        do {
            let result = try context.fetch(fetchRequest)
            let objectToDelete = result[0] as! NSManagedObject
            context.delete(objectToDelete)
            try context.save()
            return true
            
        } catch {
            return false
        }
    }
    
    // CoreDataUsers 라는 CoreData read
    // 따로 model을 만들어서 그 형태로 받을 수 없다.
    //
    func readCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        do {
            let contact = try context.fetch(CoreDataUsers.fetchRequest()) as! [CoreDataUsers]
            contact.forEach {
                print($0.value(forKey: "name") as Any)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
