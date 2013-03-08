//
//  AppDelegate.h
//  Navbar
//
//  Created by Jake Scott on 2/03/13.
//  Copyright (c) 2013 superlogical. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "PostsViewController.h"
#import "NSDate+Calculations.h"
#import "Reachability.h"
#import "UIColor+ImageFromColor.h"
#import "OpenInChromeController.h"
#import "Settings.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) IBOutlet UIWindow *window;

@property (nonatomic, strong) UINavigationController *navController;

@property (nonatomic, readonly) int networkStatus;


- (BOOL)isParseReachable;

@end
