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
#import "PostNoDataCell.h"
#import "PostHeaderCell.h"
#import "UIColor+ImageFromColor.h"

static NSString *PostCellIdentifier = @"PostCell";
static NSString *PostNoDataCellIdentifier = @"PostNoDataCell";
static NSString *PostHeaderCellIdentifier = @"PostHeaderCell";

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
        self.loadingViewEnabled = NO;
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
    
    cellNib = [UINib nibWithNibName:PostNoDataCellIdentifier bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:PostNoDataCellIdentifier];
    
    cellNib = [UINib nibWithNibName:PostHeaderCellIdentifier bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:PostHeaderCellIdentifier];

    [self setTitle:@"NAVBAR"]; // we gonna use a background image!
    
    // Remove table cell separator
    [self.tableView setSeparatorColor:[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0]];
    
    self.navigationItem.leftBarButtonItem = [self addButtonWithImageNamed:@"arrow_left" withAction:@selector(navigateYesterday) adjustX:-6.0f];
    self.navigationItem.rightBarButtonItem = [self addButtonWithImageNamed:@"arrow_right" withAction:@selector(navigateTomorrow) adjustX:6.0f];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    self.parentViewController.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
}

- (UIBarButtonItem *)addButtonWithImageNamed:(NSString *)imageName withAction:(SEL)action adjustX:(CGFloat)x
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(x, 0.0, 44, 44);

    UIImage *image = [UIImage imageNamed:imageName];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    
    [button setBackgroundImage:[[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3f]imageFromColor] forState:UIControlStateHighlighted]; // alpha trick
    [button setBackgroundImage:[[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1f]imageFromColor] forState:UIControlStateNormal];
    
    //[button setBackgroundImage:[[UIColor colorWithRed:230/255.0f green:108/255.0f blue:105/255.0f alpha:1.0f]imageFromColor] forState:UIControlStateNormal];
    
    
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, button.frame.size.width, button.frame.size.height)];
    [buttonView addSubview:button];
    
    return [[UIBarButtonItem alloc] initWithCustomView:buttonView];
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
        PostHeaderCell *cell = (PostHeaderCell *)[tableView dequeueReusableCellWithIdentifier: PostHeaderCellIdentifier];
        [cell configureForDate:self.date];
        return cell;
    }
    
    return [tableView dequeueReusableCellWithIdentifier: PostNoDataCellIdentifier];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (section == 0) ? 44 : 88;
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
