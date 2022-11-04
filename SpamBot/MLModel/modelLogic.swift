//
//  modelLogic.swift
//  SpamBot
//
//  Created by Alfie Dew on 03/08/2021.
//

import Foundation
import SwiftUI


class modelLogic {
    
    
    func getPrediction(text: String) -> (output: scam_modelOutput?, message: String?) {
        
        do {
            let model = try scam_model(configuration: .init())
            let prediction = try model.prediction(_1: self.bow(text: text))
            
            return (prediction, nil)
        } catch {
            return (nil, "Something went wrong")
        }
    }
    
    func getTruePrediction(prediction: scam_modelOutput) -> String {
        return prediction._0
    }
    
    func getTrueProbability(prediction: scam_modelOutput) -> Double {
        if prediction._0 == "spam" {
            return prediction._0Probability["spam"] ?? 0.0
        } else {
            return prediction._0Probability["legit"] ?? 0.0
        }
    }
    
    
    
    func bow(text: String) -> [String: Double] {
        var bagOfWords = [String: Double]()

        let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
        let range = NSRange(location: 0, length: text.utf16.count)
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]
        tagger.string = text.lowercased()

        tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType, options: options) { _, tokenRange, _ in
            let word = (text as NSString).substring(with: tokenRange)
            if bagOfWords[word] != nil {
                bagOfWords[word]! += 1
            } else {
                bagOfWords[word] = 1
            }
        }

        return bagOfWords
    }
    
}
