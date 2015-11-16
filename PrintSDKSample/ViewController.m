//
//  ViewController.m
//  PrintSDKSample
//
//  Created by HP Inc. on 11/16/15.
//  Copyright © 2015 HP. All rights reserved.
//

#import "ViewController.h"
#import <MP.h>
#import <MPPrintItemFactory.h>

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
    //    [self showAlert];
    [self printSample];
}

- (void)showAlert
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Print"
                                                                   message:@"The print button was tapped."
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
