//
//  confidenceView.swift
//  SpamBot
//
//  Created by Alfie Dew on 03/08/2021.
//

import SwiftUI

struct confidenceView: View {
    
    @Binding var probabilityBin: Double
    @Binding var probabilityStrBin: String
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: UIScreen.main.bounds.width * 0.365, height: UIScreen.main.bounds.height / 5)
                .foregroundColor(Color.white)
                .cornerRadius(20)
                .shadow(radius: 20, x:10, y:0)
            
            Circle()
                .trim(from: 1 - CGFloat(probabilityBin), to:1)
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(90))
                .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
                .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
            .animation(.easeOut)
            
            Text(probabilityStrBin)
                .fontWeight(.bold)
        }
    }
}

struct confidenceView_Previews: PreviewProvider {
    static var previews: some View {
        confidenceView(probabilityBin: Binding.constant(0.0), probabilityStrBin: Binding.constant(""))
    }
}

