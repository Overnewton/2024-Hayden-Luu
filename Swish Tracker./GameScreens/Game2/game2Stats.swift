//
//  game2Stats.swift
//  Swish Tracker.
//
//  Created by Hayden Luu on 29/7/2024.
//

import Foundation

class game2Stats: NSObject {
    @objc dynamic var gameTwoTotalPoints: Int
    @objc dynamic var gameTwoRebounds: Int
    @objc dynamic var gameTwoSteals: Int
    @objc dynamic var gameTwoAssists: Int
    @objc dynamic var gameTwoBlocks: Int
    @objc dynamic var gameTwoTurnovers: Int
    @objc dynamic var gameTwoTeamPoints: Int
    @objc dynamic var gameTwoOppositionPoints: Int
    
    init(gameTwoTotalPoints: Int, gameTwoRebounds: Int, gameTwoSteals: Int, gameTwoAssists: Int, gameTwoBlocks: Int, gameTwoTurnovers: Int, gameTwoTeamPoints: Int, gameTwoOppositionPoints: Int) {
        self.gameTwoTotalPoints = gameTwoTotalPoints
        self.gameTwoRebounds = gameTwoRebounds
        self.gameTwoSteals = gameTwoSteals
        self.gameTwoAssists = gameTwoAssists
        self.gameTwoBlocks = gameTwoBlocks
        self.gameTwoTurnovers = gameTwoTurnovers
        self.gameTwoTeamPoints = gameTwoTeamPoints
        self.gameTwoOppositionPoints = gameTwoOppositionPoints
    }
}
