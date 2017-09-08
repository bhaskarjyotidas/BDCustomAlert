//
//  BDCustomAlertView.m
//  Bhaskar
//
//  Created by Bhaskar Jyoti Das on 01/09/17.
//  Copyright © 2017 Bhaskar Jyoti Das. All rights reserved.
//

#import "BDCustomAlertView.h"


@interface MyRootViewController : UIViewController
@end

@implementation MyRootViewController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            return UIInterfaceOrientationMaskPortrait;
        case UIInterfaceOrientationPortraitUpsideDown:
            return UIInterfaceOrientationMaskPortraitUpsideDown;
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            return UIInterfaceOrientationMaskLandscape;
        default:
            return UIInterfaceOrientationMaskPortrait;
            break;
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

@end

@interface BDRoundedCornerView : UIView
@property IBInspectable float cornerRadious;
@property IBInspectable BOOL gradientOn;
@end

@interface BDRoundedCornerView  ()
{
    CAGradientLayer *gradientLayer;
}
@end

@implementation BDRoundedCornerView

- (void)layoutSubviews{
    [super layoutSubviews];
    self.layer.cornerRadius = self.cornerRadious;
    self.clipsToBounds = YES;
    if (self.gradientOn) {
        if (!gradientLayer) {
            gradientLayer = [CAGradientLayer layer];
            gradientLayer.frame = self.layer.bounds;
            
            gradientLayer.colors = [NSArray arrayWithObjects:
                                    (id)[UIColor colorWithRed:179.0/255.0 green:179.0/255.0 blue:179.0/255.0 alpha:1.0].CGColor,
                                    (id)[UIColor darkGrayColor].CGColor,
                                    (id)[UIColor darkGrayColor].CGColor,
                                    (id)[UIColor colorWithRed:179.0/255.0 green:179.0/255.0 blue:179.0/255.0 alpha:1.0].CGColor,
                                    nil];
            
            gradientLayer.locations = [NSArray arrayWithObjects:
                                       [NSNumber numberWithFloat:0.15f],
                                       [NSNumber numberWithFloat:0.4f],
                                       [NSNumber numberWithFloat:0.6f],
                                       [NSNumber numberWithFloat:0.85f],
                                       nil];
            gradientLayer.shadowColor = [UIColor lightGrayColor].CGColor;
            gradientLayer.shadowOffset = CGSizeMake(0.5, 4.0); //Here your control your spread
            gradientLayer.shadowOpacity = 0.5;
            gradientLayer.shadowRadius = 4.0;
            gradientLayer.cornerRadius = 5.0;
            [gradientLayer setStartPoint:CGPointMake(0.0, 0.5)];
            [gradientLayer setEndPoint:CGPointMake(1.0, 0.5)];
            [self.layer insertSublayer:gradientLayer atIndex:0];
        }
        gradientLayer.frame = self.layer.bounds;
    }
}
@end

@implementation BDLabel

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 5, 0, 5};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.isOval) {
        self.layer.cornerRadius = self.frame.size.height / 2;
    }
    else{
        self.layer.cornerRadius = self.cornerRadious;
    }
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1.0;
    self.clipsToBounds = YES;
}

@end


void(^successCallBack)();
void(^cancelCallBack)();


@interface BDCustomAlertView ()
@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIView *twoButtonAlertView;
@property (weak, nonatomic) IBOutlet UIView *singleButtonAlertView;
@property (weak, nonatomic) IBOutlet BDLabel *toastLabel;
- (IBAction)didTapOkButton:(id)sender;
- (IBAction)didTapCancelButton:(id)sender;

@end

@implementation BDCustomAlertView

- (void)showView : (UIView *)view withAnimation : (BOOL)isAnimation
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (!window) {
        window = [[[UIApplication sharedApplication] delegate] window];
    }
    self.frame = window.frame;
    self.center = window.center;
    [window addSubview:self];
    if (!self.window) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.backgroundColor = [UIColor clearColor];
        self.window.windowLevel = UIWindowLevelAlert + 1;
        self.window.rootViewController = [[MyRootViewController alloc]init];
    }
    self.window.frame = [[UIScreen mainScreen] bounds];
    [self.window makeKeyAndVisible];
    if (isAnimation) {
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.duration = 0.2;
        scaleAnimation.repeatCount = 0;
        scaleAnimation.autoreverses = NO;
        scaleAnimation.fromValue = [NSNumber numberWithFloat:0.2];
        scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
        [view.layer addAnimation:scaleAnimation forKey:@"scale"];
    }
    [self.window addSubview:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    NSBundle *bundle = [NSBundle mainBundle];
    return [[bundle loadNibNamed:@"BDCustomAlertView" owner:self options:nil] objectAtIndex:0];
}

+ (BDCustomAlertView *)instantiateAlert
{
    NSBundle *bundle = [NSBundle mainBundle];
    return [[bundle loadNibNamed:@"BDCustomAlertView" owner:self options:nil] objectAtIndex:0];
}

