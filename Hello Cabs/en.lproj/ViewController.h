//
//  ViewController.h
//  Hello Cabs
//
//  Created by SYZYGY on 25/11/16.
//  Copyright © 2016 Syzygy Enterprise Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ForgotPasswordViewController.h"
#import "RegisterViewController.h"

@interface ViewController : UIViewController

- (IBAction)loginBtn:(id)sender;
- (IBAction)forgotPasswordBtn:(id)sender;
- (IBAction)facebookBtn:(id)sender;
- (IBAction)registerBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *numberFld;
@property (weak, nonatomic) IBOutlet UITextField *passwordFld;
@property (weak, nonatomic) IBOutlet UIView *viewNumber;
@property (weak, nonatomic) IBOutlet UIView *viewPassword;
- (IBAction)clickSignUp:(id)sender;

@end

