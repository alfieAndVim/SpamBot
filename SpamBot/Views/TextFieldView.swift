//
//  TextFieldView.swift
//  SpamBot
//
//  Created by Alfie Dew on 03/08/2021.
//

import SwiftUI

struct TextFieldView: View {
    
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertShow = false
    
    @Binding var entryTextBin: String
    @Binding var probabilityBin: Double
    @Binding var probabilityStrBin: String
    @Binding var truePredictionBin: String
    
    
    let logic = modelLogic()
    
    var body: some View {
        ZStack {
            
           Rectangle()
                .frame(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.height / 3)
                .foregroundColor(Color.white)
                .cornerRadius(20)
            .shadow(radius: 20, x: 0, y: 10)
                .animation(.easeIn)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(entryTextBin != "" ? Color.blue : Color.clear)
                    .animation(.easeInOut)
            )
                .overlay(
                    VStack {
                    
                        Button(action: clearText) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor((entryTextBin == "" ? .clear : .gray))
                            .background(Color.clear)
                            
                    }.padding(.leading, UIScreen.main.bounds.width / 1.7)
                        .padding(.top, 10)
                        .animation(.easeIn)
                    
                    TextEditor(text: $entryTextBin)
                                .onChange(of: entryTextBin, perform: { newValue in
                                    classifyText()
                    })
                        
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                            .foregroundColor(Color.black)
                        
                        
                        Button(action: pasteText) {
                            Image(systemName: "doc.on.clipboard.fill")
                                .foregroundColor(.gray)
                                .background(Color.white)
                        }.padding(.leading, UIScreen.main.bounds.width / 1.7)
                        .padding(.bottom, 10)
                        
                    
                })
        }.padding(.bottom, 30)
    }
    
    func clearText() {
        entryTextBin = ""
    }
    
    func classifyText(){
        
        
        let prediction = logic.getPrediction(text: entryTextBin.lowercased())
        
        if (prediction.message == nil) {
            let actualPrediction = logic.getTruePrediction(prediction: prediction.output!)
            var actualProbability = logic.getTrueProbability(prediction: prediction.output!)
            
            if entryTextBin == ""{
                truePredictionBin = "Start typing.."
                probabilityBin = 0
                probabilityStrBin = "0%"
            }else{
                truePredictionBin = actualPrediction
                probabilityBin = actualProbability
                actualProbability = floor(actualProbability * 100)
                let strActualProbability = String(format: "%.0f", actualProbability)
                probabilityStrBin = ("\(strActualProbability)%")
            }
            
        }else {
            alertTitle = "Error"
            alertMessage = "There has been a problem"
            alertShow = true
        }
        
        
    }
    
    
    func pasteText() {
        let pasteboard = UIPasteboard.general.string
        entryTextBin = pasteboard ?? ""
    }
}

struct clearView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(entryTextBin: Binding.constant(""), probabilityBin: Binding.constant(0.0), probabilityStrBin: Binding.constant(""), truePredictionBin: Binding.constant(""))
    }
}
