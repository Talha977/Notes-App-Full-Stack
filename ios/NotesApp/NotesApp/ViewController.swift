//
//  ViewController.swift
//  NotesApp
//
//  Created by Talha Asif on 11/09/2022.
//

import UIKit

protocol noteDataDelegate {
    
    func updateArray(array:[Note])
    
}

class ViewController: UIViewController {
    
    //https://www.youtube.com/watch?v=vKCdVAg5h40
    
    var notesArray = [Note]()
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getNotesFromServer()
        NetworkManager.shared.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getNotesFromServer()
        NetworkManager.shared.delegate = self
    }
    
    // MARK: - IBACTION
    
    @IBAction func onTapAddNote(_ sender: UIBarButtonItem) {
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.updateIdentifier {
            let destination = segue.destination as! NoteDetailsViewController
            destination.isUpdating = true
            destination.currentNote = self.notesArray[self.tableView.indexPathForSelectedRow?.row ?? 0]
        }
    }
    
    
    func getNotesFromServer() {
        NetworkManager.shared.getNotesFromServer()
    }
    
}

// MARK: - TABLE VIEW DELEGATE

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeNoteCell") as! NotePrototypeCell
        cell.labelTitle.text = notesArray[indexPath.row].title
        cell.labelNote.text = notesArray[indexPath.row].note
        cell.labelDate.text = notesArray[indexPath.row].date
        return cell
        
    }
    
}

extension ViewController:noteDataDelegate {
    func updateArray(array: [Note]) {
        self.notesArray = array
        self.tableView.reloadData()
    }
}

