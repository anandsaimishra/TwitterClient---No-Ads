//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Anand Sai Mishra on 9/26/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    let APIURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
    
    let lemonade = UIRefreshControl() //Coz Lemonade is refreshing
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pullTweets()
        
        lemonade.addTarget(self, action: #selector(pullTweets), for: .valueChanged)
        tableView.refreshControl = lemonade
        
    }

    
    @objc func pullTweets(){
        numberOfTweets = 20
        let Parameters = ["count": numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: APIURL, parameters: Parameters as [String : Any], success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            self.lemonade.endRefreshing()
        }, failure: { (Error) in
            print("Could Not retreive Tweets")
        })
    }
    
    func loadMoreTweets(){
        numberOfTweets += 20
        let parameters = ["count": numberOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: APIURL, parameters: parameters as [String : Any], success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
        }, failure: { (Error) in
            print("Could Not retreive Tweets")
        })
            

    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets()
        }
    }
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetArray.count
    }
    
//Cells
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCellTableViewCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        cell.ProfileName.text = user["name"] as? String
        cell.TweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.ProfileImageView.image = UIImage(data: imageData)
        }
        
        
        
        return cell
    }
    
    
//    LOGOUT Button
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "UserLoggedIn")
    }
    

}
