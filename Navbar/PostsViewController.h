//
//  ViewController.h
//  Navbar
//
//  Created by Jake Scott on 2/03/13.
//  Copyright (c) 2013 superlogical. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@interface PostsViewController : PFQueryTableViewController

@property (nonatomic, strong) NSDate *date;

@end
