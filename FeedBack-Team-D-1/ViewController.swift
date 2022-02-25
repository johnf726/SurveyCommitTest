//
//  ViewController.swift
//  FeedBack-Team-D-1
//
//  Created by David Gonzalez on 2/25/22.
//
import UIKit
 //NotificationBannerSwift
// simple comment
class ViewController: UIViewController {
     
    // MARK: - Outlets
    @IBOutlet weak var userEmailText: UITextField!
    
    @IBOutlet weak var userPasswordText: UITextField!
    
    // MARK: - IBActions
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func submitButton2(_ sender: Any) {
        performLogin()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        submitButton.layer.cornerRadius = 20
    }

    private func performLogin() {
        guard let email = userEmailText.text, !email.isEmpty else {
            print("Email empty")
//            NotificationBanner(title: "Error", subtitle: "Debes especificar un correo.", style: .warning).show()

            return
        }
    }

}

