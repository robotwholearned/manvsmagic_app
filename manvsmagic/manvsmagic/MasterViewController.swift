//
//  MasterViewController.swift
//  manvsmagic
//
//  Created by Sandquist, Cassandra G on 8/16/14.
//  Copyright (c) 2014 robotwholearned. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, MWFeedParserDelegate{
  
  var detailViewController: DetailViewController? = nil
  var objects = NSMutableArray()
  var items = [MWFeedItem]()
  
  
  func request() {
    let URL = NSURL(string: "http://www.manvsmagic.com/feed.xml")
    let feedParser = MWFeedParser(feedURL: URL);
    feedParser.delegate = self
    feedParser.parse()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    request()
  }
  
  func feedParserDidStart(parser: MWFeedParser) {
    SVProgressHUD.show()
    self.items = [MWFeedItem]()
  }
  func feedParserDidFinish(parser: MWFeedParser) {
    SVProgressHUD.dismiss()
    self.tableView.reloadData()
  }
  func feedParser(parser: MWFeedParser, didParseFeedInfo info: MWFeedInfo) {
    println(info)
    self.title = info.title
  }
  func feedParser(parser: MWFeedParser, didParseFeedItem item: MWFeedItem) {
    println(item)
    self.items.append(item)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
      self.clearsSelectionOnViewWillAppear = false
      self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.insertNewObject(NSNull)
    self.insertNewObject(NSNull)
    
    if let split = self.splitViewController {
      let controllers = split.viewControllers
      self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func insertNewObject(sender: AnyObject) {
    if objects == nil {
      objects = NSMutableArray()
    }
    objects.insertObject(NSDate.date(), atIndex: 0)
    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
    self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
  }
  
  // MARK: - Segues
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
      let indexPath = self.tableView.indexPathForSelectedRow()
      let item = self.items[indexPath.row] as MWFeedItem
      let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
      controller.detailItem = item
      controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem()
      controller.navigationItem.leftItemsSupplementBackButton = true
    }
  }
  
  // MARK: - Table View
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
    self.configureCell(cell, atIndexPath: indexPath)
    return cell
  }
  
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return false
  }
  
  func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
    let item = self.items[indexPath.row] as MWFeedItem
    cell.textLabel.text = item.title
    cell.textLabel.font = UIFont.systemFontOfSize(14.0)
    cell.textLabel.numberOfLines = 0
    
//    let projectURL = item.link.componentsSeparatedByString("?")[0]
//    let imgURL: NSURL = NSURL(string: projectURL + "/cover_image?style=200x200#")
//    cell.imageView.contentMode = UIViewContentMode.ScaleAspectFit
//    cell.imageView.setImageWithURL(imgURL, placeholderImage: UIImage(named: "logo.png"))
  }
  
  
}

