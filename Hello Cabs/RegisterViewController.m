//
//  ForgotPasswordViewController.m
//  Hello Cabs
//
//  Created by SYZYGY on 25/11/16.
//  Copyright © 2016 Syzygy Enterprise Solutions. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden =TRUE;
    [super viewDidLoad];
    
    
    [self assignView:_view1];
    [self assignView:_view2];
    [self assignView:_view3];
    [self assignView:_view4];
    [self assignView:_view5];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)assignView:(UIView *)view
{
    view.layer.cornerRadius = 3.0;
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.layer.masksToBounds = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickResend:(id)sender {
}
- (IBAction)clickRegister:(id)sender {
    
    
    if (_txtFullName.text.length ==0)
    {
        [ProgressHUD showError:@"Please enter full name"];
        
        // [_emailFld becomeFirstResponder];
    }
    else
    {
        
        if (_emailId.text.length ==0)
        {
            [ProgressHUD showError:@"Please enter Email id"];
            
            // [_emailFld becomeFirstResponder];
        }
        else
        {
        
        if(![self NSStringIsValidEmail:_emailId.text])
        {
            
          [ProgressHUD showError:@"Please enter Valid Email id"];
            
            // [_emailFld becomeFirstResponder];
        }
        else
        {
            if ([_txtMobile.text isEqualToString:@""] )
            {
                 [ProgressHUD showError:@"Please enter Valid Mobile No"];
                
                //[_uniqueIdFld becomeFirstResponder];
            }
            else
            {
                NSLog(@"Next");
                
                if (_txtPassword.text.length ==0 )
                {
                    [ProgressHUD showError:@"Please enter Password"];
                    
                    //[_uniqueIdFld becomeFirstResponder];
                }
                else
                {
                    if (_txtDob.text.length ==0 )
                    {
                        [ProgressHUD showError:@"Please select your Date of Birth"];
                        
                        //[_uniqueIdFld becomeFirstResponder];
                    }
                    else
                    {
                        [self registerFun];
                    }
                }
                
                /*
                
                [ProgressHUD show:nil Interaction:NO];
                
                //[MBProgressHUD show];
                NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
                [parameters setObject:_emailFld.text forKey:@"username"];
                [parameters setObject:_uniqueIdFld.text forKey:@"password"];
                
                
                NSLog(@"Params:%@",parameters);
                
                
                NSString *urlString=[NSString stringWithFormat:@"%@/teacher/login",ApiBaseURL];
                
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                manager.requestSerializer = [AFJSONRequestSerializer serializer];
                
                [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
                [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];[manager.requestSerializer setTimeoutInterval:20];
                [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                manager.securityPolicy.allowInvalidCertificates = YES;
                [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                    // NSLog(@"Success: %@", responseObject);
                    
                    NSError *error = nil;
                    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                    
                    NSLog(@"JSON:%@",JSON);
                    
                    if ([[JSON valueForKey:@"status"] intValue]==400)
                    {
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.label.text = [JSON valueForKeyPath:@"message"][0];
                        hud.label.numberOfLines =2;
                        
                        hud.label.adjustsFontSizeToFitWidth=YES;
                        hud.label.minimumScaleFactor=0.5;
                        
                        hud.margin = 10.f;
                        hud.yOffset = 250.f;
                        hud.removeFromSuperViewOnHide = YES;
                        [hud hideAnimated:YES afterDelay:2];
                        
                        [ProgressHUD dismiss];
                    }
                    else
                    {
                        
                        [ProgressHUD dismiss];
                        
                        [[NSUserDefaults standardUserDefaults]setObject:[JSON valueForKeyPath:@"user_data.staff_id"] forKey:@"STAFF_ID"];
                        [[NSUserDefaults standardUserDefaults]setObject:[JSON valueForKeyPath:@"user_data.prof_pic_url"] forKey:@"STAFF_PIC"];
                        
                        [[NSUserDefaults standardUserDefaults]setObject:[JSON valueForKeyPath:@"user_data.name"] forKey:@"STAFF_NAME"];
                        
                        [[NSUserDefaults standardUserDefaults]setObject:[JSON valueForKeyPath:@"user_data.designation"] forKey:@"STAFF_DESIGNATION"];
                        
                        [[NSUserDefaults standardUserDefaults]setObject:[JSON valueForKeyPath:@"user_data.aauth_email"] forKey:@"STAFF_EMAIL"];
                        
                        [[NSUserDefaults standardUserDefaults]setObject:[JSON valueForKeyPath:@"user_data.aauth_mobile"] forKey:@"STAFF_PHONE"];
                        
                        
                        [[NSUserDefaults standardUserDefaults]setObject:@"OUT" forKey:@"FAV_COME"];
                        FavouritesViewController *dashObj =[[FavouritesViewController alloc]init];
                        [self.navigationController pushViewController:dashObj animated:YES];
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"Error: %@", error);
                    
                    
                    [ProgressHUD showError:error.localizedDescription];
                    
                    
                }];
                
                */
                
                
            }
            
        }
            
            
        }
        
        
        
    }

    
}

-(void)registerFun
{
    
    [ProgressHUD show:nil Interaction:NO];
    
    //[MBProgressHUD show];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:_txtFullName.text forKey:@"name"];
    [parameters setObject:_emailId.text forKey:@"emailId"];
    [parameters setObject:[NSString stringWithFormat:@"+95%@",_txtMobile.text] forKey:@"mobileNo"];
    [parameters setObject:_txtPassword.text forKey:@"password"];
    [parameters setObject:_txtDob.text forKey:@"dob"];
    
    if(_segmentControl.selectedSegmentIndex == 0)
    {
        [parameters setObject:@"M" forKey:@"gender"];
    }
    else
    {
        [parameters setObject:@"F" forKey:@"gender"];
        
    }
    
    NSLog(@"Params:%@",parameters);
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@/UserRegistration",ApiBaseURL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];[manager.requestSerializer setTimeoutInterval:20];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // NSLog(@"Success: %@", responseObject);
        
        NSError *error = nil;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"JSON:%@",JSON);
        
        
        
        if ([[JSON valueForKey:@"status"] intValue]!=1)
        {
            [ProgressHUD showError:[NSString stringWithFormat:@"%@",[JSON valueForKey:@"message"]]];
        }
        else
        {
            
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[JSON valueForKeyPath:@"userId"]] forKey:@"UNIQUE_KEY"];
            
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[JSON valueForKeyPath:@"OTP"]] forKey:@"OTP"];
            
            _viewOTP.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
            _subViewOTP.layer.cornerRadius = 5;
            _subViewOTP.layer.masksToBounds = YES;
            
            _viewOTP.hidden = NO;
            
            [self.view addSubview:_viewOTP];
            
            [_txtOtp becomeFirstResponder];
            
            _txtOtp.text = [NSString stringWithFormat:@"%@",[JSON valueForKeyPath:@"OTP"]];
            
            [ProgressHUD dismiss];
        }
        
        
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    
    
    

    
  
}

