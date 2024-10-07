//
//  game1Advanced.swift
//  Swish Tracker.
//
//  Created by Hayden Luu on 25/6/2024.
//

import Cocoa

class gameAdvancedViewController: NSViewController {
    
    //outputs
    @IBOutlet weak var lblPointsAdvanced: NSTextField!
    @IBOutlet weak var lblReboundsAdvanced: NSTextField!
    @IBOutlet weak var lblAssistsAdvanced: NSTextField!
    @IBOutlet weak var lblBlocksAdvanced: NSTextField!
    @IBOutlet weak var lblStealsAdvanced: NSTextField!
    @IBOutlet weak var lblFieldGoalAttemptsAdvanced: NSTextField!
    @IBOutlet weak var lblFieldGoalPercentageAdvanced: NSTextField!
    @IBOutlet weak var lblPlayerOnCourtAdvanced: NSTextField!
    @IBOutlet weak var imgTopAdvanced: NSImageView!
    @IBOutlet weak var imgBottomAdvanced: NSImageView!
    @IBOutlet weak var lblTeamPointsAdvanced: NSTextField!
    @IBOutlet weak var lblOppositionPointsAdvanced: NSTextField!
    @IBOutlet weak var lblGameNumber: NSTextField!
    
    //variables for customisation of overlay that user chose beforehand
    var gradient1 = NSImage(named: "gradient1")
    var preset4Chosen:Int = 0
    
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
    var bpmTeamPoints: Int = 0
    var bpmOppositionPoints: Int = 0
    var playerOnCourt: Bool = false
    
    
    @IBAction func btnFinishAdvanced(_ sender: Any) {
        performSegue(withIdentifier: "addStatsGSA", sender: self) //opem add stats screen
        self.view.window!.close() //close current screen
    }
    
