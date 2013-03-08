//
//  Setting.m
//  Navbar
//
//  Created by Jake Scott on 9/03/13.
//  Copyright (c) 2013 superlogical. All rights reserved.
//

#import "Settings.h"

@implementation Settings

@synthesize parseAppId = _parseAppId;
@synthesize parseClientKey = _parseClientKey;

- (id) init {
    self = [super init];
    if (self) {
        NSLog(@"Put your Parse keys here");
        self.parseAppId = @"";
        self.parseClientKey = @"";
    }
    return self;
}

@end
