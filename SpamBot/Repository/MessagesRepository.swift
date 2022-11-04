//
//  MessagesRepository.swift
//  SpamBot
//
//  Created by Alfie Dew on 03/08/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class MessagesRepository: ObservableObject {
    
    private let store = Firestore.firestore()
    private let path = "messagesStore"
    
    
    func add(_ message: Message) {
        do {
            _ = try store.collection(path).addDocument(from: message)
        } catch {
            fatalError("Message could not be uploaded")
        }
    }
}