- (void)dismiss
{
    self.window = nil;
    [self removeFromSuperview];
}

- (IBAction)didTapOkButton:(id)sender {
    [self dismiss];
    if (successCallBack) {
        successCallBack();
    }
}

- (IBAction)didTapCancelButton:(id)sender {
    [self dismiss];
    if (cancelCallBack) {
        cancelCallBack();
    }
}

- (void)showAlertWithTitle : (NSString *)title message : (NSString *)message cancelButtonTitle : (NSString *)cancelButtonTitle successButtonTitle : (NSString *)successButtonTitle withSuccessBlock:(void (^)())successBlock cancelBlock:(void (^)())cancelBlock
{
    self.alertView.hidden = NO;
    self.toastLabel.hidden = YES;
    successCallBack = successBlock;
    cancelCallBack = cancelBlock;
    self.headerImageView.hidden = YES;
    self.headerLabel.hidden = NO;
    self.headerLabel.text = title;
    self.messageTextView.text = message;
    if (cancelButtonTitle.length > 0) {
        [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [self.dismissButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    }
    if (successButtonTitle.length > 0) {
        [self.okButton setTitle:successButtonTitle forState:UIControlStateNormal];
        self.singleButtonAlertView.hidden = YES;
        self.twoButtonAlertView.hidden = NO;
    }
    else{
        self.singleButtonAlertView.hidden = NO;
        self.twoButtonAlertView.hidden = YES;
    }
    [self showView:self.alertView withAnimation:YES];
}

- (void)showAlertWithTitle : (NSString *)title message : (NSString *)message cancelButtonTitle : (NSString *)cancelButtonTitle cancelBlock:(void (^)())cancelBlock
{
    self.alertView.hidden = NO;
    self.toastLabel.hidden = YES;
    cancelCallBack = cancelBlock;
    self.headerImageView.hidden = YES;
    self.headerLabel.hidden = NO;
    self.headerLabel.text = title;
    self.messageTextView.text = message;
    if (cancelButtonTitle.length > 0) {
        [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [self.dismissButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    }
    self.singleButtonAlertView.hidden = NO;
    self.twoButtonAlertView.hidden = YES;
    [self showView:self.alertView withAnimation:YES];
}

- (void)showAlertWithHeaderImage : (UIImage *)headerImage message : (NSString *)message cancelButtonTitle : (NSString *)cancelButtonTitle successButtonTitle : (NSString *)successButtonTitle withSuccessBlock:(void (^)())successBlock cancelBlock:(void (^)())cancelBlock
{
    self.alertView.hidden = NO;
    self.toastLabel.hidden = YES;
    successCallBack = successBlock;
    cancelCallBack = cancelBlock;
    self.headerImageView.hidden = NO;
    self.headerLabel.hidden = YES;
    if (headerImage) {
        self.headerImageView.image = headerImage;
    }
    self.messageTextView.text = message;
    if (cancelButtonTitle.length > 0) {
        [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [self.dismissButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    }
    if (successButtonTitle.length > 0) {
        [self.okButton setTitle:successButtonTitle forState:UIControlStateNormal];
        self.singleButtonAlertView.hidden = YES;
        self.twoButtonAlertView.hidden = NO;
    }
    else{
        self.singleButtonAlertView.hidden = NO;
        self.twoButtonAlertView.hidden = YES;
    }
    [self showView:self.alertView withAnimation:YES];
}

- (void)showAlertWithHeaderImage : (UIImage *)headerImage message : (NSString *)message cancelButtonTitle : (NSString *)cancelButtonTitle cancelBlock:(void (^)())cancelBlock
{
    self.alertView.hidden = NO;
    self.toastLabel.hidden = YES;
    cancelCallBack = cancelBlock;
    self.headerImageView.hidden = NO;
    self.headerLabel.hidden = YES;
    if (headerImage) {
        self.headerImageView.image = headerImage;
    }
    self.messageTextView.text = message;
    if (cancelButtonTitle.length > 0) {
        [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [self.dismissButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    }
    self.singleButtonAlertView.hidden = NO;
    self.twoButtonAlertView.hidden = YES;
    [self showView:self.alertView withAnimation:YES];
}

- (void)showToastWithMessage : (NSString *)message
{
    self.toastLabel.text = message;
    self.alertView.hidden = YES;
    self.toastLabel.hidden = NO;
    [self showView:self.toastLabel withAnimation:NO];
    CGRect rectToastLabel = self.toastLabel.frame;
    CGRect rect = [self.toastLabel.text boundingRectWithSize:CGSizeMake(self.toastLabel.frame.size.width, CGFLOAT_MAX)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName: self.toastLabel.font}
                                             context:nil];
    rect.size.height += 30;
    if (rect.size.height > 300) {
        rect.size.height = 300;
    }
    rectToastLabel.origin.y -= (rect.size.height - rectToastLabel.size.height);
    rectToastLabel.size.height = rect.size.height;
    self.toastLabel.frame = rectToastLabel;
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:kToastDisplayTime];
}
@end
