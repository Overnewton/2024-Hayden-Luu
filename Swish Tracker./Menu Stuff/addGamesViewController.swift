//
//  addGamesViewController.swift
//  Swish Tracker.
//
//  Created by Hayden Luu on 25/6/2024.
//

import Cocoa

class addGamesViewController: NSViewController {
    
    //variable to declare game number id for each game appended into array
    var gameNumbers: Int = 0
    
    //button to go back to add stats screen
    @IBAction func btnAddStats2(_ sender: Any) {
        self.view.window!.close()
        performSegue(withIdentifier: "addStats2", sender: self)
    }
    
    //outlets for radio buttons
    @IBOutlet weak var radPreset1: NSButton!
    @IBOutlet weak var radPreset2: NSButton!
    @IBOutlet weak var radPreset3: NSButton!
    @IBOutlet weak var radPreset4: NSButton!
    
    //prints what preset is selected
    @IBAction func radPreset1(_ sender: Any) {
        if radPreset1.state == .on {
            print("Preset 1 is selected")
            radPreset2.state = .off
            radPreset3.state = .off
            radPreset4.state = .off
        }
    }
    
    //along with other radio button actions, displays current radio button being selected by user
    @IBAction func radPreset2(_ sender: Any) {
        if radPreset2.state == .on {
            print("Preset 2 is selected")
            radPreset1.state = .off
            radPreset3.state = .off
            radPreset4.state = .off
        }
    }
    
    @IBAction func radPreset3(_ sender: Any) {
        if radPreset3.state == .on {
            print("Preset 3 is selected")
            radPreset1.state = .off
            radPreset2.state = .off
            radPreset4.state = .off
        }
    }
    
    @IBAction func radPreset4(_ sender: Any) {
        if radPreset4.state == .on {
            print("Preset 4 is selected")
            radPreset1.state = .off
            radPreset2.state = .off
            radPreset3.state = .off
        }
    }
    
    
    /*when clicking confirm check if array is empty, 
     then append new statistics into the array based
     off the class GameStats and GameStatsForEvaluation
     */
    @IBAction func btnConfirm(_ sender: Any) {
        if radPreset1.state == .on {
            self.view.window!.close() //self closes window for segue to be performed and removing multiple view controllers to be able to be open at the same time
            performSegue(withIdentifier: "gameScreenBasic", sender: self)
            if gamesList.isEmpty { /*uses newGame 
                function to append new game into
                    array, also for table view use
                                    */
                newGame(gameNumber: 0, totalPoints: 0, rebounds: 0, steals: 0, assists: 0, blocks: 0, turnovers: 0, teamPoints: 0, oppositionPoints: 0)
            }
            if gamesListForEvaluation.isEmpty { /*uses 
            newGameWithOtherStats function to append
             other game statistics into seperate array for use of evaluation
                */
                newGameWithOtherStats(onePoints: 0, twoPoints: 0, threePoints: 0, fieldGoalAttempts: 0, fieldGoalPercentage: 0.0, onePointAttempts: 0, twoPointAttempts: 0, threePointAttempts: 0, madeOnePoints: 0, madeTwoPoints: 0, madeThreePoints: 0, bpmTeamPoints: 0, bpmOppositionPoints: 0)
            }
        } else if radPreset2.state == .on {
            self.view.window!.close()
            performSegue(withIdentifier: "gameScreenBasic", sender: self)
            if gamesList.isEmpty {
                newGame(gameNumber: 0, totalPoints: 0, rebounds: 0, steals: 0, assists: 0, blocks: 0, turnovers: 0, teamPoints: 0, oppositionPoints: 0)
            }
            if gamesListForEvaluation.isEmpty {
                newGameWithOtherStats(onePoints: 0, twoPoints: 0, threePoints: 0, fieldGoalAttempts: 0, fieldGoalPercentage: 0.0, onePointAttempts: 0, twoPointAttempts: 0, threePointAttempts: 0, madeOnePoints: 0, madeTwoPoints: 0, madeThreePoints: 0, bpmTeamPoints: 0, bpmOppositionPoints: 0)
            }
        } else if radPreset3.state == .on {
            self.view.window!.close()
            performSegue(withIdentifier: "gameScreenAdvanced", sender: self)
            if gamesList.isEmpty {
                newGame(gameNumber: 0, totalPoints: 0, rebounds: 0, steals: 0, assists: 0, blocks: 0, turnovers: 0, teamPoints: 0, oppositionPoints: 0)
            }
            if gamesListForEvaluation.isEmpty {
                newGameWithOtherStats(onePoints: 0, twoPoints: 0, threePoints: 0, fieldGoalAttempts: 0, fieldGoalPercentage: 0.0, onePointAttempts: 0, twoPointAttempts: 0, threePointAttempts: 0, madeOnePoints: 0, madeTwoPoints: 0, madeThreePoints: 0, bpmTeamPoints: 0, bpmOppositionPoints: 0)
            }
        } else if radPreset4.state == .on {
            self.view.window!.close()
            performSegue(withIdentifier: "gameScreenAdvanced", sender: self)
            if gamesList.isEmpty {
                newGame(gameNumber: 0, totalPoints: 0, rebounds: 0, steals: 0, assists: 0, blocks: 0, turnovers: 0, teamPoints: 0, oppositionPoints: 0)
            }
            if gamesListForEvaluation.isEmpty {
                newGameWithOtherStats(onePoints: 0, twoPoints: 0, threePoints: 0, fieldGoalAttempts: 0, fieldGoalPercentage: 0.0, onePointAttempts: 0, twoPointAttempts: 0, threePointAttempts: 0, madeOnePoints: 0, madeTwoPoints: 0, madeThreePoints: 0, bpmTeamPoints: 0, bpmOppositionPoints: 0)
            }
        }
    }
    
