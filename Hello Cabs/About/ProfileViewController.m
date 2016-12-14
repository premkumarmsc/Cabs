//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "ProfileViewController.h"
#import "AFNetworking.h"
#import "DashboardViewController.h"


@interface ProfileViewController ()
{
    

}
@end

@implementation ProfileViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.topView.layer.masksToBounds = NO;
    self.topView.layer.shadowOffset = CGSizeMake(0, 3);
    self.topView.layer.shadowRadius = 5;
    self.topView.layer.shadowOpacity = 0.5;
    
    
   
    _viewLogout.layer.cornerRadius = 3;
    _viewLogout.layer.masksToBounds = YES;
    
    
    if(IS_IPHONE_5 || IS_IPHONE_4_OR_LESS)
    {
        
        _imgUser.layer.frame = CGRectMake(139, 53, 100, 100);
        _imgUser.layer.cornerRadius = _imgUser.frame.size.height/2.30;
        _imgUser.clipsToBounds = true;
        
    }

    
    
    [self.imgUser.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.imgUser.layer setShadowOpacity:0.8];
    [self.imgUser.layer setShadowRadius:3.0];
    [self.imgUser.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    self.imgUser.layer.masksToBounds = YES;
    
    NSString *mainUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"STAFF_PIC"] ];
    
    [_imgUser sd_setImageWithURL:[NSURL URLWithString:mainUrl]
                placeholderImage:[UIImage imageNamed:@"default_profile_icon"]];
    
    
    
    
    _lblUserName.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"USER_NAME"] ];
    
    _lblEmail.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"USER_EMAIl"] ];
    
    _lblPhone.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKeyPath:@"USER_ID_MAIN"] ];
    

    if([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"USER_GENDER"] ]  isEqualToString:@"M"])
    {
        _segment.selectedSegmentIndex = 0;
    }
    else
    {
        _segment.selectedSegmentIndex = 1;

    }
    
    
 
    
    [self languageAssign];
}

-(void)languageAssign
{
    if([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"LANGUAGE"] ]  isEqualToString:@"EN"])
    {
        _segmentLanguage.selectedSegmentIndex = 0;
        
        _plaGender.text = @"Gender";
        _plaLanguage.text = @"Language";
        _plaTopLabel.text = @"Profile Information";
        
        [_segment setTitle:@"Male" forSegmentAtIndex:0];

        [_segment setTitle:@"Female" forSegmentAtIndex:1];

        
    }
    else
    {
        _segmentLanguage.selectedSegmentIndex = 1;
        
        _plaGender.text = @"လိင္";
        _plaLanguage.text = @"ဘာသာစကား";
        _plaTopLabel.text = @"ကုိယ္ေရးအခ်က္အလက္";
        
        [_segment setTitle:@"ေယာက်ာၤး" forSegmentAtIndex:0];
        
        [_segment setTitle:@"မိန္းမ" forSegmentAtIndex:1];
        
    }
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
- (IBAction)languageChanged:(id)sender {
    
    
    if(_segmentLanguage.selectedSegmentIndex == 0)
    {
        NSLog(@"EN");
        
         [[NSUserDefaults standardUserDefaults]setObject:@"EN" forKey:@"LANGUAGE"];
    }
    else
    {
       NSLog(@"BR");
        
         [[NSUserDefaults standardUserDefaults]setObject:@"BR" forKey:@"LANGUAGE"];
    }
    
    [self languageAssign];
    
}
@end
