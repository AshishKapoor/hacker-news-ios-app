//
//  HNStoryVC.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 04/07/17.
//  Copyright © 2017 swiftobjc@gmail.com All rights reserved.
//

import UIKit
import GoogleMobileAds
import RFAboutView_Swift

class HNStoryVC: UIViewController, GADBannerViewDelegate, UIWebViewDelegate {
    
    @IBOutlet weak var storyWV: UIWebView!
    @IBOutlet weak var storyAIV: UIActivityIndicatorView!
    @IBOutlet weak var googleAdBanner: GADBannerView!
    
    var storyUrl = URL(string: "https://www.google.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Story"
        setupAcitivityIndicatorView()
        setupWebView()
        setupAdMob()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-info"),
                                       style: UIBarButtonItemStyle.plain ,
                                       target: self, action: #selector(HNStoryVC.gotSettingPage(_:)))
    }
    
    func gotSettingPage(_ sender: UIBarButtonItem){
        UIApplication.shared.statusBarStyle = .default
        
        let aboutNav = UINavigationController()
        
        // Initialise the RFAboutView:
        let aboutView = RFAboutViewController(copyrightHolderName: "Ashish Kapoor", contactEmail: "swiftobjc@gmail.com", contactEmailTitle: "Contact me", websiteURL: NSURL(string: "https://ashishkapoor.github.io")! as URL, websiteURLTitle: "Developer's Website")
        
        // Set some additional options:
        aboutView.headerBackgroundColor = .black
        aboutView.headerTextColor = .white
        aboutView.blurStyle = .dark
        //        aboutView.headerBackgroundImage = UIImage(named: "blur.png")
        aboutView.headerBackgroundColor = UIColor.orange
        
        // Add an acknowledgement:
        
        aboutView.addAcknowledgement("SwiftyJSON", content: swiftyJSONCopyRight)
        aboutView.addAcknowledgement("HNClient", content: hnClientCopyRight)
        aboutView.addAcknowledgement("RFAboutView-Swift", content: rfAboutViewCopyright)
        aboutView.addAcknowledgement("TwitterKit", content: twitterCopyRight)
        aboutView.addAcknowledgement("PullToRefresher", content: pullToRefreshCopyRight)
        
        // Add the aboutView to the NavigationController:
        aboutNav.setViewControllers([aboutView], animated: false)
        
        // Present the navigation controller:
        self.present(aboutNav, animated: true, completion: nil)
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Banner loaded successfully")
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("Failed to Load Ad.")
    }
    
    func setupAdMob() {
//        requestGAD.testDevices = [kGADSimulatorID]
        googleAdBanner.adUnitID = "ca-app-pub-1816315233369355/6269688021"
        googleAdBanner.delegate = self
        googleAdBanner.rootViewController = self
        googleAdBanner.load(GADRequest())
    }
    
    func setupAcitivityIndicatorView () {
        storyAIV.hidesWhenStopped = true
    }
    
    func setupWebView () {
        storyWV.delegate = self
        guard let safeUrl = storyUrl else {return}
        storyWV.loadRequest(URLRequest(url: safeUrl))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        storyAIV.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        storyAIV.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        storyAIV.stopAnimating()
    }
    
}
