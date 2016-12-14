//
//  ForgotPasswordViewController.m
//  Hello Cabs
//
//  Created by SYZYGY on 25/11/16.
//  Copyright © 2016 Syzygy Enterprise Solutions. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden =TRUE;
    [super viewDidLoad];

    [self assignView:_viewMobile];
    
     [self assignView:_subViewOTP];
    //[self assignView:_view2];
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
    
    
    if([_txtMobileNo.text isEqualToString:@""])
    {
        [ProgressHUD showError:@"Please enter valid Mobile number"];
        
        // [_emailFld becomeFirstResponder];
    }
    else
    {
        
        
       
            
            [self forgot];
            
       
        
        
        
    }

    
}

-(void)forgot
{
    
    
    
    
    [ProgressHUD show:nil Interaction:NO];
    
    //[MBProgressHUD show];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([_txtMobileNo.text rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    {
        [parameters setObject:[NSString stringWithFormat:@"+95%@",_txtMobileNo.text] forKey:@"userId"];
    }
    else
    {
    
    [parameters setObject:_txtMobileNo.text forKey:@"emailId"];
    }
    
    
    NSLog(@"Params:%@",parameters);
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@/ForgotPassword",ApiBaseURL];
    
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
            
            [ProgressHUD showSuccess:@"OTP Send Successfully"];
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
        NSString *uniqueString =  [[NSUserDefaults standardUserDefaults]stringForKey:@"UNIQUE_KEY"];
        
        if([otpString isEqualToString:_txtOtp.text])
        {
            
            
            
            
           
            UITextField *textField;
            BlockTextPromptAlertView *alert = [BlockTextPromptAlertView promptWithTitle:@"New Password" message:@"Please enter new password" textField:&textField block:^(BlockTextPromptAlertView *alert){
                [alert.textField resignFirstResponder];
                alert.textField.secureTextEntry = YES;
                return YES;
            }];
            
            alert.textField.secureTextEntry = YES;
            [alert setCancelButtonWithTitle:@"Cancel" block:nil];
            [alert addButtonWithTitle:@"Okay" block:^{
                NSLog(@"Text: %@", textField.text);
                
                
                if([textField.text isEqualToString:@""])
                {
                    [ProgressHUD showError:@"Please enter OTP"];
                    
                    // [_emailFld becomeFirstResponder];
                }
                else
                {
                
                
                _viewOTP.hidden = YES;
                
                [ProgressHUD show:nil Interaction:NO];
                
                //[MBProgressHUD show];
                NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
                [parameters setObject:uniqueString forKey:@"userId"];
                 [parameters setObject:otpString forKey:@"OTP"];
                
                [parameters setObject:textField.text forKey:@"newPassword"];
                
                [parameters setObject:@"" forKey:@"oldPassword"];
                [parameters setObject:@"" forKey:@"emailId"];
                
                
                NSLog(@"Params:%@",parameters);
                
                
                NSString *urlString=[NSString stringWithFormat:@"%@/ChangePassword",ApiBaseURL];
                
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
                        

                        
                        
                        [ProgressHUD showSuccess:@"Password Changed Successfully"];
                    }
                    
                    
                    
                    
                    
                    
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"Error: %@", error);
                    
                    
                    [ProgressHUD showError:error.localizedDescription];
                    
                    
                }];
                }
                
            }];
            [alert show];
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
            
            
            _txtOtp.text = [NSString stringWithFormat:@"%@",[JSON valueForKeyPath:@"OTP"]];
            
            [ProgressHUD showSuccess:@"OTP Resend Successfully"];
        }
        
        
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == _txtMobileNo)
    {
        
        if (_txtMobileNo.text.length >= 10 && range.length == 0)
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
