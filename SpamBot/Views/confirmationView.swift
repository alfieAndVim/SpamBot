//
//  confirmationView.swift
//  SpamBot
//
//  Created by Alfie Dew on 05/08/2021.
//

import SwiftUI

struct confirmationView<Presenting>: View where Presenting: View{
    
    @Binding var isShowing: Bool
    
    let presenting: () -> Presenting
    
    let text: String
    
    var body: some View {
        
        ZStack(alignment: .center) {

                        self.presenting()
                            .blur(radius: self.isShowing ? 1 : 0)

                        VStack {
                            Text("Message")
                                .fontWeight(.bold)
                                .padding(.bottom, 20)
                            Text(self.text)
                                .font(.system(size: 18))
                        }
                        .frame(width: UIScreen.main.bounds.width / 2,
                               height: UIScreen.main.bounds.width / 2)
                        .background(Color(UIColor.lightGray))
                        .foregroundColor(Color.primary)
                        .cornerRadius(20)
                        .transition(.slide)
                        .opacity(self.isShowing ? 1 : 0)
                        .animation(.easeIn)

                    }
    }
}

extension View {
    
    func showConfirmation(isShowing: Binding<Bool>, text: String) -> some View {
        confirmationView(isShowing: isShowing, presenting: { self }, text: text)
    }
}
