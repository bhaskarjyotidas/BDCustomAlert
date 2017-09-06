# BDCustomAlert

BDCustomAlertView is a objective c custom alertview which support toast alert and custom design alert with header title or header image.
# Features!
- Single button alert
- Double button alert
- Header text / image
- Toast message
## ScreenShots

![](https://raw.githubusercontent.com/BhaskarJyotiDas/BDCustomAlert/master/ScreenShots/1.jpg?raw=true)
![](https://raw.githubusercontent.com/BhaskarJyotiDas/BDCustomAlert/master/ScreenShots/2.jpg?raw=true)
![](https://raw.githubusercontent.com/BhaskarJyotiDas/BDCustomAlert/master/ScreenShots/3.jpg?raw=true)
![](https://raw.githubusercontent.com/BhaskarJyotiDas/BDCustomAlert/master/ScreenShots/4.jpg?raw=true)

## How To Use

## Step 1 : import BDCustomAlertView file like
#import "BDCustomAlertView.h"
## Step 2 : Create instance of BDCustomAlertView like
BDCustomAlertView *customAlert = [[BDCustomAlertView alloc] init];
or
BDCustomAlertView *customAlert = [BDCustomAlertView instantiateAlert];
## Step 3 : For showing alertview 
### Type 1 : Header Image with one Selection 
[customAlert showAlertWithHeaderImage:[UIImage imageNamed:@"ioslogo.png"] message:@"This is an single button alert example with header image." cancelButtonTitle:@"Dismiss" cancelBlock:^{

}];
### Type 2 : Header Title with one Selection 
[customAlert showAlertWithTitle:@"BDCustomAlertView" message:@"This is an single button alert example with header title." cancelButtonTitle:@"Dismiss" cancelBlock:^{

}];
### Type 3 : Header Image with two Selection 
[customAlert showAlertWithHeaderImage:[UIImage imageNamed:@"ios_logo.png"] message:@"This is an double button alert example with header image." cancelButtonTitle:@"Cancel" successButtonTitle:@"Done" withSuccessBlock:^{

} cancelBlock:^{

}];
### Type 4 : Header Title with two Selection 
[customAlert showAlertWithTitle:@"BDCustomAlertView" message:@"This is an double button alert example with header title." cancelButtonTitle:@"No" successButtonTitle:@"Yes" withSuccessBlock:^{

} cancelBlock:^{

}];
### Type 5 : Toast message 
[customAlert showToastWithMessage:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."];


## Author
### Bhaskar Jyoti Das

<bhaskar.bankura@gmail.com>

## License
BDCustomAlert is available under the MIT license. See the LICENSE file for more info.