    //when performing segue change variable of preset chosen for changing image colour in next segue screen
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameScreenAdvanced" {
            if let game1AdvancedViewController = segue.destinationController as? gameAdvancedViewController {
                if radPreset4.state == .on {
                    game1AdvancedViewController.preset4Chosen = 1
                } else {
                    game1AdvancedViewController.preset4Chosen = 0
                }
            }
        }
        if segue.identifier == "gameScreenBasic" {
            if let gameScreenBasicViewController = segue.destinationController as? gameScreenBasicViewController {
                if radPreset1.state == .on {
                    gameScreenBasicViewController.preset1Chosen = 1
                } else {
                    gameScreenBasicViewController.preset1Chosen = 0
                }
            }
        }
    }
    
    //function that creates new variables based on GameStats class and appends into gamesList array
    func newGame(gameNumber: Int, totalPoints: Int, rebounds: Int, steals: Int, assists: Int, blocks: Int, turnovers: Int, teamPoints: Int, oppositionPoints: Int) {
        let newGameStats = GameStats(
            gameNumber: gameNumber, totalPoints: totalPoints,
            rebounds: rebounds,
            steals: steals,
            assists: assists,
            blocks: blocks,
            turnovers: turnovers,
            teamPoints: teamPoints,
            oppositionPoints: oppositionPoints
        )
        
        gamesList.append(newGameStats)
    }
    
    //function that creates new variables based on GameStatsForEvaluation class and appends into gamesListForEvaluation array
    func newGameWithOtherStats(onePoints: Int, twoPoints: Int, threePoints: Int, fieldGoalAttempts: Int, fieldGoalPercentage: Float, onePointAttempts: Int, twoPointAttempts: Int, threePointAttempts: Int, madeOnePoints: Int, madeTwoPoints: Int, madeThreePoints: Int, bpmTeamPoints: Int, bpmOppositionPoints: Int) {
        let newGameStatsWithOthers = GameStatsForEvaluation(onePoints: onePoints, twoPoints: twoPoints, threePoints: threePoints, fieldGoalAttempts: fieldGoalAttempts, fieldGoalPercentage: fieldGoalPercentage, onePointAttempts: onePointAttempts, twoPointAttempts: twoPointAttempts, threePointAttempts: threePointAttempts, madeOnePoints: madeOnePoints, madeTwoPoints: madeTwoPoints, madeThreePoints: madeThreePoints, bpmTeamPoints: bpmTeamPoints, bpmOppositionPoints: bpmOppositionPoints)
        
        gamesListForEvaluation.append(newGameStatsWithOthers)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

