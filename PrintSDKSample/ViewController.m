//
//  ViewController.m
//  PrintSDKSample
//
//  Created by HP Inc. on 11/16/15.
//  Copyright © 2015 HP. All rights reserved.
//

#import "ViewController.h"
#import <MP.h>
#import <MobilePrintSDK/MPPrintItemFactory.h>
#import <MobilePrintSDK/MPPrintManager.h>

@interface ViewController () <MPPrintDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)printButtonTapped:(id)sender {
    [self printSample];
//    [self shareSample];
//    [self directPrintSample];
}

- (void)showAlert
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Print"
                                                                   message:@"Change this alert code to print the image named 'sample.image.jpg' instead."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)printSample
{
    UIImage *image = [UIImage imageNamed:@"sample.image.jpg"];
    MPPrintItem *printItem = [MPPrintItemFactory printItemWithAsset:image];
    UIViewController *vc = [[MP sharedInstance] printViewControllerWithDelegate:self dataSource:nil printItem:printItem fromQueue:NO settingsOnly:NO];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)shareSample
{
    MPPrintActivity *printActivity = [[MPPrintActivity alloc] init];
    NSArray *applicationActivities = @[printActivity];
    UIImage *imageToPrint = [UIImage imageNamed:@"sample.image.jpg"];
    MPPrintItem *printItem = [MPPrintItemFactory printItemWithAsset:imageToPrint];
    NSArray *activitiesItems = @[printItem];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activitiesItems applicationActivities:applicationActivities];
    activityViewController.excludedActivityTypes = @[UIActivityTypePrint];
    activityViewController.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
        if (completed) {
            NSLog(@"Activity completed");
        } else {
            NSLog(@"Activity NOT completed");
        }
    };
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (void)directPrintSample
{
    MPPrintManager *printManager = [[MPPrintManager alloc] init];
    UIImage *image = [UIImage imageNamed:@"sample.image.jpg"];
    MPPrintItem *printItem = [MPPrintItemFactory printItemWithAsset:image];
    NSError *error;
    [printManager print:printItem
              pageRange:nil
              numCopies:1
                  error:&error];
    
    if (MPPrintManagerErrorNone != error.code) {
        NSLog(@"%@", error);
    }
}

#pragma mark - MPPrintDelegate

- (void)didFinishPrintFlow:(UIViewController *)printViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didCancelPrintFlow:(UIViewController *)printViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
