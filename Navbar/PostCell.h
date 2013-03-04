//
//  PostCell.h
//  Navbar
//
//  Created by Jake Scott on 4/03/13.
//  Copyright (c) 2013 superlogical. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@interface PostCell : PFTableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *urlLabel;
@property (nonatomic, weak) IBOutlet UIImageView *twitterImageView;

- (void)configureForPost:(PFObject *)post;

@end
