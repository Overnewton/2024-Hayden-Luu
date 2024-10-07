//
//  game2AdvancedViewController.swift
//  Swish Tracker.
//
//  Created by Hayden Luu on 29/7/2024.
//

import Cocoa

class game2BasicViewController: NSViewController {

    @IBOutlet weak var imgBasic: NSImageView!
    @IBOutlet weak var lblGameTwoPointsBasic: NSTextField!
    @IBOutlet weak var lblGameTwoReboundsBasic: NSTextField!
    @IBOutlet weak var lblGameTwoAssistsBasic: NSTextField!
    @IBOutlet weak var lblGameTwoBlocksBasic: NSTextField!
    @IBOutlet weak var lblGameTwoStealsBasic: NSTextField!
    @IBOutlet weak var lblGameTwoTeamPointsBasic: NSTextField!
    @IBOutlet weak var lblGameTwoOppositionPointsBasic: NSTextField!
    
    //game 2 data
    struct game2: Codable {
        var gameTwoOnePoints: Int = 0
        var gameTwoTwoPoints: Int = 0
        var gameTwoThreePoints: Int = 0
        var gameTwoFieldGoalAttempts: Int = 0
        var gameTwoFieldGoalPercentage: Float = 0.0
        var gameTwoOnePointAttempts: Int = 0
        var gameTwoTwoPointAttempts: Int = 0
        var gameTwoThreePointAttempts: Int = 0
        var gameTwoPlayerOnCourt: Bool = false
    }
    
    @objc dynamic var game2Array: [game2Stats] = [game2Stats(gameTwoTotalPoints: 0, gameTwoRebounds: 0, gameTwoSteals: 0, gameTwoAssists: 0, gameTwoBlocks: 0, gameTwoTurnovers: 0, gameTwoTeamPoints: 0, gameTwoOppositionPoints: 0)]
    
    var entGame2: Int = 0
    var gameTwoStatsBasic = game2()
    var preset1Chosen:Int = 0
    var gradient1 = NSImage(named: "gradient1")
    
    @IBAction func btnFinishBasicGame2(_ sender: Any) {
        self.view.window!.close()
        performSegue(withIdentifier: "addGamesG2B", sender: self)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "addGamesG2B" {
            if let addStatsViewController = segue.destinationController as? addStatsViewController {
                addStatsViewController.entGame1 = 1
                if let stats = game2Array.first {
                    addStatsViewController.game2Array = [game2Stats(gameTwoTotalPoints: stats.gameTwoTotalPoints, gameTwoRebounds: stats.gameTwoRebounds, gameTwoSteals: stats.gameTwoSteals, gameTwoAssists: stats.gameTwoBlocks, gameTwoBlocks: stats.gameTwoBlocks, gameTwoTurnovers: stats.gameTwoTurnovers, gameTwoTeamPoints: stats.gameTwoTeamPoints, gameTwoOppositionPoints: stats.gameTwoOppositionPoints)]
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
            self.keyDown(with: $0)
            return $0
        }
        if preset1Chosen == 1 {
            imgBasic.image = gradient1
        }
    }
    
    override func keyDown(with event: NSEvent) {
            if let stats = game2Array.first {
        switch event.characters {
            case "1":
                gameTwoStatsBasic.gameTwoOnePoints += 1
            stats.gameTwoTeamPoints += 1
            stats.gameTwoTotalPoints += 1
            lblGameTwoPointsBasic.stringValue = String(Int(gameTwoStatsBasic.gameTwoOnePoints + gameTwoStatsBasic.gameTwoTwoPoints + gameTwoStatsBasic.gameTwoThreePoints))
            lblGameTwoTeamPointsBasic.stringValue = String("T - \(Int(stats.gameTwoTeamPoints))")
            case "2":
                gameTwoStatsBasic.gameTwoTwoPoints += 2
            stats.gameTwoTeamPoints += 2
            stats.gameTwoTotalPoints += 2
            lblGameTwoPointsBasic.stringValue = String(Int(gameTwoStatsBasic.gameTwoOnePoints + gameTwoStatsBasic.gameTwoTwoPoints + gameTwoStatsBasic.gameTwoThreePoints))
            lblGameTwoTeamPointsBasic.stringValue = String("T - \(Int(stats.gameTwoTeamPoints))")
            case "3":
                gameTwoStatsBasic.gameTwoThreePoints += 3
            stats.gameTwoTeamPoints += 3
            stats.gameTwoTotalPoints += 3
            lblGameTwoPointsBasic.stringValue = String(Int(gameTwoStatsBasic.gameTwoOnePoints + gameTwoStatsBasic.gameTwoTwoPoints + gameTwoStatsBasic.gameTwoThreePoints))
            lblGameTwoTeamPointsBasic.stringValue = String("T - \(Int(stats.gameTwoTeamPoints))")
            case "r":
                stats.gameTwoRebounds += 1
                lblGameTwoReboundsBasic.stringValue = String(Int(stats.gameTwoRebounds))
            case "a":
            stats.gameTwoAssists += 1
            lblGameTwoAssistsBasic.stringValue = String(Int(stats.gameTwoAssists))
            case "b":
            stats.gameTwoBlocks += 1
                lblGameTwoBlocksBasic.stringValue = String(Int(stats.gameTwoBlocks))

            case "s":
            stats.gameTwoSteals += 1
            lblGameTwoStealsBasic.stringValue = String(Int(stats.gameTwoSteals))
            case "t":
            stats.gameTwoTurnovers += 1
            case "+":
            stats.gameTwoTeamPoints += 1
            lblGameTwoTeamPointsBasic.stringValue = String("T - \(Int(stats.gameTwoTeamPoints))")
            case "-":
            stats.gameTwoOppositionPoints += 1
            lblGameTwoOppositionPointsBasic.stringValue = "O - \(stats.gameTwoOppositionPoints)"
            default:
                break
            }
        }
    }
    
}
