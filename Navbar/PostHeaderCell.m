//
//  PostHeaderCell.m
//  Navbar
//
//  Created by Jake Scott on 4/03/13.
//  Copyright (c) 2013 superlogical. All rights reserved.
//

#import "PostHeaderCell.h"
#import "UIColor+ImageFromColor.h"

@implementation PostHeaderCell

@synthesize dateLabel = _dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)configureForDate:(NSDate *) date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
   
    self.backgroundColor = [UIColor clearColor];
    
    self.dateLabel.text = [formatter stringFromDate:date];
    
    self.dateLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:16];
    self.dateLabel.textColor = [UIColor darkGrayColor];

    self.backgroundView = [[UIImageView alloc] initWithImage:[[UIColor colorWithRed:239/255.0f green:234/255.0f blue:232/255.0f alpha:1.0] imageFromColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
