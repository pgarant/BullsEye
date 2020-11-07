//
//  ViewController.swift
//  BullsEye
//
//  Created by Pierre Garant on 2020-11-06.
//

import UIKit
import GameKit

class ViewController: UIViewController {

    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var statusLabel: UILabel!
    
    var targetValue:Int = 50
    var currentValue:Int = 50
    var score:Int = 0
    var round:Int = 0
    var points:Int = 0
    var status:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Setuo Slider
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
 
        let thumbImageHighlited = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlited, for: .highlighted)
        
        let myInsets = UIEdgeInsets(top: 5, left:15, bottom: 5, right: 15)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: myInsets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SmallButton")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: myInsets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        // Initialize values
        slider.value = Float(currentValue)
        startNewRound()
        refreshDisplay()

/*
        // Setup GameCenter
        let viewController = GK
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if let viewController = viewController {
                // Present the view controller so the player can sign in
                return
            }
            if error != nil {
                // Player could not be authenticated
                // Disable Game Center in the game
                return
            }
            
            // Player was successfully authenticated
            // Check if there are any player restrictions before starting the game
                    
            if GKLocalPlayer.local.isUnderage {
                // Hide explicit game content
            }

            if GKLocalPlayer.local.isMultiplayerGamingRestricted {
                // Disable multiplayer game features
            }

            if GKLocalPlayer.local.isPersonalizedCommunicationRestricted {
                // Disable in game communication UI
            }
            
            // Perform any other configurations as needed (for example, access point)
        
            // Place the access point on the upper-left corner
            GKAccessPoint.shared.location = .topLeading
        }
 */
    }
    
    func startNewRound(){
        round += 1
        targetValue = Int.random(in:1...100)
        refreshDisplay()
}
    
    func refreshDisplay(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
        // statusLabel.text = String(GKLocalPlayer.local.isAuthenticated)
    }
    
    @IBAction func hitMe(){
        
        points = 100-abs(currentValue-targetValue)
        if points == 100 {
            points += 100
        } else if points == 99 {
            points += 50
        }
        score += points
        
        showAlert()
        startNewRound()
    }
    
    @IBAction func startAgain(){
        score = 0
        points = 0
        round = 0
        startNewRound()
    }
    
    func showAlert(){
        let message:String = "Vous avez sélectionné \(currentValue). \n La cible était \(targetValue). \n Vous avez marqué \(points) points."
        
        let alert = UIAlertController(title: "Score", message: message , preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func slideMove(){
        currentValue = Int(slider.value.rounded())
    }
    

}

