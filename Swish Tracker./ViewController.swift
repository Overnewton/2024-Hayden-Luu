//
//  ViewController.swift
//  Swish Tracker.
//
//  Created by Hayden Luu on 24/6/2024.
//

import Cocoa

class ViewController: NSViewController {
    
    //set button opacity for later in viewDidLoad
    func setOpacity(of button: NSButton, to opacity: Double) {
        button.alphaValue = CGFloat(opacity)
    }
    
    //outlets
    @IBOutlet weak var btnAddStats: NSButton!
    @IBOutlet weak var btnEvaluate: NSButton!
    
    //perform segue to add stats screen and close current window
    @IBAction func btnAddStats(_ sender: Any) {
        self.view.window!.close() //close window for segue to be performed
        performSegue(withIdentifier: "addStats", sender: self) //open add stats screen
    }
    
    //perform segue to eveluate screen and close current window
    @IBAction func btnEvaluate(_ sender: Any) {
        self.view.window!.close() //close window for segue to be performed
        performSegue(withIdentifier: "evaluate", sender: self) //open evaluation screen
    }
    
    //load json data of gamesList array using base64 decryption
    func loadFileGamesList() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        print(directoryURL)
        do {
            let jsonURL = URL(fileURLWithPath: "gamesList.json", relativeTo: directoryURL) //set json file name
            let base64String = try String(contentsOf: jsonURL, encoding: .utf8) //declare variable for data that will be decoded in base64
            if let jsonData = Data(base64Encoded: base64String) { //setting jsonData to be decoded via base64 decryption method
                let decoder = JSONDecoder()
                gamesList = try decoder.decode([GameStats].self, from: jsonData)
                print("JSON file was successfully imported")
                
                // Update gameNumber with the latest gameNumber from the gamesList
                if let lastGame = gamesList.last {
                    gameNumber = lastGame.gameNumber
                }
            } else {
                print("Failed to decode Base64 string")
            }
        } catch {
            print("File could not be imported")
        }
    }
    
    //load json data of gamesListForEvaluation array using base64 decryption
    func loadFileGamesListForEvaluation() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        do {
            let jsonURL = URL(fileURLWithPath: "gamesListForEvaluation.json", relativeTo: directoryURL) //set json file name
            let base64String = try String(contentsOf: jsonURL, encoding: .utf8) //declare variable for data that will be decoded in base64
            if let jsonData = Data(base64Encoded: base64String) { //setting jsonData to be decoded via base64 decryption method
                let decoder = JSONDecoder()
                gamesListForEvaluation = try decoder.decode([GameStatsForEvaluation].self, from: jsonData)
                print("JSON file was successfully imported")
                
                // Update gameNumber with the latest gameNumber from the gamesList
                if let lastGame = gamesList.last {
                    gameNumber = lastGame.gameNumber
                }
            } else {
                print("Failed to decode Base64 string")
            }
        } catch {
            print("File could not be imported")
        }
    }
    
    //when view loads set opacity of both buttons to 0.7
    override func viewDidLoad() {
        super.viewDidLoad()
        setOpacity(of: btnAddStats, to: 0.7)
        setOpacity(of: btnEvaluate, to: 0.7)
        //when viewController is loaded, the json data is imported in.
        loadFileGamesList()
        loadFileGamesListForEvaluation()
    }
    
    
    
}

