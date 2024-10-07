//
//  gameStats.swift
//  Swish Tracker.
//
//  Created by Hayden Luu on 24/6/2024.
//

import Foundation

//class for reference statistics used for table view
class GameStats: NSObject, Encodable, Decodable {
    @objc dynamic var gameNumber: Int
    @objc dynamic var totalPoints: Int
    @objc dynamic var rebounds: Int
    @objc dynamic var steals: Int
    @objc dynamic var assists: Int
    @objc dynamic var blocks: Int
    @objc dynamic var turnovers: Int
    @objc dynamic var teamPoints: Int
    @objc dynamic var oppositionPoints: Int
    
    //initialisation for each variable in class
    init(gameNumber: Int, totalPoints: Int, rebounds: Int, steals: Int, assists: Int, blocks: Int, turnovers: Int, teamPoints: Int, oppositionPoints: Int) {
        self.gameNumber = gameNumber
        self.totalPoints = totalPoints
        self.rebounds = rebounds
        self.steals = steals
        self.assists = assists
        self.blocks = blocks
        self.turnovers = turnovers
        self.teamPoints = teamPoints
        self.oppositionPoints = oppositionPoints
    }
}

//class for reference statistics used for evaluation calculations
class GameStatsForEvaluation: NSObject, Encodable, Decodable {
    @objc dynamic var onePoints: Int
    @objc dynamic var twoPoints: Int
    @objc dynamic var threePoints: Int
    @objc dynamic var fieldGoalAttempts: Int
    @objc dynamic var fieldGoalPercentage: Float
    @objc dynamic var onePointAttempts: Int
    @objc dynamic var twoPointAttempts: Int
    @objc dynamic var threePointAttempts: Int
    @objc dynamic var madeOnePoints: Int
    @objc dynamic var madeTwoPoints: Int
    @objc dynamic var madeThreePoints: Int
    @objc dynamic var bpmTeamPoints: Int
    @objc dynamic var bpmOppositionPoints: Int
    
    //initialisation for each variable in class
    init(onePoints: Int, twoPoints: Int, threePoints: Int, fieldGoalAttempts: Int, fieldGoalPercentage: Float, onePointAttempts: Int, twoPointAttempts: Int, threePointAttempts: Int, madeOnePoints: Int, madeTwoPoints: Int, madeThreePoints: Int, bpmTeamPoints: Int, bpmOppositionPoints: Int) {
        self.onePoints = onePoints
        self.twoPoints = twoPoints
        self.threePoints = threePoints
        self.fieldGoalAttempts = fieldGoalAttempts
        self.fieldGoalPercentage = fieldGoalPercentage
        self.onePointAttempts = onePointAttempts
        self.twoPointAttempts = twoPointAttempts
        self.threePointAttempts = threePointAttempts
        self.madeOnePoints = madeOnePoints
        self.madeTwoPoints = madeTwoPoints
        self.madeThreePoints = madeThreePoints
        self.bpmTeamPoints = bpmTeamPoints
        self.bpmOppositionPoints = bpmOppositionPoints
    }
}

//arrays that can be accessed globally
var gamesList: [GameStats] = []
var gamesListForEvaluation: [GameStatsForEvaluation] = []

//seperate variables for game number and setting of game 1 as the 0th index in the array when segue is performed for first time
var gameNumber: Int = 1
var firstGame:Bool = false
var firstGame2:Bool = false
