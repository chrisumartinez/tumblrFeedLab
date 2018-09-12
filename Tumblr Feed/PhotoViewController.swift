//
//  PhotoViewController.swift
//  Tumblr Feed
//
//  Created by Chris Martinez on 9/7/18.
//

import UIKit
import AlamofireImage


class PhotoViewController: UIViewController, UITableViewDataSource{

    var posts: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.dataSource = self
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector (PhotoViewController.didPullToRefresh(_:)), for: .valueChanged)
        fetchPosts()
        tableView.insertSubview(refreshControl, at: 0)
        
    }
        
        
        func fetchPosts(){
            // Network request snippet
            let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else if let data = data,
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print(dataDictionary)
                    // Get the dictionary from the response key
                    let responseDictionary = dataDictionary["response"] as! [String: Any]
                    // Store the returned array of dictionaries in our posts property
                    self.posts = responseDictionary["posts"] as! [[String: Any]]
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                    
                    // TODO: Reload the table view
                }
            }
            task.resume()
            
        }
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchPosts()
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return posts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
            let post = posts[indexPath.row]
            if post["type"] as! String  == "photo"{
                let altSize = post["alt_sizes"] as! [String: Any]
                let url = altSize["url"] as! String
                let photoURL = URL(string: url)
                cell.photoImageView.af_setImage(withURL: photoURL!)
            }
            
            
            return cell
        }
    }
