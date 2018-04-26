//
//  vcViewController.swift
//  TwitProj
//
//  Created by Zhekon on 26.04.2018.
//  Copyright © 2018 Yacir. All rights reserved.
//

import UIKit
import TwitterKit
class vcViewController: TWTRTimelineViewController, TWTRComposerViewControllerDelegate {
    
    @IBOutlet var imgTweet: UIImageView!
    @IBOutlet var tvTweet: UITextView!
    
    
    @IBOutlet weak var segOutlet: UISegmentedControl!
    @IBAction func segmentController(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: myTweet()
        case 1: myNews()
   
        default:
            break
        }
        
    }
    func myTweet(){
        let client = TWTRAPIClient()
        self.dataSource = TWTRUserTimelineDataSource(screenName: "kovalevskijevg1", apiClient: client)
    }
      func myNews(){
        let client = TWTRAPIClient()
        self.dataSource = TWTRListTimelineDataSource(listSlug: "surfing", listOwnerScreenName: "stevenhepting", apiClient: client)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    myTweet()
    }
   
    //LogOut
    @IBAction func exitButton(_ sender: UIBarButtonItem) {
        let store = TWTRTwitter.sharedInstance().sessionStore
        if let userID = store.session()?.userID {
            store.logOutUserID(userID)
        }
    }
        
    @IBAction func btnTwitterSharePressed(_ sender: UIBarButtonItem) {
        if (TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers()) {
            guard let shareImg2 = UIImage.init(named: "luxfon.com_11639") else{
                return
            }
            let composer = TWTRComposerViewController.init(initialText: "Картинка для красоты в твитт :)", image: shareImg2, videoURL: nil)
            composer.delegate = self
            present(composer, animated: true, completion: nil)
            
        } else {
            // Log in, and then check again
            TWTRTwitter.sharedInstance().logIn { session, error in
                if session != nil { // Log in succeeded
                    guard let shareImg2 = UIImage.init(named: "luxfon.com_11639") else{
                        return
                    }
                    let composer = TWTRComposerViewController.init(initialText: "Картинка для красоты в твитт :)", image: shareImg2, videoURL: nil)
                    composer.delegate = self
                    self.present(composer, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "No Twitter Accounts Available", message: "You must log in before presenting a composer.", preferredStyle: .alert)
                    self.present(alert, animated: false, completion: nil)
                }
            }
        }
    }

    //MARK:- TWTRComposerViewControllerDelegate
        func composerDidCancel(_ controller: TWTRComposerViewController) {
        print("composerDidCancel, composer cancelled tweet")
    }
        func composerDidSucceed(_ controller: TWTRComposerViewController, with tweet: TWTRTweet) {
        print("composerDidSucceed tweet published")
    }
    func composerDidFail(_ controller: TWTRComposerViewController, withError error: Error) {
        print("composerDidFail, tweet publish failed == \(error.localizedDescription)")
    }

}
