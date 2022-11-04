//
//  SpamBotApp.swift
//  SpamBot
//
//  Created by Alfie Dew on 03/08/2021.
//

import SwiftUI
import Firebase
import GoogleMobileAds
import UserMessagingPlatform

@main
struct SpamBotApp: App {
    
    @State var completed: Bool
    
    init() {
        
        UMPConsentInformation.sharedInstance.reset()
        FirebaseApp.configure()
        
        Auth.auth().signInAnonymously()
        
        _completed = State(initialValue: UserDefaults.standard.bool(forKey: "permission"))
    }
    
    
    
    var body: some Scene {
        
        WindowGroup {
            if completed {
                ContentView()
            } else {
                AdConsentView(complete: $completed)
                    .background(Color.white)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
