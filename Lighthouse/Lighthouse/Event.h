//
//  Event.h
//  Lighthouse
//
//  Created by Cory Alder on 2015-07-13.
//  Copyright (c) 2015 Cory Alder. All rights reserved.
//

#import <Parse/Parse.h>

@interface Event : PFObject <PFSubclassing>

@property (nonatomic, strong) NSDate *date;
@property (nonatomic) NSInteger count;

@property (nonatomic, strong) PFInstallation *installation;


@end
