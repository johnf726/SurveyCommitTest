//
//  TnksViewController.swift
//  FeedBack-Team-D-1
//
//  Created by David Gonzalez on 2/28/22.
//

import UIKit
import AVFoundation

class TnksViewController: UIViewController {
    // MARK: - AVAudioPlayer
    var audioPlayer: AVAudioPlayer!
 //   var audioPlayer : AVAudioPlayer!
    var soundNameSad = "sad"
    var soundNameHappy = "happy"
    var emailG = "davisgon@gmail.com"
    
    func PlayAudio( sound: String){
        let soundURL = Bundle.main.url(forResource: sound, withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
            audioPlayer.play()
        }
        catch {
            print("Error locating sound file: \(error)")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // MARK: - IBOutlet
    @IBOutlet weak var sadImage: UIImageView!
    @IBOutlet weak var happyImage: UIImageView!
    
    
    
    
    // Buttons
    @IBOutlet weak var S1NoSelectedButton: UIButton!
    @IBOutlet weak var S1SelectedButton: UIButton!
    // s5
    @IBOutlet weak var S5NoSelected: UIButton!
    
    @IBOutlet weak var S5Selected: UIButton!
    
      
    // MARK: - IBOAction
    @IBAction func S5_Happy(_ sender: Any) {
        sadImage.isHidden = true
        happyImage.isHidden = false
        S5NoSelected.isHidden = true
        S5Selected.isHidden = false
        S1NoSelectedButton.isHidden = false
        S1SelectedButton.isHidden = true
        print("aca")
        //PlayAudio( sound: soundNameHappy)
        addDataUserScore(p : 100)
        getDataUserScore()
     //   getOneDataUser()
        getOneDataUserScore( p : emailG)
    }
    
    @IBAction func S5Selected(_ sender: Any) {
        sadImage.isHidden = false
        happyImage.isHidden = false
        S5NoSelected.isHidden = false
        S5Selected.isHidden = true
      
        
    }

    @IBAction func S1_Button(_ sender: Any) {
        print("No Selected button 1")
        sadImage.isHidden = false
        happyImage.isHidden = true
        S1NoSelectedButton.isHidden = true
        S1SelectedButton.isHidden = false
      //  PlayAudio( sound: soundNameSad)
        S5NoSelected.isHidden = false
        S5Selected.isHidden = true
        addDataUserScore(p : 60)
        getDataUserScore()
        getOneDataUserScore( p : emailG)
       
        
    }
    @IBAction func S1Selected(_ sender: Any) {
        print("Selected button 1")
        sadImage.isHidden = false
        happyImage.isHidden = false
        S1NoSelectedButton.isHidden = false
        S1SelectedButton.isHidden = true
    }
    
    
    @IBAction func recuperaData(_ sender: Any) {
        
       // getOneDataUser()
       // addDataUserScore()
        //getOneDataUserScore()
        getDataUserScore()
    }
    
    func getOneDataUser() {
        let pMail = "userEmailText.text!"
        let d =  CoreDataManage.inst.getOneDataUser(n: "davisgon@gmail.com")
      
        print("GetOneDataUser from USER ", d.email," Pass ", d.password, "Date Created ", d.dateCreated)
        
    }
    
    // MARK: - CORE DATA USER-SCORE
    func addDataUserScore(p : Int32){
        let date = Date()
        CoreDataManage.inst.addDataUserUserScore(emailP: "davisgon@gmail.com", scoreP: Int(p), dateCreated: date  )
        print("Data Saved into USER-SCORE Entity")
    }
    
    func getOneDataUserScore(p : String) {
        let ds =  CoreDataManage.inst.getOneDataUserScore(n: p)
      
        print("GetOneDataUser from USER-STORE ",
              ds.email,
              " SCORE ",
              ds.score, "Date Created ", ds.dateCreated)
        
    }
    
    func getDataUserScore() {
        var data = CoreDataManage.inst.getDataUserScore() //.getData()
        var good = 0
        var bad  = 0
        var  numRatingTotal  = CoreDataManage.inst.getDataUserScore().count
        for d in data{
            if d.score == 100{
                var numRating = CoreDataManage.inst.getDataUserScore().count
                good += 1
            }else{
                var numRating = CoreDataManage.inst.getDataUserScore().count
                bad += 1
            }
            print("Email is ",d.email,"Score ", d.score, "DateCreated USER SCORE ",d.dateCreated)
        }
        print(numRatingTotal, "Total Bad:",bad," Total Good: ",good)
        
        
    }

}
