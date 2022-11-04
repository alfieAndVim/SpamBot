//
//  AdConsentView.swift
//  SpamBot
//
//  Created by Alfie Dew on 06/09/2021.
//

import SwiftUI
import UIKit
import UserMessagingPlatform
import GoogleMobileAds


final class AdConsentView: UIViewControllerRepresentable {
    
    
    @Binding var complete : Bool
    
    var viewController = UIViewController()
    
    init(complete: Binding<Bool>) {
        self._complete = complete
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        
        print("Started")
        UMPConsentInformation.sharedInstance.reset()
        
        let parameters = UMPRequestParameters()
        parameters.tagForUnderAgeOfConsent = false
        
        
        
        UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(with: parameters, completionHandler: {error in
            if error != nil {
                print(error ?? "An error has occured")
            } else {
                let formStatus = UMPConsentInformation.sharedInstance.formStatus
                if formStatus == UMPFormStatus.available {
                    self.loadForm()
                }
            }
        })
        
        
        return viewController
    }
    
    
    
    
    func loadForm() {
        UMPConsentForm.load { form, loadError in
            if loadError != nil {
                print(loadError ?? "An error has occured")
            } else {
                if UMPConsentInformation.sharedInstance.consentStatus == UMPConsentStatus.required {
                    form?.present(from: self.viewController, completionHandler: { dismissError in
                        if UMPConsentInformation.sharedInstance.consentStatus == UMPConsentStatus.obtained {
                            GADMobileAds.sharedInstance().start(completionHandler: nil)
                            self.complete = true
                            UserDefaults.standard.setValue(true, forKey: "permission")
                        }
                    })
                }
                
            }
        }
    }
    
}
