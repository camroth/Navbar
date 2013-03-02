//
//  ViewController.m
//  Navbar
//
//  Created by Jake Scott on 2/03/13.
//  Copyright (c) 2013 superlogical. All rights reserved.
//

#import "ViewController.h"
#import "Parse/Parse.h"
#import "NSDate+Calculations.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setTimeStyle:NSDateFormatterFullStyle];
    NSDate *beginningOfDay = [[NSDate date] beginningOfDay];
    NSDate *endOfToday = [[NSDate date] endOfDay];
    NSLog(@"Beginning of today  %@", [formatter stringFromDate:beginningOfDay]);
    NSLog(@"End of today %@", [formatter stringFromDate:endOfToday]);
    
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"date" greaterThanOrEqualTo:[[NSDate date] beginningOfDay]];
    [query whereKey:@"date" lessThanOrEqualTo:[[NSDate date] endOfDay]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {           
            for (PFObject *post in objects) {
                NSLog(@"%@", [post objectForKey:@"title"]);
            }
            
        } else {
            NSLog(@"Query failed with error %@", error);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"Memory warning, me? Never!");
}

@end
