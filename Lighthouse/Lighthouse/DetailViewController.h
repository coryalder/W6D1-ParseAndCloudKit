//
//  DetailViewController.h
//  Lighthouse
//
//  Created by Cory Alder on 2015-07-13.
//  Copyright (c) 2015 Cory Alder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

