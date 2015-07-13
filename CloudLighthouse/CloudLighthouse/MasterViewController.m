//
//  MasterViewController.m
//  CloudLighthouse
//
//  Created by Cory Alder on 2015-07-13.
//  Copyright (c) 2015 Cory Alder. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import <CloudKit/CloudKit.h>

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.objects = [[NSMutableArray alloc] init];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    
    CKContainer *container = [CKContainer defaultContainer];
    
    CKDatabase *database = [container publicCloudDatabase];
    
    
    CKQuery *query = [[CKQuery alloc] initWithRecordType:@"Event" predicate:[NSPredicate predicateWithValue:@(YES)]];
    
    
    [database performQuery:query inZoneWithID:nil completionHandler:^(NSArray *results, NSError *error) {
       
        
        self.objects = [results mutableCopy];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
        
    }];
    
//    
//    CKSubscription *subscription = [[CKSubscription alloc] initWithRecordType:@"Event" predicate:[] options:(CKSubscriptionOptions)];
//    
//    subscription.
//    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    
    
    CKRecord *newEvent = [[CKRecord alloc] initWithRecordType:@"Event"];
    
    [newEvent setObject:[NSDate date] forKey:@"date"];
    newEvent[@"date"] = [NSDate date];
    [newEvent setObject:@(arc4random_uniform(100)) forKey:@"count"];
    
    CKContainer *container = [CKContainer defaultContainer];
    
    CKDatabase *database = [container publicCloudDatabase];
    
    [database saveRecord:newEvent completionHandler:^(CKRecord *record, NSError *error) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.objects insertObject:record atIndex:0];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        });

    }];
    
    
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    CKRecord *object = self.objects[indexPath.row];
    cell.textLabel.text = [[object objectForKey:@"date"] description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
