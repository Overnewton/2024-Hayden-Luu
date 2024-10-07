//
//  evaluationViewController.swift
//  Swish Tracker.
//
//  Created by Hayden Luu on 25/6/2024.
//

import Cocoa

class evaluationViewController: NSViewController, NSComboBoxDataSource, NSComboBoxDelegate {
    
    // Arrays to hold game statistics for evaluation
    var gamesArray: [GameStats] = gamesList
    var gamesArrayWithOthers: [GameStatsForEvaluation] = gamesListForEvaluation
    
    //outlets
    @IBOutlet weak var cmbGames: NSComboBox!
    @IBOutlet weak var lblPlayerEfficiencyRating: NSTextField!
    @IBOutlet weak var lblDoubleDouble: NSTextField!
    @IBOutlet weak var lblTripleDouble: NSTextField!
    @IBOutlet weak var lblPerformance: NSTextField!
    @IBOutlet weak var lblBoxPlusMinus: NSTextField!
    @IBOutlet weak var lblAssistToTurnoverRatio: NSTextField!
    @IBOutlet weak var lblTrueShootingPercentage: NSTextField!
    @IBOutlet weak var lblFreeThrowPercentage: NSTextField!
    @IBOutlet weak var lblTwoPointsPercentage: NSTextField!
    @IBOutlet weak var lblThreePointsPercentage: NSTextField!
    @IBOutlet weak var lblResultOfGame: NSTextField!
    @IBOutlet weak var lblAveragePointsAllGames: NSTextField!
    @IBOutlet weak var lblSelectedGameNumber: NSTextField!
    @IBOutlet weak var lblSelectedGamePoints: NSTextField!
    @IBOutlet weak var lblSelectedGameRebounds: NSTextField!
    @IBOutlet weak var lblSelectedGameAssists: NSTextField!
    @IBOutlet weak var lblSelectedGameBlocks: NSTextField!
    @IBOutlet weak var lblSelectedGameSteals: NSTextField!
    @IBOutlet weak var lblSelectedGameTurnovers: NSTextField!
    @IBOutlet weak var lblSelectedGameTeamPoints: NSTextField!
    @IBOutlet weak var lblSelectedGameOppositionPoints: NSTextField!
    
    
    
    
    
    // Variables to hold calculated metrics
    var playerEfficiencyRating: Float = 0.0
    var assistToTurnoverRatio: Float = 0.0
    var boxPlusMinus: Int = 0
    var trueShootingPercentage: Float = 0.0
    var freeThrowPercentage: Float = 0.0
    var twoPointsPercentage: Float = 0.0
    var threePointsPercentage: Float = 0.0
    var gameResults: String = ""
    
    //seperate variable to calculate players performance in a game compared to the average basketball player
    var performancePoints: Float = 0.0
    var performanceRebounds: Float = 0.0
    var performanceAssists: Float = 0.0
    var performanceBlocks: Float = 0.0
    var performanceSteals: Float = 0.0
    var performance: String = ""
    var comparisonFiveStatsAddedTogether: Float = 0.0
    var comparisonInTotal: Float = 0.0
    
    //struct for comparison of player performance and average database for a generally average player
    struct comparisonStatistics {
        var comparisonPoints: Int = 8
        var comparisonRebounds: Int = 5
        var comparisonAssists: Int = 3
        var comparisonBlocks: Int = 1
        var comparisonSteals: Int = 2
        var comparisonOverall: Int = 5
    }
    
    var comparisonStats = comparisonStatistics()
    
    // Action method for navigating back to the previous view
    @IBAction func btnSwishTracker2(_ sender: Any) {
        self.view.window!.close() // Close the current window
        performSegue(withIdentifier: "swishTracker2", sender: self) // Perform segue to the previous view
    }
    
