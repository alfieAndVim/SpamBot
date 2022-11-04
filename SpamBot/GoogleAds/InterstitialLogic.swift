//
//  InterstitialLogic.swift
//  SpamBot
//
//  Created by Alfie Dew on 04/08/2021.
//

import Foundation
import GoogleMobileAds

class InterstitialLogic {
    
    var interstitial: Interstitial
    
    init() {
        interstitial = Interstitial()
    }
    
    
    func prepareAdvert() {
        interstitial.LoadInterstitual()
    }
    
    func showAdvert() {
        interstitial.showAd()
        interstitial.LoadInterstitual()
    }
}





final class Interstitial: NSObject, GADFullScreenContentDelegate {
    
    
    var interstitial: GADInterstitialAd?
    
    
    override init() {
        super.init()
        LoadInterstitual()
    }
    
    func LoadInterstitual() {
        
        let request = GADRequest()
        
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-3940256099942544/4411468910", request: request) { [self] ad, error in
            if let error = error {
                print(error)
                return
            }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
        }
    }
    
    
    func showAd(){
        if let ad = interstitial {
            let root = UIApplication.shared.windows.first?.rootViewController
            ad.present(fromRootViewController: root!)
        }
        else {
            print("Not ready")
        }
    }
    
    
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
    }

    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad failed to present full screen content with error \(error.localizedDescription).")
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        self.LoadInterstitual()
        
    }
}



