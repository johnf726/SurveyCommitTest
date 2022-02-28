//
//  HomeViewController.swift
//  FeedBack-Team-D-1
//
//  Created by David Gonzalez on 2/25/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var goToServiceButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if text != nil {
            userEmail.text = text
        }
        
        
        print("Welcome my Friend::",userEmail_Home)
        userEmail.text = userEmail_Home;
        setupUI()
        ViewData()
        // Do any additional setup after loading the view.
    }
    
    var userEmail_Home = ""
    var text : String?
    
    // MARK: - FUNCTIONS
    private func setupUI() {
        goToServiceButton.layer.cornerRadius = 20
    }
   
    func ViewData() {
         // Set query
         let q : [String : Any] = [ kSecClass  as String : kSecClassGenericPassword,
                                    kSecAttrAccount as String : userEmail_Home ,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String : true]
         
         var res : CFTypeRef?
         
         if SecItemCopyMatching(q as CFDictionary, &res) == noErr{
             
             if let item = res as? [String: Any],
                let uid = item[kSecAttrAccount as String] as? String,
                let password = item [ kSecValueData  as String] as? Data,
                let pass = String(data: password, encoding: .utf8){
                 
                 print("1.-id is :", uid, " Passs is:", pass)
             }
             else{
                 print("no data Found")
             }
         }
         
         print("View Data")
     }
   

}
