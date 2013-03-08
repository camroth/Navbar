//
//  SharingViewController.m
//  Navbar
//
//  Created by Jake Scott on 8/03/13.
//  Copyright (c) 2013 superlogical. All rights reserved.
//

#import "SharingViewController.h"
#import "UIColor+ImageFromColor.h"

@interface SharingViewController () {
    OpenInChromeController *chromeController;
}

@property (weak, nonatomic) IBOutlet UIButton *shareTwitter;
@property (weak, nonatomic) IBOutlet UIButton *openBrowser;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

- (IBAction)share:(id)sender;
- (IBAction)open:(id)sender;
- (IBAction)close:(id)sender;

@end

@implementation SharingViewController {
    GradientView *gradientView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.backgroundView.backgroundColor = [UIColor colorWithRed:35/255.0f green:35/255.0f blue:35/255.0f alpha:1];
    
    UIImage *closeBackground = [[UIColor colorWithRed:230/255.0f green:108/255.0f blue:105/255.0f alpha:1] imageFromColor];
    UIImage *shareTwitterBackground = [[UIColor colorWithRed:91/255.0f green:154/255.0f blue:169/255.0f alpha:1] imageFromColor];
    UIImage *openBrowserBackground = [[UIColor colorWithRed:107/255.0f green:91/255.0f blue:140/255.0f alpha:1] imageFromColor];
    
    [self.shareTwitter setBackgroundImage:shareTwitterBackground forState:UIControlStateNormal];
    [self.openBrowser setBackgroundImage:openBrowserBackground forState:UIControlStateNormal];
    [self.closeButton setBackgroundImage:closeBackground forState:UIControlStateNormal];
    
    UIFont *font = [UIFont fontWithName:@"Montserrat-Bold" size:15];
    
    self.shareTwitter.titleLabel.font = font;
    self.openBrowser.titleLabel.font = font;
    self.closeButton.titleLabel.font = font;
    self.tipLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:12];
    
    chromeController = [[OpenInChromeController alloc]init];

    NSString *title;
    if ([chromeController isChromeInstalled] && [self openInChromeUserSetting]) {
        title = @"OPEN IN CHROME";
    } else {
        title = @"OPEN IN SAFARI";
    }
    
    [self.openBrowser setTitle:title forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)presentInRootViewController
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    
    gradientView = [[GradientView alloc] initWithFrame:rootViewController.view.bounds];
    [rootViewController.view addSubview:gradientView];
    
    self.view.frame = rootViewController.view.bounds;
    
    [rootViewController.view addSubview:self.view];
    [rootViewController addChildViewController:self];

    CGFloat x =  CGRectGetMidX(rootViewController.view.bounds);
    CGFloat y = CGRectGetMidY(rootViewController.view.bounds);
    x = x - ceilf(self.backgroundView.frame.size.width / 2.0f);
    y = y - ceilf(self.backgroundView.frame.size.height / 2.0f);
    
    self.backgroundView.frame = CGRectMake(x, y, self.backgroundView.frame.size.width, self.backgroundView.frame.size.height);
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    bounceAnimation.duration = 0.4;
    bounceAnimation.delegate = self;
    
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.7f],
                              [NSNumber numberWithFloat:1.2f],
                              [NSNumber numberWithFloat:0.9f],
                              [NSNumber numberWithFloat:1.0f],
                              nil];
    
    bounceAnimation.keyTimes = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:0.0f],
                                [NSNumber numberWithFloat:0.334f],
                                [NSNumber numberWithFloat:0.666f],
                                [NSNumber numberWithFloat:1.0f],
                                nil];
    
    bounceAnimation.timingFunctions = [NSArray arrayWithObjects:
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                       nil];
    
    [self.view.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];
    
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    fadeAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    fadeAnimation.duration = 0.1;
    
    [gradientView.layer addAnimation:fadeAnimation forKey:@"fadeAnimation"];
}

-(CGRect)statusBarFrameViewRect:(UIView*)view
{
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGRect statusBarWindowRect = [view.window convertRect:statusBarFrame fromWindow: nil];
    CGRect statusBarViewRect = [view convertRect:statusBarWindowRect fromView: nil];
    return statusBarViewRect;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self didMoveToParentViewController:self.parentViewController];
}

-(void)dismissFromParentViewController
{
    [self willMoveToParentViewController:nil];
    
    [UIView animateWithDuration:0.4 animations:^{
         CGRect rect = self.view.bounds;
         rect.origin.y += rect.size.height;
         self.view.frame = rect;
         gradientView.alpha = 0.0f;
     } completion:^(BOOL finished) {
         [self.view removeFromSuperview];
         [gradientView removeFromSuperview];
         [self removeFromParentViewController];
     }];
}

- (IBAction)share:(id)sender
{
    TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
    
    NSString *title = [self.post objectForKey:@"title"];
    NSString *url = [self.post objectForKey:@"url"];

    NSString *twitter = [self.post objectForKey:@"twitter"];    
    if (twitter && twitter.length > 0) {
        twitter = [NSString stringWithFormat:@"via @%@", twitter];
    }
    
    NSString* tweetText = [NSString stringWithFormat:@"%@ %@ %@", title, url, twitter];
    
    [tweetViewController setInitialText:tweetText];
    
    [tweetViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
        
        switch (result) {
            case TWTweetComposeViewControllerResultCancelled:
                NSLog(@"Tweet was cancelled");
                break;
                
            case TWTweetComposeViewControllerResultDone:
                NSLog(@"Tweet was sent");
                break;
                
            default:
                break;
        }
        
        [self dismissModalViewControllerAnimated:YES];
    }];
    
    [self presentModalViewController:tweetViewController animated:YES];
}

- (IBAction)open:(id)sender
{
    NSString* url = [self.post objectForKey:@"url"];
    if (url && url.length > 0) {
        [self openURL:url];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Woops!"
                                  message:@"Looks like this post is missing it's URL and I am unable to open it."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (IBAction)close:(id)sender
{
    [self dismissFromParentViewController];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self dismissFromParentViewController];
}

- (void)openURL:(NSString *)url
{
    NSURL *nsUrl = [NSURL URLWithString:url];
    if ([chromeController isChromeInstalled] && [self openInChromeUserSetting]) {
        [chromeController openInChrome:nsUrl withCallbackURL:nil createNewTab:YES];
        return;
    } else {
        [[UIApplication sharedApplication] openURL:nsUrl];
    }
}

- (BOOL)openInChromeUserSetting
{
    NSString *useChromeSetting = [[NSUserDefaults standardUserDefaults] stringForKey:@"OpenLinksInChrome"];
    
    if (!useChromeSetting)
        return NO;
    
    BOOL result = [useChromeSetting isEqualToString:@"1"]  ? YES : NO;
    return result;
}

- (void)dealloc
{
    NSLog(@"dealloc %@", self);
}

- (void)viewDidUnload {
    [self setCloseButton:nil];
    [self setBackgroundView:nil];
    [self setTipLabel:nil];
    [super viewDidUnload];
}
@end
