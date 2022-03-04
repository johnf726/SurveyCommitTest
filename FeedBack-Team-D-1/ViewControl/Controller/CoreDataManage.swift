//
//  CoreDataManage.swift
//  FeedBack-Team-D-1
//
//  Created by David Gonzalez on 3/1/22.
//

import Foundation
import UIKit
import CoreData

class CoreDataManage{  
    
    let context =  (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    static var inst = CoreDataManage()
    // MARK: - MANAGE USER DATA
    func addDataUser(emailP: String, passwordP: String, dateCreated: Date){
        let stu = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
        
        stu.email = emailP
        stu.password = passwordP
        stu.dateCreated = dateCreated
       
        do{
            try context?.save()
            print("Data saved in User Entity")
        }
        catch{
            print("Data not saved in User Entity")
        }
        
    }
    // Get Data
    func getDataUser () -> [User]{
        
        var stu = [User]()
        let fReq = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
   
        do{
            stu = try context?.fetch(fReq) as! [User]
        }catch{
            print("Can not fetch any data from User Entity")
        }
        return stu
    }
    
    func getOneDataUser(n : String) -> User {
        var st = User()
        var fReq = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fReq.predicate = NSPredicate(format: "email == %@", n)
        fReq.fetchLimit = 1
        
        do{
            let req = try context?.fetch(fReq ) as! [User]
            
            if(req.count != 0){
                st = req.first as! User
            }else{
                print("Data not found in User")
            }
        }catch{
            
        }
        return st
        
        
    }
    
    func updateDateUser(emailP:String, passwordP:String, dateCreateP: Date){
        
        var st = User()
        var fReq = NSFetchRequest<NSManagedObject>.init(entityName: "User")
        fReq.predicate = NSPredicate(format: "email == %@", passwordP)
        
        do{
            let stu = try context?.fetch(fReq)
            if(stu?.count != 0){
                st = stu?.first as! User
                
                st.password = passwordP
                
                try context?.save()

                print("Data updated in User")
            }
            
        }catch{
            
        }
    }
    
//    func removeDataUser(mail: String){
//
//        var  fReq = NSFetchRequest<NSManagedObject>.init(entityName: "User")
//        fReq.predicate = NSPredicate(format: "email == %@",n)
//
//        do{
//            let st = try context?.fetch(fReq)
//            context?.delete(st?.first as! User)
//            try context?.save()
//            print("Data Deleted in User")
//        }catch{
//
//        }
//    }
    // MARK: - MANAGE USER-SCORE DATA
    func addDataUserUserScore(emailP: String, scoreP: Int, dateCreated: Date){
        let stu = NSEntityDescription.insertNewObject(forEntityName: "UserScore", into: context!) as! UserScore
        
        stu.email = emailP
        stu.score = Int32(scoreP)
        stu.dateCreated = dateCreated
       
        do{
            try context?.save()
            print("Data saved in User Score Entity")
        }
        catch{
            print("Data not saved in User Score Entity")
        }
    }
    
    func getOneDataUserScore(n : String) -> UserScore {
        var st2 = UserScore()
        var fReq = NSFetchRequest<NSFetchRequestResult>(entityName: "UserScore")
        fReq.predicate = NSPredicate(format: "email == %@", n)
        fReq.fetchLimit = 1
        
        do{
            let req = try context?.fetch(fReq ) as! [UserScore]
            
            if(req.count != 0){
                st2 = req.first!
                print("Data not found in User Sccore")
            }
        }catch{
            
        }
        return st2
        
        
    }
    
    // Get Data
    func getDataUserScore () -> [UserScore]{
        
        var stu = [UserScore]()
        let fReq = NSFetchRequest<NSFetchRequestResult>(entityName: "UserScore")
   
        do{
            stu = try context?.fetch(fReq) as! [UserScore]
        }catch{
            print("Can not fetch any data from User Score Entity")
        }
        return stu
    }
}