    //pass data between addStatsViewController and game1AdvancedViewController
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "addStatsGSA" {
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
                let newGameStatsWithOthers = GameStatsForEvaluation(onePoints: onePoints, twoPoints: twoPoints, threePoints: threePoints, fieldGoalAttempts: fieldGoalAttempts, fieldGoalPercentage: fieldGoalPercentage, onePointAttempts: onePointAttempts, twoPointAttempts: twoPointAttempts, threePointAttempts: threePointAttempts, madeOnePoints: madeOnePoints, madeTwoPoints: madeTwoPoints, madeThreePoints: madeThreePoints, bpmTeamPoints: bpmTeamPoints, bpmOppositionPoints: bpmOppositionPoints)
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
    
    override func viewWillAppear() {
        super.viewWillAppear()
        if let window = self.view.window {
            window.isOpaque = false //allows transparency of background
            window.backgroundColor = NSColor.clear //makes view between top and bottom boxes transparent, and screen behind it is visible in that space
        }
        if preset4Chosen == 1 {
            imgTopAdvanced.image = gradient1 //image changes to black, gradient1 = black
            imgBottomAdvanced.image = gradient1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { // monitor keyDown events
            self.keyDown(with: $0)
            return $0
        }
        if preset4Chosen == 1 {
            imgTopAdvanced.image = gradient1
            imgBottomAdvanced.image = gradient1
        }
        lblGameNumber.stringValue = String("Game \(Int(gamesList.count + 1))") //display new game number
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.characters {
        case "1": //player scores 1 point, contributing to total points and team points
            onePoints += 1
            onePointAttempts += 1
            madeOnePoints += 1
            if playerOnCourt == true { //count box plus minus points
                bpmTeamPoints += 1
                teamPoints += 1
            } else {
                teamPoints += 1
            }
            totalPoints += 1
            lblPointsAdvanced.stringValue = String(Int(onePoints + twoPoints + threePoints ))
            lblTeamPointsAdvanced.stringValue = "T - \(teamPoints)"
            lblFieldGoalAttemptsAdvanced.stringValue = String(Int(fieldGoalAttempts))
            fieldGoalPercentage = Float(madeTwoPoints + madeThreePoints) / Float(twoPointAttempts + threePointAttempts)
            lblFieldGoalPercentageAdvanced.stringValue = String(format: "%.1f", fieldGoalPercentage * 100) //format to 1 decimal place
        case "2": //player scores 2 points, contributing to total points and team points, and field goal is measured aswell
            twoPoints += 2
            madeTwoPoints += 1
            twoPointAttempts += 1
            fieldGoalAttempts += 1
            if playerOnCourt == true { //count box plus minus points
                bpmTeamPoints += 2
                teamPoints += 2
            } else {
                teamPoints += 2
            }
            totalPoints += 2
            lblPointsAdvanced.stringValue = String(Int(onePoints + twoPoints + threePoints ))
            lblFieldGoalAttemptsAdvanced.stringValue = String(Int(fieldGoalAttempts))
            lblTeamPointsAdvanced.stringValue = "T - \(teamPoints)"
            lblFieldGoalAttemptsAdvanced.stringValue = String(Int(fieldGoalAttempts))
            fieldGoalPercentage = Float(madeTwoPoints + madeThreePoints) / Float(twoPointAttempts + threePointAttempts)
            lblFieldGoalPercentageAdvanced.stringValue = String(format: "%.1f", fieldGoalPercentage * 100) //format to 1 decimal place
        case "3": //player scores 3 points, contributing to total points and team points, and field goal is measured aswell
            threePoints += 3
            madeThreePoints += 1
            threePointAttempts += 1
            fieldGoalAttempts += 1
            if playerOnCourt == true { //count box plus minus points
                bpmTeamPoints += 3
                teamPoints += 3
            } else {
                teamPoints += 3
            }
            totalPoints += 3
            lblPointsAdvanced.stringValue = String(Int(onePoints + twoPoints + threePoints ))
            lblFieldGoalAttemptsAdvanced.stringValue = String(Int(fieldGoalAttempts))
            lblTeamPointsAdvanced.stringValue = "T - \(teamPoints)"
            lblFieldGoalAttemptsAdvanced.stringValue = String(Int(fieldGoalAttempts))
            fieldGoalPercentage = Float(madeTwoPoints + madeThreePoints) / Float(twoPointAttempts + threePointAttempts)
            lblFieldGoalPercentageAdvanced.stringValue = String(format: "%.1f", fieldGoalPercentage * 100) //format to 1 decimal place
        case "r":
            rebounds += 1 //player performs 1 rebound
            lblReboundsAdvanced.stringValue = String(Int(rebounds))
        case "a": //player performs 1 assist
            assists += 1
            lblAssistsAdvanced.stringValue = String(Int(assists))
        case "b": //player performs 1 block
            blocks += 1
            lblBlocksAdvanced.stringValue = String(Int(blocks))
        case "s": //player performs 1 steal
            steals += 1
            lblStealsAdvanced.stringValue = String(Int(steals))
        case "t": //player performs 1 turnover
            turnovers += 1
        case "p": //display if player is on court or not
            playerOnCourt.toggle()
            if playerOnCourt == false {
                lblPlayerOnCourtAdvanced.stringValue = "OFF"
            } else {
                lblPlayerOnCourtAdvanced.stringValue = "ON"
            }
        case "!": //player attempted 1 point
            onePointAttempts += 1
            lblFieldGoalAttemptsAdvanced.stringValue = String(Int(fieldGoalAttempts))
            fieldGoalPercentage = Float(madeTwoPoints + madeThreePoints) / Float(twoPointAttempts + threePointAttempts)
            lblFieldGoalPercentageAdvanced.stringValue = String(format: "%.1f", fieldGoalPercentage * 100) //format to 1 decimal place
        case "@": //player attempted 2 points
            twoPointAttempts += 1
            fieldGoalAttempts += 1
            lblFieldGoalAttemptsAdvanced.stringValue = String(Int(fieldGoalAttempts))
            lblFieldGoalAttemptsAdvanced.stringValue = String(Int(fieldGoalAttempts))
            fieldGoalPercentage = Float(madeTwoPoints + madeThreePoints) / Float(twoPointAttempts + threePointAttempts)
            lblFieldGoalPercentageAdvanced.stringValue = String(format: "%.1f", fieldGoalPercentage * 100) //format to 1 decimal place
        case "#": //player attempted 3 points
            threePointAttempts += 1
            fieldGoalAttempts += 1
            lblFieldGoalAttemptsAdvanced.stringValue = String(Int(fieldGoalAttempts))
            fieldGoalPercentage = Float(madeTwoPoints + madeThreePoints) / Float(twoPointAttempts + threePointAttempts)
            lblFieldGoalPercentageAdvanced.stringValue = String(format: "%.1f", fieldGoalPercentage * 100) //format to 1 decimal place
            
        case "+": //players team scored
            if playerOnCourt == true { //count box plus minus points
                bpmTeamPoints += 1
                teamPoints += 1
            } else {
                teamPoints += 1
            }
            lblTeamPointsAdvanced.stringValue = "T - \(teamPoints)"
        case "-": //opposition team scored
            if playerOnCourt == true { //count box plus minus points for opposition team
                bpmOppositionPoints += 1
                oppositionPoints += 1
            } else {
                oppositionPoints += 1
            }
            lblOppositionPointsAdvanced.stringValue = "O - \(oppositionPoints)"
        default:
            
            break
        }
    }
    
}
