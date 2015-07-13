//
//  Event.m
//  Lighthouse
//
//  Created by Cory Alder on 2015-07-13.
//  Copyright (c) 2015 Cory Alder. All rights reserved.
//

#import "Event.h"

@implementation Event

@dynamic date;
@dynamic count;

@dynamic installation;

+(NSString * __nonnull)parseClassName {
    return @"Event";
}


+(void)load {
    [self registerSubclass];
}



@end
