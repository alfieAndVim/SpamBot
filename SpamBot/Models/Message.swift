//
//  SpamMessage.swift
//  SpamBot
//
//  Created by Alfie Dew on 03/08/2021.
//

import Foundation
import FirebaseFirestoreSwift

struct Message: Identifiable, Codable {
    @DocumentID var id: String?
    var className: String
    var message: String
    var userID: String?
}
