//
//  PostNoDataCell.m
//  Navbar
//
//  Created by Jake Scott on 4/03/13.
//  Copyright (c) 2013 superlogical. All rights reserved.
//

#import "PostNoDataCell.h"


@implementation PostNoDataCell

@synthesize noDataLabel = _noDataLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[[UIColor whiteColor] imageFromColor]];
    
    self.noDataLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:14];
    self.noDataLabel.textColor = [UIColor lightGrayColor];
}

@end
