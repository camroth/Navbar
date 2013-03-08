//
//  SharingViewController.h
//  Navbar
//
//  Created by Jake Scott on 8/03/13.
//  Copyright (c) 2013 superlogical. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <QuartzCore/QuartzCore.h>
#import "Parse/Parse.h"
#import "OpenInChromeController.h"
#import "GradientView.h"

@interface SharingViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, strong) PFObject *post;

-(void)presentInRootViewController;
-(void)dismissFromParentViewController;

@end
