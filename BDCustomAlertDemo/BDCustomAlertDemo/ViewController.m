//
//  ViewController.m
//  BDCustomAlertDemo
//
//  Created by Bhaskar Jyoti Das on 06/09/17.
//  Copyright © 2017 Bhaskar Jyoti Das. All rights reserved.
//

#import "ViewController.h"
#import "BDCustomAlertView.h"
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


- (IBAction)didTapShowAlert:(id)sender {
    BDCustomAlertView *customAlert = [[BDCustomAlertView alloc] init];
    switch ([sender tag]) {
        case 0:
        {
            [customAlert showAlertWithHeaderImage:[UIImage imageNamed:@"ioslogo.png"] message:@"This is an single button alert example with header image." cancelButtonTitle:@"Dismiss" cancelBlock:^{
                
            }];
        }
            break;
        case 1:
        {
            [customAlert showAlertWithTitle:@"BDCustomAlertView" message:@"This is an single button alert example with header title." cancelButtonTitle:@"Dismiss" cancelBlock:^{
                
            }];
        }
            break;
        case 2:
        {
            [customAlert showAlertWithHeaderImage:[UIImage imageNamed:@"ios_logo.png"] message:@"This is an double button alert example with header image." cancelButtonTitle:@"Cancel" successButtonTitle:@"Done" withSuccessBlock:^{
                
            } cancelBlock:^{
                
            }];
        }
            break;
        case 3:
        {
            [customAlert showAlertWithTitle:@"BDCustomAlertView" message:@"This is an double button alert example with header title." cancelButtonTitle:@"No" successButtonTitle:@"Yes" withSuccessBlock:^{
                
            } cancelBlock:^{
                
            }];
        }
            break;
        case 4:
        {
            [customAlert showToastWithMessage:@"This is a toast message in iOS like android."];
        }
            break;
        case 5:
        {
            [customAlert showToastWithMessage:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."];
        }
            break;
            
        default:
            break;
    }
}

@end
