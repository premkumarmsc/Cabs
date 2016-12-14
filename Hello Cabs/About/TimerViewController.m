//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "TimerViewController.h"
#import "AFNetworking.h"
#import "DashboardViewController.h"


@interface TimerViewController ()
{
    

}
@end

@implementation TimerViewController

NSTimer *timer;
int currMinute;
int currSeconds;
NSTimer *timerNewOne;

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
    
     NSString *jobId =  [[NSUserDefaults standardUserDefaults]stringForKey:@"RECENT_JOB_ID"];
    
    _lblUserName.text = [NSString stringWithFormat:@"Confirmation No : %@",jobId];

    
    currMinute=10;
    currSeconds=00;
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    NSTimer *loop = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(start) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:loop forMode:NSRunLoopCommonModes];
 
    
    if([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"LANGUAGE"] ]  isEqualToString:@"EN"])
    {
        
        
        
        _plaCancelBooking.text = @"Cancel Booking";
    }
    else
    {
      
        _plaCancelBooking.text = @"ပယ္ဖ်က္သည္";

        
    }
    
    
    timerNewOne=[NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(timerFiredNew) userInfo:nil repeats:YES];    //[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

-(void)timerFiredNew
{
    NSString *uniqueString =  [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"];
    
    
    
   
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:uniqueString forKey:@"userId"];
    
     NSString *jobId =  [[NSUserDefaults standardUserDefaults]stringForKey:@"RECENT_JOB_ID"];
    
    [parameters setObject:@"1" forKey:@"statusBookingId"];
    
    [parameters setObject:jobId forKey:@"jobId"];
    [parameters setObject:@"upcoming" forKey:@"category"];
    
    
    
    
    //
    
    
    NSLog(@"Params:%@",parameters);
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@/YourRideDetails",ApiBaseURL];
    
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
        
        NSLog(@"JSON HHH:%@",JSON);
        
        
        if ([[JSON valueForKeyPath:@"statusBookingId"] intValue] != 0 ) {
            if([[JSON valueForKeyPath:@"statusBookingId"] intValue] != 1 )
            {
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",@"ACCEPTED"] forKey:@"RECENT_JOB_STATUS"];
                
                [timer invalidate];
                [timerNewOne invalidate];
                
                
                [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@",[JSON valueForKey:@"message"]]];
                
                UpcomingViewController *signObj =[[UpcomingViewController alloc]init];
                [self.navigationController pushViewController:signObj animated:YES];
                
            }
        }
        
       
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
       // [ProgressHUD showError:error.localizedDescription];
        
        
    }];

}



- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)clickLogout:(id)sender {
    
    
    [UIAlertView showWithTitle:@"Cancel Ride"
                       message:@"Are you sure you want to Cancel Booking?"
             cancelButtonTitle:@"No"
             otherButtonTitles:@[@"Yes"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == [alertView cancelButtonIndex]) {
                              NSLog(@"Cancelled");
                          } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Yes"]) {
                              NSLog(@"Have a cold beer");
                              
                              [self getDatas];
                              
                           
                          }
                      }];
    

    
}

-(void)getDatas
{
    [ProgressHUD show:nil Interaction:NO];
    
    //[MBProgressHUD show];
    
    NSString *uniqueString =  [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"];
    NSString *jobId =  [[NSUserDefaults standardUserDefaults]stringForKey:@"RECENT_JOB_ID"];
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:uniqueString forKey:@"userId"];
    [parameters setObject:jobId forKey:@"jobId"];
   
    
    
    NSLog(@"Params:%@",parameters);
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@/CancelReasonMessage",ApiBaseURL];
    
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
        
       NSMutableArray *cabsInfo = [[NSMutableArray alloc]init];
        
        if ([[JSON valueForKey:@"status"] intValue]!=1)
        {
            [ProgressHUD showError:[NSString stringWithFormat:@"%@",[JSON valueForKey:@"message"]]];
        }
        else
        {
            
            
            [cabsInfo addObjectsFromArray:[JSON valueForKey:@"listReason"]];
            
            [ProgressHUD dismiss];
            
        }
        
        NSMutableArray *tempArr=[[NSMutableArray alloc]init];
        
        for (int i=0; i<[cabsInfo count]; i++) {
            
            NSDictionary *temp=cabsInfo[i];
            
            
            [tempArr addObject:[temp valueForKey:@"content"]] ;
            
          
        }
        
        
        LeveyPopListView *lplv = [[LeveyPopListView alloc] initWithTitle:@"Please Select Reason" options:tempArr handler:^(NSInteger anIndex)
                                  {
                                      
                                      [ProgressHUD show:nil Interaction:NO];
                                      
                                      NSDictionary *temp=cabsInfo[anIndex];
                                      
                                      NSLog(@"ID:%@",[temp valueForKey:@"content"]);
                                       NSLog(@"ID:%@",[temp valueForKey:@"id"]);
                                      
                                      NSString *uniqueString =  [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"];
                                      NSString *jobId =  [[NSUserDefaults standardUserDefaults]stringForKey:@"RECENT_JOB_ID"];
                                      
                                      
                                      NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
                                      [parameters setObject:uniqueString forKey:@"userId"];
                                      [parameters setObject:jobId forKey:@"jobId"];
                                       [parameters setObject:[temp valueForKey:@"id"] forKey:@"reasonId"];
                                      
                                      
                                      
                                      NSLog(@"Params:%@",parameters);
                                      
                                      
                                      NSString *urlString=[NSString stringWithFormat:@"%@/CancelRide",ApiBaseURL];
                                      
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
                                                NSString *jobId =  [[NSUserDefaults standardUserDefaults]stringForKey:@"RECENT_JOB_ID"];
                                              
                                              [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",@""] forKey:@"RECENT_JOB_ID"];
                                              DashboardViewController *dashObj =[[DashboardViewController alloc]init];
                                              [self.navigationController pushViewController:dashObj animated:NO];
                                              
                                              [ProgressHUD showSuccess:[NSString stringWithFormat:@"You have successfully cancelled your job No:%@",jobId]];
                                              
                                          }
                                          
                                         
                                          
                                          
                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                          NSLog(@"Error: %@", error);
                                          
                                          
                                          [ProgressHUD showError:error.localizedDescription];
                                          
                                          
                                      }];
                                      
                                      //[tempArr addObject:[temp valueForKey:@"content"]] ;
                                      
                                  }];
        //    lplv.delegate = self;
        [lplv showInView:self.view animated:YES];
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    
}


-(void)start
{
    // timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    [self timerFired];
}
-(void)timerFired
{
    if((currMinute>0 || currSeconds>=0) && currMinute>=0)
    {
        if(currSeconds==0)
        {
            currMinute-=1;
            currSeconds=59;
        }
        else if(currSeconds>0)
        {
            currSeconds-=1;
        }
        if(currMinute>-1)
            [_progress setText:[NSString stringWithFormat:@"%@%d%@%02d",@"",currMinute,@":",currSeconds]];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:_progress.text forKey:@"TIMER"];
    }
    else
    {
        currMinute=10;
        currSeconds=00;
       // [timer invalidate];
    }
}


@end
