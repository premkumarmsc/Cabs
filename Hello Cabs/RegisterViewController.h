//
//  ForgotPasswordViewController.h
//  Hello Cabs
//
//  Created by SYZYGY on 25/11/16.
//  Copyright © 2016 Syzygy Enterprise Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
- (IBAction)backBtn:(id)sender;
- (IBAction)clickResend:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtMobileNo;
@property (weak, nonatomic) IBOutlet UIView *viewMobile;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UITextField *txtFullName;
@property (weak, nonatomic) IBOutlet UITextField *emailId;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UITextField *txtMobile;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtDob;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
- (IBAction)clickRegister:(id)sender;
- (IBAction)clickDOB:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewOTP;
@property (weak, nonatomic) IBOutlet UIView *subViewOTP;
@property (weak, nonatomic) IBOutlet UITextField *txtOtp;
- (IBAction)clickBackOTP:(id)sender;
- (IBAction)clickSubmitOTP:(id)sender;
- (IBAction)clickResendOTP:(id)sender;


@end
