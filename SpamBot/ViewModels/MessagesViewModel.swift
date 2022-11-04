//
//  MessagesViewModel.swift
//  SpamBot
//
//  Created by Alfie Dew on 03/08/2021.
//

import Foundation
import Combine

class MessagesViewModel: ObservableObject {
    
    @Published var messagesRepository = MessagesRepository()
    
    func add(_ message: Message) {
        messagesRepository.add(message)
    }
}
