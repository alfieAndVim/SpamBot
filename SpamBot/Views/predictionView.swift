//
//  predictionView.swift
//  SpamBot
//
//  Created by Alfie Dew on 03/08/2021.
//

import SwiftUI

struct predictionView: View {
    
    @Binding var truePredictionBin: String
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: UIScreen.main.bounds.width * 0.365, height: UIScreen.main.bounds.height / 5)
                .foregroundColor(Color.white)
                .cornerRadius(20)
                .shadow(radius: 20, x:-10, y:0)
            
            Text(truePredictionBin)
                .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
        }
    }
}

struct predictionView_Previews: PreviewProvider {
    static var previews: some View {
        predictionView(truePredictionBin: Binding.constant("Start typing..."))
    }
}
