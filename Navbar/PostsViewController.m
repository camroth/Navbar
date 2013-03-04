//
//  ViewController.m
//  Navbar
//
//  Created by Jake Scott on 2/03/13.
//  Copyright (c) 2013 superlogical. All rights reserved.
//

#import "PostsViewController.h"
#import "NSDate+Calculations.h"
#import "Reachability.h"
#import "Parse/Parse.h"
#import "PostCell.h"

static NSString *PostCellIdentifier = @"PostCell";

@interface PostsViewController () {

}

@end

@implementation PostsViewController

@synthesize date = _date;

- (id) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.className = @"Post";
        self.textKey = @"title";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 25;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    NSLog(@"Did recieve memory warning!!!!");
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:PostCellIdentifier bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:PostCellIdentifier];

    [self setTitle:@"Navbar"]; // we gonna use a background image!

    NSDictionary *styles = @{
        UITextAttributeTextColor: [UIColor whiteColor],
        UITextAttributeTextShadowColor : [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],
        UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetMake(0, 1)],
        UITextAttributeFont : [UIFont fontWithName:@"Montserrat-Regular" size:11.0]
    };
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:[self yesterdayLabelText] style:UIBarButtonItemStylePlain target:self action:@selector(navigateYesterday)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:[self tomorrowLabelText] style:UIBarButtonItemStylePlain target:self action:@selector(navigateTomorrow)];

    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:styles forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:styles forState:UIControlStateNormal];
}

- (void)navigateYesterday
{
    PostsViewController *yesterdaysPosts = [[PostsViewController alloc] init];
    yesterdaysPosts.date = [self.date yesterday];
    
    NSMutableArray *viewControllers =  [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [viewControllers insertObject:yesterdaysPosts atIndex:[viewControllers count]-1];
    [self.navigationController setViewControllers:viewControllers animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navigateTomorrow
{
    PostsViewController *tomorrowsPosts = [[PostsViewController alloc] init];
    tomorrowsPosts.date = [self.date tomorrow];
    [self.navigationController pushViewController:tomorrowsPosts animated:YES];
}

- (void)updateLabels
{
    self.navigationItem.leftBarButtonItem.title = [self yesterdayLabelText];
    self.navigationItem.rightBarButtonItem.title = [self tomorrowLabelText];
}

- (NSString *)todayLabelText
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    return [formatter stringFromDate:self.date];
}

- (NSString *)yesterdayLabelText
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM d"];
    return [formatter stringFromDate:[self.date yesterday]];
}

- (NSString *)tomorrowLabelText
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM d"];
    return [formatter stringFromDate:[self.date tomorrow]];
}

- (NSString *)noPostsLabelText
{
    return @"Sorry, no posts today yet. Why not check the previous day?";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - PFQueryTableViewController

- (void)objectsWillLoad
{
    [super objectsWillLoad];
    // This method is called before a PFQuery is fired to get more objects
}

- (void)objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];

    // This method is called every time objects are loaded from Parse via the PFQuery
    if (error) {
        NSLog(@"Could not load objects %@", error);
    }
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.className];

    [query whereKey:@"date" greaterThanOrEqualTo:[self.date beginningOfDay]];
    [query whereKey:@"date" lessThanOrEqualTo:[self.date endOfDay]];
    [query orderByDescending:@"date"];
    
    BOOL isParseReachable = (BOOL)[[UIApplication sharedApplication].delegate performSelector:@selector(isParseReachable)];
    if (!isParseReachable) {
        //NSLog(@"offline - cache only");
        query.cachePolicy = kPFCachePolicyCacheOnly;
    } else {
        if (self.objects.count == 0) {
            //NSLog(@"online - cache then network");
            query.cachePolicy = kPFCachePolicyCacheThenNetwork;
        }
    }
 
    return query;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return (self.objects.count == 0) ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.objects count];
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        
        label.text = [self todayLabelText];
        label.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:102/255.0f blue:0.0f alpha:1.0f];
        label.backgroundColor = [UIColor grayColor];

        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont fontWithName:@"Montserrat-Bold" size:16];
        label.textAlignment = UITextAlignmentCenter;
        
        return label;
    } else {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        
        label.text = [self noPostsLabelText];
        label.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:102/255.0f blue:0.0f alpha:1.0f];
        label.backgroundColor = [UIColor lightGrayColor];
        
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont fontWithName:@"Montserrat-Regular" size:10];
        label.textAlignment = UITextAlignmentCenter;

        return label;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    PostCell *cell = (PostCell *)[tableView dequeueReusableCellWithIdentifier:PostCellIdentifier];
    [cell configureForPost:object];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