    //Number of items in combo box
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        return gamesArray.count //return number of games
    }
    
    //Provide string for each item in the combo box
    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        if index >= 0 && index < gamesArray.count
        {
            return String("Game \(gamesArray[index].gameNumber)") // Display game number
        } else {
            return nil
        }
    }
    
    // Delegate Method: Called when the selection in the combo box changes
    func comboBoxSelectionDidChange(_ notification: Notification) {
        let selectedIndex = cmbGames.indexOfSelectedItem // Get the selected index
        if selectedIndex >= 0 && selectedIndex < gamesArray.count {
            let selectedGame = gamesArray[selectedIndex] // Get the selected game
            print("Selected game: \(selectedGame.gameNumber)") // Print selected game number
            let selectedGameOthers = gamesArrayWithOthers[selectedIndex] // Get evaluation stats for the selected game
            
            // Variables for easier readability and calculations
            var fieldGoalAttempts: Float = 0.0
            var madeTwoPoints: Float = 0.0
            var madeThreePoints: Float = 0.0
            var onePointAttempts: Float = 0.0
            var madeOnePoints: Float = 0.0
            var totalPoints: Float = 0.0
            var rebounds: Float = 0.0
            var assists: Float = 0.0
            var steals: Float = 0.0
            var blocks: Float = 0.0
            var turnovers: Float = 0.0
            var bpmTeamPoints: Int = 0
            var bpmOppositionPoints: Int = 0
            var averagePoints: Float = 0.0
            let gamesCount = Float(gamesList.count)
            
            // Calculate total stats from gamesList
            for eachGameStats in gamesList {
                totalPoints += Float(eachGameStats.totalPoints)
                rebounds += Float(eachGameStats.rebounds)
                assists += Float(eachGameStats.assists)
                steals += Float(eachGameStats.steals)
                blocks += Float(eachGameStats.blocks)
                turnovers += Float(eachGameStats.turnovers)
                averagePoints += Float(eachGameStats.totalPoints)
            }
            // Calculate additional stats from gamesListForEvaluation
            for eachGameStats in gamesListForEvaluation {
                fieldGoalAttempts += Float(eachGameStats.fieldGoalAttempts)
                madeTwoPoints += Float(eachGameStats.madeTwoPoints)
                madeThreePoints += Float(eachGameStats.madeThreePoints)
                onePointAttempts += Float(eachGameStats.onePointAttempts)
                madeOnePoints += Float(eachGameStats.madeOnePoints)
                bpmTeamPoints += Int(eachGameStats.bpmTeamPoints)
                bpmOppositionPoints += Int(eachGameStats.bpmOppositionPoints)
            }
            
            // Calculate missed field goals and free throws
            let missedFG = fieldGoalAttempts - (madeTwoPoints + madeThreePoints)
            let missedFT = onePointAttempts - madeOnePoints
            
            // True Shooting Percentage Calculation
            let tsNumerator = totalPoints
            let tsDenominator = 2 * (fieldGoalAttempts + (0.44 * onePointAttempts))
            
            // Player Efficiency Rating Calculation
            let pePart1 = totalPoints + rebounds + assists + steals + blocks
            let pePart2 = 0 - missedFG - missedFT - turnovers
            let peNumerator = pePart1 + pePart2
            let peDenominator = gamesCount
            
            // set variable calculations
            boxPlusMinus = Int(bpmTeamPoints - bpmOppositionPoints)
            playerEfficiencyRating = Float(Float(peNumerator)/Float(peDenominator))
            trueShootingPercentage = Float(Float(tsNumerator)/Float(tsDenominator))
            freeThrowPercentage = Float(Float(selectedGameOthers.madeOnePoints) / Float(selectedGameOthers.onePointAttempts))
            twoPointsPercentage = Float(Float(selectedGameOthers.madeTwoPoints) / Float(selectedGameOthers.twoPointAttempts))
            threePointsPercentage = Float(Float(selectedGameOthers.madeThreePoints) / Float(selectedGameOthers.threePointAttempts))
            assistToTurnoverRatio = Float(Float(selectedGame.assists) / Float(selectedGame.turnovers))
            performancePoints = Float(Float(selectedGame.totalPoints)/Float(comparisonStats.comparisonPoints))
            performanceRebounds = Float(Float(selectedGame.rebounds)/Float(comparisonStats.comparisonRebounds))
            performanceAssists = Float(Float(selectedGame.assists)/Float(comparisonStats.comparisonAssists))
            performanceBlocks = Float(Float(selectedGame.blocks)/Float(comparisonStats.comparisonBlocks))
            performanceSteals = Float(Float(selectedGame.steals)/Float(comparisonStats.comparisonSteals))
            comparisonFiveStatsAddedTogether = Float(performancePoints + performanceRebounds + performanceAssists + performanceSteals + performanceBlocks)
            
            //determine player performance
            comparisonInTotal = Float(comparisonFiveStatsAddedTogether) - Float(comparisonStats.comparisonOverall)
            if comparisonInTotal <= -5 {
                lblPerformance.stringValue = "Terrible"
            } else if comparisonInTotal > -5 && comparisonInTotal <= -2.5 {
                lblPerformance.stringValue = "Bad"
            } else if comparisonInTotal > -2.5 && comparisonInTotal < 0 {
                lblPerformance.stringValue = "Below Average"
            } else if comparisonInTotal >= 0 && comparisonInTotal < 2.5 {
                lblPerformance.stringValue = "Average"
            } else if comparisonInTotal >= 2.5 && comparisonInTotal < 5 {
                lblPerformance.stringValue = "Good"
            } else if comparisonInTotal >= 5 {
                lblPerformance.stringValue = "Excellent!"
            }
            
            // Determine game result
            if selectedGame.teamPoints > selectedGame.oppositionPoints {
                gameResults = "Win"
            } else if selectedGame.teamPoints == selectedGame.oppositionPoints {
                gameResults = "Draw"
            } else {
                gameResults = "Loss"
            }
            
            //calculate box plus minus depending on if user has used basic overlay or has not gone on court yet
            if bpmTeamPoints > 0 || bpmOppositionPoints > 0{
                if boxPlusMinus == 0 {
                    lblBoxPlusMinus.stringValue = "0"
                } else {
                    lblBoxPlusMinus.stringValue = String("          \(Int(boxPlusMinus))")
                }
            } else {
                if firstGame == true {
                    lblBoxPlusMinus.stringValue = "User must advanced overlay"
                } else {
                    lblBoxPlusMinus.stringValue = "         Player was not on court"
                }
            }
            
            
            // Average Points Calculation
            if averagePoints.isNaN || averagePoints == 0 {
                lblAveragePointsAllGames.stringValue = "No points for calculation"
            } else {
                averagePoints = Float(Float(averagePoints)/Float(gamesCount))
                lblAveragePointsAllGames.stringValue = String("\(String(format: "%.1f", averagePoints)) PPG")
            }
            
            // Player Efficiency Rating Display
            if playerEfficiencyRating.isNaN {
                lblPlayerEfficiencyRating.stringValue = "could not calculate"
            } else {
                lblPlayerEfficiencyRating.stringValue = String("\(String(format: "%.1f", playerEfficiencyRating))%")
            }
            
            // True Shooting Percentage Display
            if trueShootingPercentage.isNaN {
                lblTrueShootingPercentage.stringValue = "0 1-Point Attempts or FGA"
            } else {
                lblTrueShootingPercentage.stringValue = String("\(String(format: "%.1f", trueShootingPercentage * 100))%")
            }
            
            // Assist to Turnover Ratio Display
            if assistToTurnoverRatio.isInfinite || assistToTurnoverRatio.isNaN {
                lblAssistToTurnoverRatio.stringValue = String("No assists or turnovers")
            } else {
                lblAssistToTurnoverRatio.stringValue = String("\(String(format: "%.1f", assistToTurnoverRatio * 100))%")
            }
                
            // Free Throw Percentage Display
            if freeThrowPercentage.isNaN {
                lblFreeThrowPercentage.stringValue = String("No free throw attempts")
            } else {
                lblFreeThrowPercentage.stringValue = String("\(String(format: "%.1f", freeThrowPercentage * 100))%")
            }
            
            // Two Points Percentage Display
            if twoPointsPercentage.isNaN {
                lblTwoPointsPercentage.stringValue = String("No 2 point attempts")
            } else {
                lblTwoPointsPercentage.stringValue = String("\(String(format: "%.1f", twoPointsPercentage * 100))%")
            }
            
            // Three Points Percentage Display
            if threePointsPercentage.isNaN {
                lblThreePointsPercentage.stringValue = String("No 3 point attempts")
            } else {
                lblThreePointsPercentage.stringValue = String("\(String(format: "%.1f", threePointsPercentage * 100))%")
            }
            
            // String value to calculate selected game from combo box's results
            lblResultOfGame.stringValue = gameResults
            
            //declare array for selected game for triple double and double double check
            let stats = [selectedGame.totalPoints, selectedGame.assists, selectedGame.rebounds, selectedGame.blocks, selectedGame.steals]
            
            /*declare variable for count to check for 
             double double or triple double by
             checking if a value from the selected
             game statistics is greater than one
             */
            var count = 0
            for stat in stats {
                if stat >= 10 {
                    count += 1
                }
            }
            
            //check for double double
            if count == 2 {
                lblDoubleDouble.stringValue =  "Yes"
                lblTripleDouble.stringValue = "No"
            } else if count < 2 {
                lblDoubleDouble.stringValue = "No"
                lblTripleDouble.stringValue = "No"
            }
            
            //check for triple double, and if true, double double is also true
            if count >= 3 {
                lblTripleDouble.stringValue = "Yes"
                lblDoubleDouble.stringValue = "Yes"
            } else {
                lblTripleDouble.stringValue = "No"
            }
            
            //display selected game statistics to user
            lblSelectedGameNumber.stringValue = String(selectedGame.gameNumber)
            lblSelectedGamePoints.stringValue = String(selectedGame.totalPoints)
            lblSelectedGameRebounds.stringValue = String(selectedGame.rebounds)
            lblSelectedGameAssists.stringValue = String(selectedGame.assists)
            lblSelectedGameBlocks.stringValue = String(selectedGame.blocks)
            lblSelectedGameSteals.stringValue = String(selectedGame.steals)
            lblSelectedGameTurnovers.stringValue = String(selectedGame.turnovers)
            lblSelectedGameTeamPoints.stringValue = String(selectedGame.teamPoints)
            lblSelectedGameOppositionPoints.stringValue = String(selectedGame.oppositionPoints)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //combo box uses data from how many games are appended in the array
        cmbGames.usesDataSource = true
        cmbGames.dataSource = self
        cmbGames.delegate = self
        // Ensure gamesArray is not empty
        if gamesArray.isEmpty {
            print("gamesArray is empty!")
        } else {
            cmbGames.reloadData()
        }
    }
    
}
