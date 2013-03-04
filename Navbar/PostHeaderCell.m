//
//  PostHeaderCell.m
//  Navbar
//
//  Created by Jake Scott on 4/03/13.
//  Copyright (c) 2013 superlogical. All rights reserved.
//

#import "PostHeaderCell.h"

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
   
    self.backgroundColor = [UIColor darkGrayColor];
    
    self.dateLabel.text = [formatter stringFromDate:date];
    
    self.dateLabel.font = [UIFont fontWithName:@"Montserrat-Bold" size:16];
    self.dateLabel.textColor = [UIColor whiteColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
