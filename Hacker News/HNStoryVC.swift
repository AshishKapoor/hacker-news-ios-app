//
//  HNStoryVC.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 04/07/17.
//  Copyright © 2017 swiftobjc@gmail.com All rights reserved.
//

import UIKit
import GoogleMobileAds

class HNStoryVC: UIViewController, GADBannerViewDelegate {

    let googleAdBanner = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Story" // TODO: - Temp
//        view.backgroundColor = UIColor.white
        setupAdMob()
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Banner loaded successfully")
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("FAILED")
    }
    
    func setupAdMob() {
        requestGAD.testDevices = [kGADSimulatorID]
        googleAdBanner.adUnitID = "ca-app-pub-1816315233369355/6269688021"
        googleAdBanner.delegate = self
        googleAdBanner.rootViewController = self
        googleAdBanner.load(GADRequest())
    }
}
