//
//  addStatsViewController.swift
//  Swish Tracker.
//
//  Created by Hayden Luu on 24/6/2024.
//

import Cocoa

class addStatsViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    //declare object dynamic variable for table view use, returning games data in the gamesList array
    @objc dynamic var gamesArray: [GameStats] {
        return gamesList
    }
    
    //declare object dynamic variable for behind the screen use (evaluation), returning games data in the gamesListForEvaluation array
    @objc dynamic var gamesArrayWithOthers: [GameStatsForEvaluation] {
        return gamesListForEvaluation
    }
    
    //table view outlet
    @IBOutlet weak var tblStats: NSTableView!
    
    //save json data encrypted in base64
    @IBAction func btnSave(_ sender: Any) {
        saveToFileGamesList()
        saveToFileGamesListForEvaluation()
    }
    
    @IBAction func btnDeleteAll(_ sender: Any) {
        // Check if gamesList is not empty
        if !gamesList.isEmpty {
            // Remove all entries from gamesList
            gamesList.removeAll()
            gameNumber = 1
            // Remove all rows from the table view
            let allIndexes = IndexSet(integersIn: 0..<tblStats.numberOfRows)
            tblStats.removeRows(at: allIndexes, withAnimation: .effectFade)
            
            // Print a confirmation message
            print("All games deleted. Current games list count: \(gamesList.count)")
        } else {
            // Print a message if there are no games to delete
            print("No games to delete.")
        }
        if !gamesListForEvaluation.isEmpty { /*same 
        thing for behind the scene stats but not need
        for table view row removal
         */
            gamesListForEvaluation.removeAll()
        }
        //reset boolean values because the first game has not been appended yet
        firstGame = false
        firstGame2 = false
    }
    
    //deletes current row on table view selected by user, and removes index from arrays
    @IBAction func btnDeleteCurrent(_ sender: Any) {
        let selectedRowIndexes = tblStats.selectedRowIndexes
        
        // Check if there are selected rows
        if !selectedRowIndexes.isEmpty {
            // Remove the selected games from the gamesList
            for index in selectedRowIndexes {
                gamesList.remove(at: index)
                gamesListForEvaluation.remove(at: index)
                for eachGameNumber in gamesList {
                    if eachGameNumber.gameNumber > index {
                        eachGameNumber.gameNumber -= 1 /* when a game number is
                                    removed from the
                                    table view and
                                    the array, all
                                    numbers greater
                                    than the current
                                    game number being
                                    deleted would
                                    decrease by 1*/
                        if eachGameNumber.gameNumber == 0 {
                            eachGameNumber.gameNumber += 1 //game number cannot start at 0
                        }
                    }
                }
            }
            
            
            // Remove the selected rows from the table view
            tblStats.removeRows(at:  selectedRowIndexes, withAnimation: .effectFade)
            
            // Print confirmation message
            print("Deleted games at rows \(selectedRowIndexes). Current games list count: \(gamesList.count)")
        } else {
            print("No rows selected to delete.")
        }
    }
    
    //go back to main screen
    @IBAction func btnBackSwishTracker(_ sender: Any) {
        self.view.window!.close()
        performSegue(withIdentifier: "swishTracker1", sender: self)
    }
    
    //go to add games screen for user to choose overlay preference and add statistcs
    @IBAction func btnAddGames(_ sender: Any) {
        self.view.window!.close()
        performSegue(withIdentifier: "addGames", sender: self)
    }  
    
    //save json data from gamesList data, encrypted in base64
    func saveToFileGamesList() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try! encoder.encode(gamesList)
            let base64String = jsonData.base64EncodedString() //declare variable for data going to be encrypted in base64
            let jsonURL: URL = URL(fileURLWithPath: "gamesList.json", relativeTo: directoryURL) //set file name for json base64 encrypted file
            try base64String.write(to: jsonURL, atomically: true, encoding: .utf8)
            print("file was successfully exported") }
        catch {
            print("file could not be exported") }
    }
    
    //save json data from gamesListForEvaluation data, encrypted in base64
    func saveToFileGamesListForEvaluation() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try! encoder.encode(gamesListForEvaluation)
            let base64String = jsonData.base64EncodedString()
            let jsonURL: URL = URL(fileURLWithPath: "gamesListForEvaluation.json", relativeTo: directoryURL)
            try base64String.write(to: jsonURL, atomically: true, encoding: .utf8)
            print("file was successfully exported") }
        catch {
            print("file could not be exported") }
    }
    
    //prints to user what row is being selected in table view
    func tableViewSelectionDidChange(_ notification: Notification) {
        let selectedRow = tblStats.selectedRow
        if selectedRow != -1 {
            print("Selected row: \(selectedRow)")
        } else {
            print("No row selected")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblStats.delegate = self
        tblStats.dataSource = self
        tblStats.reloadData()
    }
    
}
