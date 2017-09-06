//
//  BDCustomAlertView.h
//  Bhaskar
//
//  Created by Bhaskar Jyoti Das on 01/09/17.
//  Copyright © 2017 Bhaskar Jyoti Das. All rights reserved.
//

#define kToastDisplayTime 2.0
#import <UIKit/UIKit.h>

@interface BDLabel : UILabel
@property (nonatomic) IBInspectable BOOL isOval;
@property (nonatomic) IBInspectable NSInteger cornerRadious;
@end

@interface BDCustomAlertView : UIView
+ (BDCustomAlertView *)instantiateAlert;
- (void)showAlertWithTitle : (NSString *)title message : (NSString *)message cancelButtonTitle : (NSString *)cancelButtonTitle successButtonTitle : (NSString *)successButtonTitle withSuccessBlock:(void (^)())successBlock cancelBlock:(void (^)())cancelBlock;
- (void)showAlertWithTitle : (NSString *)title message : (NSString *)message cancelButtonTitle : (NSString *)cancelButtonTitle cancelBlock:(void (^)())cancelBlock;
- (void)showAlertWithHeaderImage : (UIImage *)headerImage message : (NSString *)message cancelButtonTitle : (NSString *)cancelButtonTitle successButtonTitle : (NSString *)successButtonTitle withSuccessBlock:(void (^)())successBlock cancelBlock:(void (^)())cancelBlock;
- (void)showAlertWithHeaderImage : (UIImage *)headerImage message : (NSString *)message cancelButtonTitle : (NSString *)cancelButtonTitle cancelBlock:(void (^)())cancelBlock;
- (void)showToastWithMessage : (NSString *)message;
@end
