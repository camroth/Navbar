//
//  PostCell.m
//  Navbar
//
//  Created by Jake Scott on 4/03/13.
//  Copyright (c) 2013 superlogical. All rights reserved.
//

#import "PostCell.h"
#import "UIImageView+WebCache.h"
//#import <SDWebImage/UIImageView+WebCache.h>

@implementation PostCell

@synthesize titleLabel = _titleLabel;
@synthesize urlLabel = _urlLabel;
@synthesize twitterImageView = _twitterImageView;

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
    
    // self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TableCellGradient"]];
    // self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SelectedTableCellGradient"]];
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    self.titleLabel = nil;
    self.urlLabel = nil;
    
    [self.twitterImageView cancelCurrentImageLoad];
}

-(void)configureForPost:(PFObject *)post
{
    NSString *urlString = [post objectForKey:@"url"];
    if (urlString)
    {
        NSURL *url = [[NSURL alloc]initWithString:[post objectForKey:@"url"]];
        NSString *host = [url host];
        self.urlLabel.text = host;
    } else {
        self.urlLabel.text = @"No url, yikes!";
    }
    
    NSString *titleString = [post objectForKey:@"title"];
    self.titleLabel.text = titleString ? titleString : @"No title umm woops!";
    
    NSString *twitter = [post objectForKey:@"twitter"];
    if (twitter)
    {
        NSString *twitterUrlString = [NSString stringWithFormat:@"https://api.twitter.com/1/users/profile_image?screen_name=%@", twitter];
        NSURL *twitterUrl = [NSURL URLWithString:twitterUrlString];
        //[self.twitterImageView setImageWithURL:twitterUrl placeholderImage:[UIImage imageNamed:@"sachag"]];
        [self.twitterImageView setImageWithURL:twitterUrl];
    } else {
        // todo change placeholder to be the navbar logo
        //[self.twitterImageView setImage:[UIImage imageNamed:@"sachag"]];
    }
}

@end
