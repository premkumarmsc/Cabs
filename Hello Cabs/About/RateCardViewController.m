//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "RateCardViewController.h"

#import "AFNetworking.h"

#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT

@interface RateCardViewController ()
{
   
    NSMutableArray *dataArray;
    
    NSMutableArray *dataArrayNew;
    
    NSMutableArray *checkMarkArrayNew;
    int totalChecked;
    
    int currentIndex;
}
@end

@implementation RateCardViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.topView.layer.masksToBounds = NO;
    self.topView.layer.shadowOffset = CGSizeMake(0, 3);
    self.topView.layer.shadowRadius = 5;
    self.topView.layer.shadowOpacity = 0.5;
    
    
    NSString *url = RateCardURL;
    NSURL *nsUrl = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:nsUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    
    [_webView loadRequest:request];
    
    if([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"LANGUAGE"] ]  isEqualToString:@"EN"])
    {
        
        _lblTopLabel.text = @"Rate Card";
    }
    else
    {
        _lblTopLabel.text = @"ကုိယ္ေရးအခ်က္အလက္";
        
    }
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"start");
    
    [ProgressHUD show:nil Interaction:NO];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"finish");
    
    [ProgressHUD dismiss];
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Error for WEBVIEW: %@", [error description]);
    
    [ProgressHUD dismiss];
}



- (IBAction)backBtn:(id)sender
{
    

    [self.navigationController popViewControllerAnimated:YES];
    
}




@end
