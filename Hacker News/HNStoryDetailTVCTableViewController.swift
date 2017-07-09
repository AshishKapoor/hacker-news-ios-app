//
//  HNStoryDetailTVCTableViewController.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 09/07/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import UIKit
import GoogleMobileAds
import RFAboutView_Swift

class HNStoryDetailTVC: UITableViewController, GADBannerViewDelegate {

    var type = String()
    var by = String()
    var time = String()
    var url = String()
    var score = Int()
    var tit = String()
    var id = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = type
        
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        setupAdMob()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-info"),
                                                                 style: UIBarButtonItemStyle.plain ,
                                                                 target: self, action: #selector(HNStoryDetailTVC.gotSettingPage(_:)))
        tableView.tableFooterView = UIView()
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
        requestGAD.testDevices = [kGADSimulatorID]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 7
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Title"
        case 1:
            return "By"
        case 2:
            return "Time"
        case 3:
            return "Score"
        case 4:
            return "Id"
        case 5:
            return "Url"
        case 6:
            return "Ads"
        default:
            return "Other Devicesode"
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HNStoryDetailTVCell else {return UITableViewCell()}

        switch indexPath.section {
        case 0:
            cell.textLabel!.text = tit
            cell.googleBannerAd.isHidden = true
            cell.imageView?.image = UIImage(named: "icons8-title")
        case 1:
            cell.textLabel!.text = by
            cell.googleBannerAd.isHidden = true
            cell.imageView?.image = UIImage(named: "icons8-author")
        case 2:
            cell.textLabel!.text = time
            cell.googleBannerAd.isHidden = true
            cell.imageView?.image = UIImage(named: "icons8-time")
        case 3:
            cell.textLabel!.text = String(score)
            cell.googleBannerAd.isHidden = true
            cell.imageView?.image = UIImage(named: "icons8-score")
        case 4:
            cell.textLabel!.text = id
            cell.googleBannerAd.isHidden = true
            cell.imageView?.image = UIImage(named: "icons8-hacker_news")
        case 5:
            cell.googleBannerAd.isHidden = true
            cell.textLabel?.text = url
            cell.imageView?.image = UIImage(named: "icons8-globe_earth")
        case 6:
            cell.textLabel!.isHidden = true
            cell.googleBannerAd.adUnitID = "ca-app-pub-1816315233369355/6269688021"
            cell.googleBannerAd.delegate = self
            cell.googleBannerAd.rootViewController = self
            cell.googleBannerAd.load(GADRequest())
        default:
            cell.textLabel!.text = ""
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 5  {
            if indexPath.row == 0 {
                UIApplication.shared.openURL(URL(string: self.url)!)
            }
        }
    }
}
