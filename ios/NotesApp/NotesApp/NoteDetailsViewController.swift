//
//  NoteDetailsViewController.swift
//  NotesApp
//
//  Created by Talha Asif on 18/09/2022.
//

import UIKit

class NoteDetailsViewController: UIViewController {
    
    @IBOutlet weak var buttonAdd: UIBarButtonItem!
    @IBOutlet weak var buttonDelete: UIBarButtonItem!
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textViewNote: UITextView!
    
    var isUpdating = false
    var currentNote = Note()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    
    @IBAction func onTapDelete(_ sender: UIBarButtonItem) {

        NetworkManager.shared.deleteNote(Note: currentNote)

    }
    
    @IBAction func onTapAdd(_ sender: UIBarButtonItem) {
        
        var note = Note(title: self.textFieldTitle.text, date: getTodaysFormattedDate(), note: self.textViewNote.text)
        if isUpdating{
            note._id = currentNote._id
            NetworkManager.shared.updateNote(Note: note)
        }
        else {
        NetworkManager.shared.addNote(Note: note)
        }
        
    }
    
    func setupUI() {
        if isUpdating {
            self.buttonAdd.title = "Update"
            self.textFieldTitle.text = currentNote.title
            self.textViewNote.text = currentNote.note
        }
        else {
            self.buttonDelete.isEnabled = false
            self.buttonDelete.title = ""
        }
    }
    
    func getTodaysFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        let formattedDate = formatter.string(from: Date())
        return formattedDate
    }
    
    
}
