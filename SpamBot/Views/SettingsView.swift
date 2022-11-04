//
//  SettingsView.swift
//  SpamBot
//
//  Created by Alfie Dew on 07/09/2021.
//

import SwiftUI

struct SettingsView: View {
    
    @State var complete = false
    
    var body: some View {
        
        List {
            
            Section {
                Link("Privacy Policy", destination: URL(string: "https://sites.google.com/view/spambot/home/privacy-policy")!)
                Link("Terms & Conditions", destination: URL(string: "https://sites.google.com/view/spambot/home/terms-conditions")!)
            }
            
        }.navigationBarTitle("Settings")
        .listStyle(InsetGroupedListStyle())
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
