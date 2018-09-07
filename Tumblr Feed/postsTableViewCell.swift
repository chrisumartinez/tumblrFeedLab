//
//  postsTableViewCell.swift
//  Tumblr Feed
//
//  Created by Chris Martinez on 9/7/18.
//

import UIKit

class postsTableViewCell: UITableViewCell {
    
    
    class 

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as! postCell
        
        // Configure YourCustomCell using the outlets that you've defined.
        
        return cell
    }

}