- (IBAction)clickBackOTP:(id)sender {
    
    _viewOTP.hidden = YES;
}

- (IBAction)clickSubmitOTP:(id)sender {
    
    if([_txtOtp.text isEqualToString:@""])
    {
        [ProgressHUD showError:@"Please enter OTP"];
        
        // [_emailFld becomeFirstResponder];
    }
    else
    {
        
       
        
        
      NSString *otpString =  [[NSUserDefaults standardUserDefaults]stringForKey:@"OTP"];
        
        if([otpString isEqualToString:_txtOtp.text])
        {
            
            
            [ProgressHUD show:nil Interaction:NO];
            
            //[MBProgressHUD show];
            
            NSString *uniqueString =  [[NSUserDefaults standardUserDefaults]stringForKey:@"UNIQUE_KEY"];
            
           
            
            
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            //[parameters setObject:_txtFullName.text forKey:@"name"];
            [parameters setObject:_txtOtp.text forKey:@"OTP"];
            [parameters setObject:[NSString stringWithFormat:@"+95%@",_txtMobile.text] forKey:@"userId"];
           //[parameters setObject:uniqueString forKey:@"userId"];
            [parameters setObject:@"" forKey:@"emailId"];
            
            
            
            NSString *urlString=[NSString stringWithFormat:@"%@/OtpEmailValidation",ApiBaseURL];
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            
            [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
            [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];[manager.requestSerializer setTimeoutInterval:20];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.securityPolicy.allowInvalidCertificates = YES;
            
            [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                // NSLog(@"Success: %@", responseObject);
                
                NSError *error = nil;
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                
                NSLog(@"JSON:%@",JSON);
                
                
                
                if ([[JSON valueForKey:@"status"] intValue]!=1)
                {
                    [ProgressHUD showError:[NSString stringWithFormat:@"%@",[JSON valueForKey:@"message"]]];
                }
                else
                {
                    
                    ViewController *signObj =[[ViewController alloc]init];
                    [self.navigationController pushViewController:signObj animated:NO];
                    
                    [ProgressHUD dismiss];
                }
                
                 [ProgressHUD dismiss];
                
                
                
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"Error: %@", error);
                
                
                [ProgressHUD showError:error.localizedDescription];
                
                
            }];
            

            
           
            
        }
        else
        {
            [ProgressHUD showError:@"Invalid OTP"];
        }
        
        
        
    }
    
}

