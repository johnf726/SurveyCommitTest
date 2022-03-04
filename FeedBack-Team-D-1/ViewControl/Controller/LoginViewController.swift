//
//  LoginViewController.swift
//  FeedBack-Team-D-1
//
//  Created by John Figueroa on 3/2/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //to do : add exception handling for no identifier info input
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let ident = pass.text{
            if ident != ""{
                print(ident)
                return true
            }
        }
        print("no identity given")
        return false
    }

    // to do : integrate coredata for this viewcontroller
    @IBAction func signup(_ sender: Any) {
        //prepare/set attribute
        let att : [String : Any] = [kSecClass as String: kSecClassGenericPassword, kSecAttrAccount as String : id.text, kSecValueData as String : pass.text!.data(using: .utf8)!]
        
        //add data
        if(SecItemAdd(att as CFDictionary, nil) == noErr){
            print("data saved")
        } else{
            print("not saved")
        }
    }
    
    
    @IBAction func goToFacebook(_ sender: Any) {
        UIApplication.shared.open(URL(string : "http://facebook.com")! as URL, options: [:] , completionHandler: nil)
    }
    
   
    @IBAction func goToTwitter(_ sender: Any) {
        UIApplication.shared.open(URL(string : "http://twitter.com")! as URL, options: [:] , completionHandler: nil)
    }
    
    
    @IBAction func login(_ sender: Any) {
        //set query
        let q : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : id.text, kSecReturnAttributes as String : true, kSecReturnData as String : true]
        
        var res :CFTypeRef?
        
        //check data
        if SecItemCopyMatching(q as CFDictionary, &res) == noErr{
            if let item = res as? [String : Any],
               let uid = item[ kSecAttrAccount as String] as? String,
               let password = item [ kSecValueData as String] as? Data,
               let pass = String(data : password, encoding : .utf8)
            {
                print("id is ", uid," password is ", pass)
            } else{
                print("no data found")
            }
        }
    }
}
