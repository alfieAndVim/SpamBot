//
//  RequestView.swift
//  SpamBot
//
//  Created by Alfie Dew on 03/08/2021.
//

import SwiftUI
import Firebase

struct RequestView: View {
    
    
    var classChoice = ["legit", "spam"]
    
    @State private var choice = 0
    @State private var showConfirmation: Bool = false
    @State private var confirmationText = ""
    
    @Binding var showRequestBin: Bool
    @Binding var entryTextBin: String
    
    @ObservedObject var messagesViewModel: MessagesViewModel
    
    
    var body: some View {
        
        
        ZStack{
            
            VStack{
                
                
                HStack {
                    Text("Request a message")
                        .font(.system(size: 28))
                        .fontWeight(.medium)
                    
                    Button(action: closeSheet, label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .frame(width: 20, height: 20)
                    }).padding(.leading, UIScreen.main.bounds.width < 321 ? 0 : 50)
                }
        
                
                ZStack {
                    VStack {
                        
                        Text("Message")
                            .fontWeight(.bold)
                            .padding(.trailing, UIScreen.main.bounds.width / 2.5)
                        
                        Rectangle()
                            .foregroundColor(Color.white)
                            .frame(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.height / 3)
                            .cornerRadius(20)
                            .shadow(radius: 20)
                            .overlay(
                                TextEditor(text: $entryTextBin)
                                    .foregroundColor(Color.black)
                                    .cornerRadius(20)
                                    .padding(10)
                        )
                    }
                }.padding(.top, 30)
                .padding(.bottom, 15)
                
                
                VStack {
                    
                    Text("Classification")
                        .fontWeight(.bold)
                        .padding(.trailing, UIScreen.main.bounds.width / 2.9)
                    
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width * 0.75, height: 50)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 20)
                        .overlay(Picker("Class", selection: $choice) {
                            ForEach(0 ..< classChoice.count) {
                                Text(self.classChoice[$0])
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    .frame(width: UIScreen.main.bounds.width * 0.65))
                }
                
                Button(action: sendRequest) {
                    ZStack {
                        
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width * 0.3, height: 35)
                            .foregroundColor(Color.blue)
                            .cornerRadius(20)
                            .shadow(radius: 20)
                        
                        Text("Submit")
                            .foregroundColor(Color.white)
                            .fontWeight(.medium)
                    }
                    
                }.padding(.top, 15)
                
                    
                
                
                    Spacer()

            }
            
            
            
            
        }.showConfirmation(isShowing: $showConfirmation, text: confirmationText)
        .preferredColorScheme(.light)
        .padding(.top, 30)
        
        
        
        
        
        
        
        
    }
    
    func sendRequest() {
        
        let className = classChoice[choice]
        let message = entryTextBin
        let userID = Auth.auth().currentUser?.uid
        
        if message != "" {
            let request = Message(className: className, message: message, userID: userID)
            
            messagesViewModel.add(request)
        }
        
        
        if entryTextBin == "" {
            confirmationText = "Please enter\n a message"
        } else {
            confirmationText = "Thank you"
        }
        
        self.showMessage()
        entryTextBin = ""
        
    }
    
    func showMessage() {
        self.showConfirmation = true
        self.closeMessage()
    }
    
    func closeMessage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showConfirmation = false
            if confirmationText == "Thank you" {
                self.closeSheet()
            }
        }
        
    }
    
    func closeSheet() {
        showRequestBin = false
    }
    
    
    
    
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView(showRequestBin: Binding.constant(false), entryTextBin: Binding.constant(""), messagesViewModel: MessagesViewModel())
    }
}

