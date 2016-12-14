//
//  ViewController.m
//  Hello Cabs
//
//  Created by SYZYGY on 25/11/16.
//  Copyright © 2016 Syzygy Enterprise Solutions. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden =TRUE;
    [super viewDidLoad];
    
    
    
    if( [[[NSUserDefaults standardUserDefaults]stringForKey:@"LANGUAGE"] isEqualToString:@"EN"])
    {
        
    }
    else
    {
        
    }
    
    
    
    
    
    if([[[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"] isEqualToString:@""] || [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"] == [NSNull null] || [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"].length == 0)
    {
        
    }
    else
    {
        if([[[NSUserDefaults standardUserDefaults]stringForKey:@"RECENT_JOB_ID"] isEqualToString:@""] || [[NSUserDefaults standardUserDefaults]stringForKey:@"RECENT_JOB_ID"] == [NSNull null] || [[NSUserDefaults standardUserDefaults]stringForKey:@"RECENT_JOB_ID"].length == 0)
        {
            DashboardViewController *dashObj =[[DashboardViewController alloc]init];
            [self.navigationController pushViewController:dashObj animated:NO];
        }
        else
        {
        
            if([[[NSUserDefaults standardUserDefaults]stringForKey:@"RECENT_JOB_STATUS"] isEqualToString:@"PENDING"])
            {
            TimerViewController *dashObj =[[TimerViewController alloc]init];
            [self.navigationController pushViewController:dashObj animated:NO];
            }
            else
            {
                UpcomingViewController *dashObj =[[UpcomingViewController alloc]init];
                [self.navigationController pushViewController:dashObj animated:NO];
  
            }
            
            
            /*
            DashboardViewController *dashObj =[[DashboardViewController alloc]init];
            [self.navigationController pushViewController:dashObj animated:NO];
             */
            
        }
        
        
    }
   
    [self assignView:_viewNumber];
    [self assignView:_viewPassword];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)assignView:(UIView *)view
{
    view.layer.cornerRadius = 3.0;
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginBtn:(id)sender {
    
  
    
    
    if([_numberFld.text isEqualToString:@""])
    {
        
        NSString *test = NSLocalizedString(@"VALID_MOBILE", @"Message");
        
        
        
        
         [ProgressHUD showError:test];
        
        // [_emailFld becomeFirstResponder];
    }
    else
    {
        
        
        if([_passwordFld.text isEqualToString:@""])
        {
            
           [ProgressHUD showError:NSLocalizedString(@"VALID_PASSWORD", @"Message")];
            
            // [_emailFld becomeFirstResponder];
        }
        else
        {
            
            [self login];
            
        }
        
        
        
        
    }
    
    
}

-(void)login
{
    
    //NSString *uniqueString =  [[NSUserDefaults standardUserDefaults]stringForKey:@"UNIQUE_KEY"];
    
    // [self forgot];
    
    
    //[ProgressHUD show:nil Interaction:NO];
    
    [ProgressHUD show:nil Interaction:NO];
    
    //[MBProgressHUD show];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:[NSString stringWithFormat:@"+95%@",_numberFld.text] forKey:@"userId"];
    [parameters setObject:_passwordFld.text forKey:@"password"];
    
    
    NSLog(@"Params:%@",parameters);
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@/Login",ApiBaseURL];
    
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
            
            NSString *mobileNo=[NSString stringWithFormat:@"%@",[JSON valueForKeyPath:@"userId"]];
            
            
            
            
            [[NSUserDefaults standardUserDefaults]setObject:mobileNo forKey:@"USER_ID_MAIN"];
            
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[JSON valueForKeyPath:@"name"]] forKey:@"USER_NAME"];
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[JSON valueForKeyPath:@"emailId"]] forKey:@"USER_EMAIl"];
            
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[JSON valueForKeyPath:@"gender"]] forKey:@"USER_GENDER"];
            
            DashboardViewController *signObj =[[DashboardViewController alloc]init];
            [self.navigationController pushViewController:signObj animated:YES];
            
            [ProgressHUD dismiss];

        }
        
        
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    
   }

- (IBAction)forgotPasswordBtn:(id)sender
{
    ForgotPasswordViewController *signObj =[[ForgotPasswordViewController alloc]init];
    [self.navigationController pushViewController:signObj animated:YES];
}

- (IBAction)facebookBtn:(id)sender {
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == _numberFld)
    {
        
        if (_numberFld.text.length >= 10 && range.length == 0)
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

- (IBAction)registerBtn:(id)sender {
    
    RegisterViewController *signObj =[[RegisterViewController alloc]init];
    [self.navigationController pushViewController:signObj animated:YES];
    
}
@end
