//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "CompletedViewController.h"
#import "AFNetworking.h"
#import "DashboardViewController.h"


@interface CompletedViewController ()
{
    

}
@end

@implementation CompletedViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.topView.layer.masksToBounds = NO;
    self.topView.layer.shadowOffset = CGSizeMake(0, 3);
    self.topView.layer.shadowRadius = 5;
    self.topView.layer.shadowOpacity = 0.5;
    
    
   
    _viewLogout.layer.cornerRadius = 3;
    _viewLogout.layer.masksToBounds = YES;
    
    
    
    
    
    _lbLDriverName.text = [NSString stringWithFormat:@": %@",[[NSUserDefaults standardUserDefaults]stringForKey:@"DRIVER_NAME"] ];
    /*
    _lblEmail.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"USER_EMAIl"] ];
    
    _lblPhone.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKeyPath:@"USER_ID_MAIN"] ];
    */

 
}



- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)clickLogout:(id)sender {
    
    
    [UIAlertView showWithTitle:@"Logout"
                       message:@"Are you sure you want to Logout?"
             cancelButtonTitle:@"No"
             otherButtonTitles:@[@"Yes"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == [alertView cancelButtonIndex]) {
                              NSLog(@"Cancelled");
                          } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Yes"]) {
                              NSLog(@"Have a cold beer");
                              
                              
                              
                              [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"USER_ID_MAIN"];
                              
                              [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"USER_NAME"];
                              
                              
                              [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"USER_EMAIl"];
                              
                              [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"USER_GENDER"];
                              
                              
                              
                              ViewController *dashObj =[[ViewController alloc]init];
                              [self.navigationController pushViewController:dashObj animated:YES];
                          }
                      }];
    

    
}
@end
