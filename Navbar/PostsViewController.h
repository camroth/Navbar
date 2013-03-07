//
//  ViewController.h
//  Navbar
//
//  Created by Jake Scott on 2/03/13.
//  Copyright (c) 2013 superlogical. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import "Parse/Parse.h"
#import "NSDate+Calculations.h"
#import "Reachability.h"
#import "PostCell.h"
#import "PostNoDataCell.h"
#import "PostHeaderCell.h"
#import "UIColor+ImageFromColor.h"
#import "OpenInChromeController.h"

@interface PostsViewController : PFQueryTableViewController

@property (nonatomic, strong) NSDate *date;

@end
