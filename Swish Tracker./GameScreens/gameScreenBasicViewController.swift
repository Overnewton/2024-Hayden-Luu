//
//  gameScreenBasicViewController.swift
//  Swish Tracker.
//
//  Created by Hayden Luu on 26/6/2024.
//

import Cocoa

class gameScreenBasicViewController: NSViewController {
    
    //outlets
    @IBOutlet weak var imgBasic: NSImageView!
    @IBOutlet weak var lblPointsBasic: NSTextField!
    @IBOutlet weak var lblReboundsBasic: NSTextField!
    @IBOutlet weak var lblAssistsBasic: NSTextField!
    @IBOutlet weak var lblBlocksBasic: NSTextField!
    @IBOutlet weak var lblStealsBasic: NSTextField!
    @IBOutlet weak var lblTeamPointsBasic: NSTextField!
    @IBOutlet weak var lblOppositionPointsBasic: NSTextField!
    @IBOutlet weak var lblGameNumber: NSTextField!
    
    //variables for customisation of overlay that user chose beforehand
    var preset1Chosen:Int = 0
    var gradient1 = NSImage(named: "gradient1")
    
    //local variables to later convert to new game stats function's variables, for table view
    var totalPoints: Int = 0
    var rebounds: Int = 0
    var assists: Int = 0
    var blocks: Int = 0
    var steals: Int = 0
    var turnovers: Int = 0
    var teamPoints: Int = 0
    var oppositionPoints: Int = 0
    
    //local variables to later convert to new game stats function's variables, for behind the screen work
    var onePoints: Int = 0
    var twoPoints: Int = 0
    var threePoints: Int = 0
    var fieldGoalAttempts: Int = 0
    var fieldGoalPercentage: Float = 0.0
    var onePointAttempts: Int = 0
    var twoPointAttempts: Int = 0
    var threePointAttempts: Int = 0
    var madeOnePoints: Int = 0
    var madeTwoPoints: Int = 0
    var madeThreePoints: Int = 0
    
    @IBAction func btnFinishBasicGame1(_ sender: Any) {
        self.view.window!.close() //close current screen
        performSegue(withIdentifier: "addGamesGSB", sender: self) //open add stats screen
    }
    
    //pass data between addStatsViewController and game1AdvancedViewController
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "addGamesGSB" {
            if let addStatsViewController = segue.destinationController as? addStatsViewController {
                let newGameStats = GameStats(
                    gameNumber: gameNumber,
                    totalPoints: totalPoints,
                    rebounds: rebounds,
                    steals: steals,
                    assists: assists,
                    blocks: blocks,
                    turnovers: turnovers,
                    teamPoints: teamPoints,
                    oppositionPoints: oppositionPoints
                ) //set new game statistics variables to local variables
                let newGameStatsWithOthers = GameStatsForEvaluation(onePoints: onePoints, twoPoints: twoPoints, threePoints: threePoints, fieldGoalAttempts: fieldGoalAttempts, fieldGoalPercentage: fieldGoalPercentage, onePointAttempts: onePointAttempts, twoPointAttempts: twoPointAttempts, threePointAttempts: threePointAttempts, madeOnePoints: madeOnePoints, madeTwoPoints: madeTwoPoints, madeThreePoints: madeThreePoints, bpmTeamPoints: 0, bpmOppositionPoints: 0)
                //set new game statistics variables to local variables
                
                // Append the new instance to gamesList
                if gamesList.count == 1 && firstGame == false {
                    gamesList[0] = newGameStats //set 0th index to newGameStats
                    firstGame = true
                } else {
                    if gameNumber > gamesList.count {
                        gameNumber = Int(gamesList.count + 1) //reset game number in case game number is greater than items in array
                    } else {
                        gameNumber += 1
                    }
                    newGameStats.gameNumber = gameNumber
                    gamesList.append(newGameStats)
                    //append current new game stats into gamesList array for table view
                }
                if gamesListForEvaluation.count == 1 && firstGame2 == false {
                    gamesListForEvaluation[0] = newGameStatsWithOthers
                    firstGame2 = true
                } else {
                    gamesListForEvaluation.append(newGameStatsWithOthers)
                    //append current new game stats into gamesListForEvaluation array for behind the screen calculation and evaluation
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { // monitor keyDown events
            self.keyDown(with: $0)
            return $0
        }
        if preset1Chosen == 1 {
            imgBasic.image = gradient1 //image changes to black, gradient1 = black
        }
        lblGameNumber.stringValue = String("Game \(Int(gamesList.count + 1))") //display new game number
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.characters {
        case "1": //player scores 1 point, contributing to total points and team points
            totalPoints += 1
            teamPoints += 1
            onePoints += 1
            onePointAttempts += 1
            madeOnePoints += 1
            lblPointsBasic.stringValue = "\(totalPoints)"
            lblTeamPointsBasic.stringValue = "T - \(teamPoints)"
        case "2": //player scores 2 points, contributing to total points and team points, and field goal is measured aswell
            totalPoints += 2
            teamPoints += 2
            twoPoints += 2
            twoPointAttempts += 1
            madeTwoPoints += 1
            fieldGoalAttempts += 1
            lblPointsBasic.stringValue = "\(totalPoints)"
            lblTeamPointsBasic.stringValue = "T - \(teamPoints)"
        case "3": //player scores 3 points, contributing to total points and team points, and field goal is measured aswell
            totalPoints += 3
            teamPoints += 3
            threePoints += 3
            threePointAttempts += 1
            fieldGoalAttempts += 1
            madeThreePoints += 1
            lblPointsBasic.stringValue = "\(totalPoints)"
            lblTeamPointsBasic.stringValue = "T - \(teamPoints)"
        case "r": //player performs 1 rebound
            rebounds += 1
            lblReboundsBasic.stringValue = "\(rebounds)"
        case "a": //player performs 1 assist
            assists += 1
            lblAssistsBasic.stringValue = "\(assists)"
        case "b": //player performs 1 block
            blocks += 1
            lblBlocksBasic.stringValue = "\(blocks)"
        case "s": //player performs 1 steal
            steals += 1
            lblStealsBasic.stringValue = "\(steals)"
        case "t": //player performs 1 turnover
            turnovers += 1
        case "!": //player attempted 1 point
            onePointAttempts += 1
        case "@": //player attempted 2 points
            twoPointAttempts += 1
            fieldGoalAttempts += 1
        case "#": //player attempted 3 points
            threePointAttempts += 1
            fieldGoalAttempts += 1
        case "-": //opposition scored
            oppositionPoints += 1
            lblOppositionPointsBasic.stringValue = "T - \(oppositionPoints)"
        case "+": //players team scored
            teamPoints += 1
            lblTeamPointsBasic.stringValue = "O - \(teamPoints)"
        default:
            break
        }
    }
    
    
}
