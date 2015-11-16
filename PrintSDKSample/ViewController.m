//
//  ViewController.m
//  PrintSDKSample
//
//  Created by HP Inc. on 11/16/15.
//  Copyright © 2015 HP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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
    [self showAlert];
//    [self printSample];
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
    
}

@end
