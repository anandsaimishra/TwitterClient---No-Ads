//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Anand Sai Mishra on 9/26/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    @IBOutlet var ProfileImageView: UIImageView!
    @IBOutlet var ProfileName: UILabel!
    @IBOutlet var TweetContent: UILabel!
    @IBOutlet var ReTweetButton: UIButton!
    @IBOutlet var FavButton: UIButton!
    
    @IBAction func favTweet(_ sender: Any) {
        let toBeFav = !favourited
        if (toBeFav){
            TwitterAPICaller.client?.favTweets(tweetID: tweetID, success: {
                self.setFav(true)
            }, failure: { (error) in
                print("Favourite setting doesnt work!!!; \(error)")
            })
        } else {
            TwitterAPICaller.client?.UnfavTweets(tweetID: tweetID, success: {
                self.setFav(false)
            }, failure: { (error) in
                print("UnFavourite doesn't Work !!!; \(error)")
            })
        }
        
    }
    @IBAction func reTweet(_ sender: Any) {
        TwitterAPICaller.client?.reTweet(tweetID: tweetID, success: {
            self.setRetweeted(true)
        }, failure: { (error) in print("retweet not working !!!!") })
        }
        
    
    var favourited:Bool = false
    var tweetID:Int = -1 //So we know it is not set.
    
    
    
    func setFav(_ isFav:Bool){
        favourited = isFav
        if (favourited) {
            FavButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            FavButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool){
        if (isRetweeted){
            ReTweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            ReTweetButton.isEnabled = false
        } else {
            ReTweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            ReTweetButton.isEnabled = true
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
