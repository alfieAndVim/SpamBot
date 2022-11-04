//
//  ContentView.swift
//  SpamBot
//
//  Created by Alfie Dew on 03/08/2021.
//

import SwiftUI

struct ContentView: View {
        
        init() {
            UITextView.appearance().backgroundColor = .clear
            
            
        }
    
    
    @State private var entryText = ""
    @State private var showRequest = false
    
    
    
    @State private var probability = 0.0
    @State private var probabilityStr = "0%"
    @State private var truePrediction = "Start\ntyping..."
    
    
    let logic = modelLogic()
    
    var body: some View {
        
        NavigationView {
            
        
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
                
            VStack {
                HStack{
                    Text("SpamBot")
                        .font(.system(size: 32))
                        .fontWeight(.medium)
                        .padding(.trailing, 140)
                    
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.gray)
                    }
                }.padding(.top, 20)
                
                    
                
                ScrollView(.vertical) {
                    VStack(alignment: .center){
                            
                        
                            
                            HStack {
                                Text("Message")
                                    .fontWeight(.bold)
                                    .padding(.trailing, UIScreen.main.bounds.width / 3.5)
                                
                                Button(action: toggle) {
                                
                                    ZStack{
                                        Rectangle()
                                            .frame(width: 50, height: 30)
                                            .cornerRadius(10)
                                            .foregroundColor(.blue)
                                        
                                        Image(systemName: "plus")
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                                
                            TextFieldView(entryTextBin: $entryText, probabilityBin: $probability, probabilityStrBin: $probabilityStr, truePredictionBin: $truePrediction)
                            
                            HStack{
                                VStack {
                                    
                                    Text("Prediction")
                                        .fontWeight(.bold)
                                    
                                    predictionView(truePredictionBin: $truePrediction)
                                }
                                
                                VStack {
                                    
                                    Text("Confidence")
                                        .fontWeight(.bold)
                                    
                                    confidenceView(probabilityBin: $probability, probabilityStrBin: $probabilityStr)
                                }
                            }
                            
                           Spacer()
                    }.frame(width: UIScreen.main.bounds.width)
                    .padding(.top, 10)
                }
                
            
            }
                
        }        .sheet(isPresented: $showRequest, content: {
            RequestView(showRequestBin: $showRequest, entryTextBin: $entryText, messagesViewModel: MessagesViewModel())
        })
        .preferredColorScheme(.light)
        .onTapGesture {
        UIApplication.shared.stopEditing()
            
            
        }.navigationBarHidden(true)
        }
    }
    
    func toggle() {
        showRequest.toggle()
    }
    
    
    
    
}

extension UIApplication {
    func stopEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
