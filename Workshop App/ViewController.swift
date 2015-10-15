//
//  ViewController.swift
//  Workshop App
//
//  Created by Adrian Stabiszewski on 15.10.15.
//  Copyright © 2015 GrundID GmbH. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var images:[Dictionary<String, AnyObject>]?

    override func viewDidLoad() {
        super.viewDidLoad()

        let fileName = NSBundle.mainBundle().pathForResource("data", ofType: "json")!
        let jsonData = NSData(contentsOfFile: fileName)

        do {
            images =  try NSJSONSerialization.JSONObjectWithData(jsonData!, options: []) as? [Dictionary<String, AnyObject>]
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ImageViewCell = tableView.dequeueReusableCellWithIdentifier("imageCell") as! ImageViewCell
        let imageData = images![indexPath.row]

        cell.title.text = imageData["title"] as? String
        cell.treeImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: (imageData["image"] as? String)!)!)!)
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images!.count
    }


}

