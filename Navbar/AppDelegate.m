//
//  AppDelegate.m
//  Navbar
//
//  Created by Jake Scott on 2/03/13.
//  Copyright (c) 2013 superlogical. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"8NPPjp3T2LEek91NIVKiqega9R0wkmuZjhPL30w8" clientKey:@"mO26FqdsGL7ZE5BJpgY7SL4uUfm5XihRK75oppuo"];

//    NSString *twitter = @"SachaGreif";
//    NSString *title = @"Free Font: Hello Denver";
//    NSString *url = @"http://www.hellodenver.org/";
//    NSDate *today = [NSdate date];
//
//    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
//    [dateComponents setDay:-1];
//
//    NSDate *yesterday = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:today options:0];
//    
//    NSLog(@"Today %@ Yesterday %@", date, yesterday);
//    
//    PFObject *post = [PFObject objectWithClassName:@"Post"];
//    [post setObject:twitter forKey:@"twitter"];
//    [post setObject:url forKey:@"url"];
//    [post setObject:title forKey:@"title"];
//    [post setObject:yesterday forKey:@"date"];
//
//    [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error){
//            NSLog(@"Saved post: %@", post);
//        } else {
//            NSLog(@"Save failed with error %@", error);
//        }
//    }];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
