//
//  NetworkManager.swift
//  NotesApp
//
//  Created by Talha Asif on 18/09/2022.
//

import Foundation
import Alamofire


struct Note:Decodable{
    
    var title:String?
    var date:String?
    var _id:String?
    var note:String?
    
    
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    var delegate:noteDataDelegate?
    
    func getNotesFromServer() {
        let fetchURL = Constants.mainURL + "/fetch"
        AF.request(fetchURL).response(completionHandler: { response in
            
            if let error = response.error {
                print("Error is \(error.localizedDescription)")
                return
            }
            
            let decodedObject = try! JSONDecoder().decode([Note].self, from: response.data!)
            self.delegate?.updateArray(array: decodedObject)
        })
    }
    
    func addNote(Note:Note) {
        let fetchURL = Constants.mainURL + "/create"
        let header:HTTPHeaders = ["title":Note.title ?? "","note":Note.note ?? "","date":Note.date ?? ""]
        AF.request(fetchURL,method: .post, headers: header).response(completionHandler: { object in
            print(object.response)
        })
    }
    
    func updateNote(Note:Note) {
        let fetchURL = Constants.mainURL + "/update"
        let header:HTTPHeaders = ["title":Note.title ?? "","note":Note.note ?? "","date":Note.date ?? "","id":Note._id ?? ""]
        AF.request(fetchURL,method: .post, headers: header).response(completionHandler: { object in
        })
    }

    func deleteNote(Note:Note) {
        let fetchURL = Constants.mainURL + "/delete"
        let header:HTTPHeaders = ["id":Note._id ?? ""]
        AF.request(fetchURL,method: .post, headers: header).response(completionHandler: { object in
        })
    }
}
