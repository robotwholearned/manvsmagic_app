//
//  DetailViewController.swift
//  manvsmagic
//
//  Created by Sandquist, Cassandra G on 8/16/14.
//  Copyright (c) 2014 robotwholearned. All rights reserved.
/* Feed Item Properties:
//    Title
//    Link
//    Author name
//    Date (the date the item was published)
//    Updated date (the date the item was updated, if available)
//    Summary (brief description of item)
//    Content (detailed item content, if available)
//    Enclosures (i.e. podcasts, mp3, pdf, etc)
//    Identifier (an item's guid/id)
*/
//

import UIKit

class DetailViewController: UIViewController {
  
  //@IBOutlet weak var detailDescriptionLabel: UITextView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var linkLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var lastUpdatedLabel: UILabel!
  @IBOutlet weak var summaryLabel: UILabel!
  @IBOutlet weak var contentLabel: UILabel!
  @IBOutlet weak var enclosuresLabel: UILabel!
  @IBOutlet weak var identifierLabel: UILabel!
  @IBOutlet weak var scrollView: UIScrollView!
  
  
  
  var detailItem: AnyObject? {
    didSet {
      // Update the view.
      self.configureView()
    }
  }
  
  func configureView() {
    // Update the user interface for the detail item.
    
    if let detail: AnyObject = self.detailItem as? MWFeedItem {
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: Selector("openInBrowser"))
      
      if let title = self.titleLabel {
        title.text = title.text + detail.title!
      }
      if let link = self.linkLabel {
        link.text = link.text + detail.link!
      }
      if let author = self.authorLabel {
        author.text = detail.author?
      }
      if let dateLabel = self.dateLabel {
        let date = detail.date as NSDate
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        var stringValue = formatter.stringFromDate(date)
        
        dateLabel.text = stringValue?
      }
      if let updateLabel = self.lastUpdatedLabel {
        let date = detail.updated as NSDate
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        var stringValue = formatter.stringFromDate(date)
        
        updateLabel.text = stringValue?
      }
      if let summary = self.summaryLabel {
        summary.text = detail.summary?
      }
      if let contentLabel = self.contentLabel {
          contentLabel.text = detail.content?
      }
      
      println(detail.enclosures?)
      
      if let label = self.identifierLabel{
        label.text = detail.identifier?
      }
    }
    if let scrollView = self.scrollView {
      scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 758.0)//self.view.frame.size.height)
      println(scrollView.contentSize)
    }
  }
  
  func openInBrowser(){
    if let detail: AnyObject = self.detailItem as? MWFeedItem {
      println(detail.link)
      var link = NSURL.URLWithString(detail.link)
      if (UIApplication.sharedApplication().canOpenURL(link)){
        UIApplication.sharedApplication().openURL(link)
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.configureView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