- (IBAction)clickResendOTP:(id)sender {
    
    
    NSString *uniqueString =  [[NSUserDefaults standardUserDefaults]stringForKey:@"UNIQUE_KEY"];
    
   // [self forgot];
    
    
    [ProgressHUD show:nil Interaction:NO];
    
    //[MBProgressHUD show];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:uniqueString forKey:@"userId"];
    
    
    NSLog(@"Params:%@",parameters);
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@/ResendOTP",ApiBaseURL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];[manager.requestSerializer setTimeoutInterval:20];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // NSLog(@"Success: %@", responseObject);
        
        NSError *error = nil;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"JSON:%@",JSON);
        
        
        
        if ([[JSON valueForKey:@"status"] intValue]!=1)
        {
            [ProgressHUD showError:[NSString stringWithFormat:@"%@",[JSON valueForKey:@"message"]]];
        }
        else
        {
            
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[JSON valueForKeyPath:@"userId"]] forKey:@"UNIQUE_KEY"];
            
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[JSON valueForKeyPath:@"OTP"]] forKey:@"OTP"];
            
            
            [ProgressHUD showSuccess:@"OTP Resend Successfully"];
        }
        
        
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    
}


-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (IBAction)clickDOB:(id)sender {
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Select Your DOB" datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date] minimumDate:nil maximumDate:[NSDate date] target:self action:@selector(timeWasSelected:element:) origin:sender];
    datePicker.minuteInterval = 5;
    [datePicker showActionSheetPicker];
    
    
}

- (NSDate *)logicalOneYearAgo:(NSDate *)from {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:-5];
    
    return [gregorian dateByAddingComponents:offsetComponents toDate:from options:0];
    
}

- (NSDate *)logicalOneYearAgo1:(NSDate *)from {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:-100];
    
    return [gregorian dateByAddingComponents:offsetComponents toDate:from options:0];
    
}

-(void)timeWasSelected:(NSDate *)selectedTime element:(id)element {
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *dayName = [dateFormatter stringFromDate:selectedTime];
    
    
    
    long long milliseconds = (long long)([selectedTime timeIntervalSince1970]);
    
    
   // duedateTime = milliseconds;
    
    
    
    
    
    _txtDob.text = [NSString stringWithFormat:@"%@",dayName];
    
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == _txtMobile)
    {
        
        if (_txtMobile.text.length >= 10 && range.length == 0)
        {
            return NO; // return NO to not change text
        }
    }
    else
    {
        return YES;
    }
    return YES;
}

@end
