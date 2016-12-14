//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "TimeViewController.h"

#import "AFNetworking.h"

#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT

@interface TimeViewController ()
{
   
    NSMutableArray *dataArray;
    
    NSMutableArray *dataArrayNew;
    
    NSMutableArray *checkMarkArrayNew;
    int totalChecked;
    
    int currentIndex;
}
@end

@implementation TimeViewController

NSMutableArray *historyInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc]
                                                  initWithTarget:self
                                                  action:@selector(handleSwipeLeft:)];
    [swipeLeftGesture setDirection: UISwipeGestureRecognizerDirectionLeft];
    
    UISwipeGestureRecognizer *swipeRightGesture = [[UISwipeGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(handleSwipeRight:)];
    
    [swipeRightGesture setDirection: UISwipeGestureRecognizerDirectionRight];
    
    [self.tblView addGestureRecognizer:swipeLeftGesture];
    [self.tblView  addGestureRecognizer:swipeRightGesture];
    
    
    
    
    self.topView.layer.masksToBounds = NO;
    self.topView.layer.shadowOffset = CGSizeMake(0, 3);
    self.topView.layer.shadowRadius = 5;
    self.topView.layer.shadowOpacity = 0.5;
    
    currentIndex = 0;
    pageControlObj.iFirstVisiblePageNumber  = currentIndex;
    
    [pageControlObj.view removeFromSuperview];
    
    
    //page 0
    ADPageModel *pageModel0 = [[ADPageModel alloc] init];
    
    pageModel0.strPageTitle = @"UPCOMING";
    pageModel0.iPageNumber = 0;
    pageModel0.bShouldLazyLoad = YES;
    
    //page 1
    ADPageModel *pageModel1 = [[ADPageModel alloc] init];
    pageModel1.strPageTitle = @"COMPLETED";
    pageModel1.iPageNumber = 1;
    pageModel1.bShouldLazyLoad = YES;
    
    //page 2
    ADPageModel *pageModel2 = [[ADPageModel alloc] init];
    pageModel2.strPageTitle = @"CANCELLED";
    pageModel2.iPageNumber = 2;
    pageModel2.bShouldLazyLoad = YES;
    
    
    pageControlObj = [[ADPageControl alloc] init];
    pageControlObj.delegateADPageControl = self;
    pageControlObj.arrPageModel = [[NSMutableArray alloc] initWithObjects:pageModel0,pageModel1,pageModel2, nil];
    
    /**** 3. Customize parameters (Optinal, as all have default value set) ****/
    
    pageControlObj.iFirstVisiblePageNumber = currentIndex;
    
    
    
    pageControlObj.iTitleViewHeight = 45;
    pageControlObj.iPageIndicatorHeight = 4;
    pageControlObj.fontTitleTabText =  [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
    pageControlObj.bEnablePagesEndBounceEffect = NO;
    pageControlObj.bEnableTitlesEndBounceEffect = NO;
    pageControlObj.colorTabText = [UIColor colorWithRed:241.0/255.0 green:190.0/255.0 blue:70.0/255.0 alpha:1.0f];
    pageControlObj.colorTitleBarBackground = [UIColor colorWithRed:42.0/255.0 green:51.0/255.0 blue:132.0/255.0 alpha:1.0f];
    pageControlObj.colorPageIndicator = [UIColor colorWithRed:241.0/255.0 green:190.0/255.0 blue:70.0/255.0 alpha:1.0f];
    
    pageControlObj.colorPageOverscrollBackground = [UIColor colorWithRed:42.0/255.0 green:51.0/255.0 blue:132.0/255.0 alpha:1.0f];
    pageControlObj.bShowMoreTabAvailableIndicator = NO;
    
    pageControlObj.view.frame = CGRectMake(0, 5, self.viewPageControl.frame.size.width, self.viewPageControl.frame.size.height);
    
    [self.viewPageControl addSubview:pageControlObj.view];
    
    //[self getDatas:@"upcoming"];
    
    
    if([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"LANGUAGE"] ]  isEqualToString:@"EN"])
    {
        
        _lblTopLabel.text = @"My Rides";
    }
    else
    {
        _lblTopLabel.text = @"အေျခအေန";
        
    }
 
    
}

- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Left");
    if(currentIndex != 3-1)
    {
        currentIndex = currentIndex + 1;
       pageControlObj.iFirstVisiblePageNumber  = currentIndex;
        
        [pageControlObj.view removeFromSuperview];
        
        
        //page 0
        ADPageModel *pageModel0 = [[ADPageModel alloc] init];
        
        pageModel0.strPageTitle = @"UPCOMING";
        pageModel0.iPageNumber = 0;
        pageModel0.bShouldLazyLoad = YES;
        
        //page 1
        ADPageModel *pageModel1 = [[ADPageModel alloc] init];
        pageModel1.strPageTitle = @"COMPLETED";
        pageModel1.iPageNumber = 1;
        pageModel1.bShouldLazyLoad = YES;
        
        //page 2
        ADPageModel *pageModel2 = [[ADPageModel alloc] init];
        pageModel2.strPageTitle = @"CANCELLED";
        pageModel2.iPageNumber = 2;
        pageModel2.bShouldLazyLoad = YES;
        
        
        pageControlObj = [[ADPageControl alloc] init];
        pageControlObj.delegateADPageControl = self;
        pageControlObj.arrPageModel = [[NSMutableArray alloc] initWithObjects:pageModel0,pageModel1,pageModel2, nil];
        
        /**** 3. Customize parameters (Optinal, as all have default value set) ****/
        
        pageControlObj.iFirstVisiblePageNumber = currentIndex;
        
        
        
        pageControlObj.iTitleViewHeight = 45;
        pageControlObj.iPageIndicatorHeight = 4;
        pageControlObj.fontTitleTabText =  [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
        pageControlObj.bEnablePagesEndBounceEffect = NO;
        pageControlObj.bEnableTitlesEndBounceEffect = NO;
        pageControlObj.colorTabText = [UIColor colorWithRed:241.0/255.0 green:190.0/255.0 blue:70.0/255.0 alpha:1.0f];
        pageControlObj.colorTitleBarBackground = [UIColor colorWithRed:42.0/255.0 green:51.0/255.0 blue:132.0/255.0 alpha:1.0f];
        pageControlObj.colorPageIndicator = [UIColor colorWithRed:241.0/255.0 green:190.0/255.0 blue:70.0/255.0 alpha:1.0f];
        
        pageControlObj.colorPageOverscrollBackground = [UIColor colorWithRed:42.0/255.0 green:51.0/255.0 blue:132.0/255.0 alpha:1.0f];

        pageControlObj.bShowMoreTabAvailableIndicator = NO;
        
        pageControlObj.view.frame = CGRectMake(0, 5, self.viewPageControl.frame.size.width, self.viewPageControl.frame.size.height);
        
        [self.viewPageControl addSubview:pageControlObj.view];
        

        if(currentIndex == 0)
        {
             [self getDatas:@"upcoming"];
        }
        if(currentIndex == 1)
        {
             [self getDatas:@"completed"];
        }
        if(currentIndex == 2)
        {
             [self getDatas:@"cancel"];
        }
        
    
    }
    else
    {
        
    }
}

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)recognizer {
    
    NSLog(@"Right");
    
    if(currentIndex != 0)
    {
        
        currentIndex = currentIndex - 1;
        
        
        [pageControlObj.view removeFromSuperview];
        
        
        
        //page 0
        ADPageModel *pageModel0 = [[ADPageModel alloc] init];
        
        pageModel0.strPageTitle = @"UPCOMING";
        pageModel0.iPageNumber = 0;
        pageModel0.bShouldLazyLoad = YES;
        
        //page 1
        ADPageModel *pageModel1 = [[ADPageModel alloc] init];
        pageModel1.strPageTitle = @"COMPLETED";
        pageModel1.iPageNumber = 1;
        pageModel1.bShouldLazyLoad = YES;
        
        //page 2
        ADPageModel *pageModel2 = [[ADPageModel alloc] init];
        pageModel2.strPageTitle = @"CANCELLED";
        pageModel2.iPageNumber = 2;
        pageModel2.bShouldLazyLoad = YES;
        
        
        pageControlObj = [[ADPageControl alloc] init];
        pageControlObj.delegateADPageControl = self;
        pageControlObj.arrPageModel = [[NSMutableArray alloc] initWithObjects:pageModel0,pageModel1,pageModel2, nil];
        

        
        /**** 3. Customize parameters (Optinal, as all have default value set) ****/
        
        pageControlObj.iFirstVisiblePageNumber = currentIndex;
        
        
        
        pageControlObj.iTitleViewHeight = 45;
        pageControlObj.iPageIndicatorHeight = 4;
        pageControlObj.fontTitleTabText =  [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
        pageControlObj.bEnablePagesEndBounceEffect = NO;
        pageControlObj.bEnableTitlesEndBounceEffect = NO;
        pageControlObj.colorTabText = [UIColor colorWithRed:241.0/255.0 green:190.0/255.0 blue:70.0/255.0 alpha:1.0f];
        pageControlObj.colorTitleBarBackground = [UIColor colorWithRed:42.0/255.0 green:51.0/255.0 blue:132.0/255.0 alpha:1.0f];
        pageControlObj.colorPageIndicator = [UIColor colorWithRed:241.0/255.0 green:190.0/255.0 blue:70.0/255.0 alpha:1.0f];
        
        pageControlObj.colorPageOverscrollBackground = [UIColor colorWithRed:42.0/255.0 green:51.0/255.0 blue:132.0/255.0 alpha:1.0f];

        pageControlObj.bShowMoreTabAvailableIndicator = NO;
        
        pageControlObj.view.frame = CGRectMake(0, 5, self.viewPageControl.frame.size.width, self.viewPageControl.frame.size.height);
        
        [self.viewPageControl addSubview:pageControlObj.view];
        
        if(currentIndex == 0)
        {
            [self getDatas:@"upcoming"];
        }
        if(currentIndex == 1)
        {
            [self getDatas:@"completed"];
        }
        if(currentIndex == 2)
        {
            [self getDatas:@"cancel"];
        }

    }
    else
    {
        currentIndex = 0;
    }
    
}




-(UIViewController *)adPageControlGetViewControllerForPageModel:(ADPageModel *) pageModel
{
    
    
    
    
    return nil;
}

-(void)adPageControlCurrentVisiblePageIndex:(int) iCurrentVisiblePage
{
    NSLog(@"ADPageControl :: Current visible page index : %d",iCurrentVisiblePage);
    
    currentIndex = iCurrentVisiblePage;
    
    if(iCurrentVisiblePage == 0)
    {
        
        [self getDatas:@"upcoming"];
    }
    if(iCurrentVisiblePage == 1)
    {
        [self getDatas:@"completed"];
    }
    if(iCurrentVisiblePage == 2)
    {
        [self getDatas:@"cancel"];
    }
    
    [_tblView reloadData];
    
}

-(void)getDatas:(NSString *)category
{
    
    [ProgressHUD show:nil Interaction:NO];
    
    NSString *uniqueString =  [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"];
   
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    NSString *dayName = [dateFormatter stringFromDate:[NSDate date]];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
  //  [parameters setObject:uniqueString forKey:@"userId"];
    
    
    [parameters setObject:uniqueString forKey:@"userId"];
    
    [parameters setObject:dayName forKey:@"requestTime"];
    [parameters setObject:category forKey:@"category"];
    
    
    //
    
    
    NSLog(@"Params:%@",parameters);
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@/YourRides",ApiBaseURL];
    
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
        
        historyInfo = [[NSMutableArray alloc]init];
        
        if ([[JSON valueForKey:@"status"] intValue]!=1)
        {
            [ProgressHUD showError:[NSString stringWithFormat:@"%@",[JSON valueForKey:@"message"]]];
        }
        else
        {
            
            
            [historyInfo addObjectsFromArray:[JSON valueForKey:@"YourRideInfo"]];
            
            [ProgressHUD dismiss];
            
        }
        
       
        [_tblView reloadData];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    
    
}



- (IBAction)backBtn:(id)sender
{
    

    [self.navigationController popViewControllerAnimated:YES];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [historyInfo count];
    
    //return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    [view setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 5;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    
    
    
    TimeCell * cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil)
    {
        
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"TimeCell" owner:nil options:nil];
        
        for (UIView *view in views)
        {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell1 = (TimeCell*)view;
                //cell.img=@"date.png";
                
            }
        }
    }
    
    
    
    
    cell1.viewInner.layer.cornerRadius = 5;
    cell1.viewInner.layer.masksToBounds = YES;
    
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    NSDictionary *dict = historyInfo[indexPath.row];
    
    
    
    //NSArray* foo = [[dict valueForKeyPath:@"start_time"] componentsSeparatedByString: @":"];
    
    
    cell1.lblTitle.text = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"rideDateTime"]];
    

    
    cell1.selectionStyle = UITableViewCellAccessoryNone;
    
    cell1.lblSubtitle.text = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"pickUpLocation"]];
    
   // cell1.lblSubject.text = [NSString stringWithFormat:@"%@ %@",[dict valueForKeyPath:@"class_name"],[dict valueForKeyPath:@"section_name"]];
   
    
    return cell1;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 114;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [ProgressHUD dismiss];
    
    
    /*
    NSLog(@"Index:%d",currentIndex);
    
    if(currentIndex == 0)
    {
        //[self getDatas:@"upcoming"];
        
        
        UpcomingViewController *signObj =[[UpcomingViewController alloc]init];
        [self.navigationController pushViewController:signObj animated:YES];
    }
    if(currentIndex == 1)
    {
        CompletedViewController *signObj =[[CompletedViewController alloc]init];
        [self.navigationController pushViewController:signObj animated:YES];

    }
    if(currentIndex == 2)
    {
        CencelledViewController *signObj =[[CencelledViewController alloc]init];
        [self.navigationController pushViewController:signObj animated:YES];

    }*/

   
}



@end
