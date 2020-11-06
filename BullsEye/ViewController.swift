//
//  ViewController.swift
//  BullsEye
//
//  Created by Pierre Garant on 2020-11-06.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var targetValue:Int = 50
    var currentValue:Int = 0
    var score:Int = 0
    var round:Int = 0
    var points:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        slider.value = 50
        startNewRound()
        refreshDisplay()
    }
    
    func startNewRound(){
        targetValue = Int.random(in:1...100)
        refreshDisplay()
}
    
    func refreshDisplay(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
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

