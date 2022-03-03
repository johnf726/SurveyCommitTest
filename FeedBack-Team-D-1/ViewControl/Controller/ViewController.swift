//
//  ViewController.swift
//  FeedBack-Team-D-1
//
//  Created by Team-D 2/25/22.


// testing merging branches
//
import UIKit

extension String {
    private static let __firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
    private static let __serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
    private static let __emailRegex = __firstpart + "@" + __serverpart + "[A-Za-z]{2,6}"
    
    public var isEmail: Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", type(of:self).__emailRegex)
        return predicate.evaluate(with: self)
    }
}

// MARK: HideShowPasswordTextFieldDelegate
var iconClick = false
let imageIcon = UIImageView()

class ViewController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var userEmailText: UITextField!
    
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var userPasswordText: UITextField!
    
    // MARK: - IBActions
    @IBOutlet weak var submitButton: UIButton!
    // MARK: - STUP SUBMIT BUTTON
    @IBAction func submitButton2(_ sender: Any) {
        performLogin()
        addDataUser()
        getOneDataUser()
        
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Inicio Register")
        setupUI()
        ShowPassword()
       
    }
    
    func ShowPassword() {
        // ***************************** Passs *******************************
        imageIcon.image = UIImage(named: "closeeye")
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "closeeye")!.size.width, height: UIImage(named: "closeeye")!.size.height)
        
        imageIcon.frame = CGRect(x: -10, y: 0, width: UIImage(named: "closeeye")!.size.width, height: UIImage(named: "closeeye")!.size.height)
        
        userPasswordText.rightView = contentView
        userPasswordText.rightViewMode = .always
        //
        //        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(TapGestureRecognizer)))
        //
        imageIcon.isUserInteractionEnabled = true
        //        imageIcon.addGestureRecognizer(tapGestureReconizer)
        //
        //        func imageTapped(TapGestureRecognizer:UITapGestureRecognizer){
        //            let tappedImage = tapGestureReconizer.view as! UIImageView
        //
        //            if iconClick{
        //                iconClick=false
        //                tappedImage.image = UIImage(named: "openeye")
        //                userPasswordText.isSecureTextEntry = false
        //            }else {
        //                iconClick=true
        //                tappedImage.image = UIImage(named: "closeeye")
        //                userPasswordText.isSecureTextEntry = true
        //            }
        //        }
    }
    
    // MARK: - FUNCTIONS
    
    private func setupUI() {
        submitButton.layer.cornerRadius = 20
    }
    // MARK: - Email , pass
    private func performLogin() {
        if userEmailText.text!.isEmail {
            print("\(String(describing: userEmailText.text!)) is a valid e-mail address")
        //    userEmailText.backgroundColor = .white
            SaveData()
            ViewData()
            error.backgroundColor = .gray
            error.text = "welcomePage"
        } else {
            print("\(userEmailText.text!) is not a valid e-mail address")
           // userEmailText.backgroundColor = .red
            error.backgroundColor = .red
            error.text = "is not a valid e-mail address"
            
            userEmailText.tintColor = .white
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if userEmailText.text!.isEmail {
            return true
        }else{
            return false
        }
    }
    
    
    func  isValidEmail( userEmailText : String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
//    func sendEmail() {
//        if MFMailComposeViewController.canSendMail() {
//            let mail = MFMailComposeViewController()
//            mail.mailComposeDelegate = self
//            mail.setToRecipients(["davisgon@gmail.com"])
//            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
//
//            present(mail, animated: true)
//        } else {
//            // show failure alert
//        }
//    }
//
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        controller.dismiss(animated: true)
//    }
    
    // MARK: - CORE DATA
    func addDataUser(){
        let date = Date()
        CoreDataManage.inst.addDataUser(emailP: userEmailText.text!, passwordP: userPasswordText.text!, dateCreated: date  )
        print("Data Saved into USER Entity")
    }
    
    func getOneDataUser() {
        var d =  CoreDataManage.inst.getOneDataUser(n: userEmailText.text!)
      
        print("GetOneDataUser from USER ", d.email," Pass ", d.password, "Date Created ", d.dateCreated)
        
    }
    
    
    
    // MARK: - KeyChain
    // KeyChain
    func SaveData() {
        // **********   set Attributres
        let att : [String : Any] =
        [ kSecClass as String : kSecClassGenericPassword,
          kSecAttrAccount as String : userEmailText.text,
          kSecValueData as String : userPasswordText.text!.data(using: .utf8)!]
        
        // **********   add Data
        if SecItemAdd(att as CFDictionary,nil ) == noErr{
            print("Data Saved successfully KeyChain")
        }else{
            print("Data not saved KeyChain")
        }
        // ViewData()
    }
    
    func ViewData() {
        // Set query
        let q : [String : Any] = [ kSecClass  as String : kSecClassGenericPassword,
                                   kSecAttrAccount as String : userEmailText.text,
                                   kSecReturnAttributes as String: true,
                                   kSecReturnData as String : true]
        
        var res : CFTypeRef?
        
        if SecItemCopyMatching(q as CFDictionary, &res) == noErr{
            
            if let item = res as? [String: Any],
               let uid = item[kSecAttrAccount as String] as? String,
               let password = item [ kSecValueData  as String] as? Data,
               let pass = String(data: password, encoding: .utf8){
                print("******:Id is :", userEmailText.text!, " Passs is:" )
            }
            else{
                print("no data Found")
            }
        }
        print("View Data")
    }
    
    // MARK: - Prepare Send Data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let svc = segue.destination as!  HomeViewController
        print("******:Id is :", userEmailText.text!, " Passs is:" )
        
        svc.userEmail_Home = userEmailText.text!
    }
    
}

