//
//  PostHeaderCell.h
//  Navbar
//
//  Created by Jake Scott on 4/03/13.
//  Copyright (c) 2013 superlogical. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@interface PostHeaderCell : PFTableViewCell

@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

-(void)configureForDate:(NSDate *)date;

@end
