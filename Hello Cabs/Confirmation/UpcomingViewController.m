//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "UpcomingViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "AFNetworking.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>

@interface UpcomingViewController()<MKMapViewDelegate>
{
   CLLocationCoordinate2D coordinate;
    
    double fromLocLat;
    double fromLocLong;
    
    MKPolyline *_routeOverlay;
    MKRoute *_currentRoute;
    double toLocLat;
    double toLocLong;
    
    double fromLocLat1;
    double fromLocLong1;
    
    UIImage *screenShot;
}
@end

@implementation UpcomingViewController

int tagValueNewNewNew;
NSTimer * timerNewTwo;

NSString *mobileNo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tagValueNewNewNew = 0;
    
    _viewFav.hidden = YES;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startMonitoringSignificantLocationChanges];
    [locationManager startUpdatingLocation];
    self.navigationController.navigationBarHidden = TRUE;
    self.mapObj.showsUserLocation = YES;
    
  
    
    [self assignView:_view1];
    [self assignView:_view2];
    [self assignView:_view3];
    [self assignView:_view4];
    
    [self assignView:_viewFav];
    
    
   
   [_webView stringByEvaluatingJavaScriptFromString:@"window.alert=null;"];
    
    [self timerFiredNew];
    
   // timerNewTwo=[NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(timerFiredNew) userInfo:nil repeats:YES];
    
     timerNewTwo=[NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(timerFiredNew) userInfo:nil repeats:YES];
    
    // Do any additional setup after loading the view, typically from a nib.
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
        
        NSString *statusOfVehicle = [JSON valueForKeyPath:@"statusBookingId"];
        
        if([statusOfVehicle intValue]!=0)
        {
        
        if([statusOfVehicle intValue]==2 || [statusOfVehicle intValue]==2)
        {
            _topLabel.text = @"Driver Enroute";
            
            
            _starRating.rating = 2;
            
            _viewAccept.frame = CGRectMake(0, 0, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
            
            [self.bottomView addSubview:_viewAccept];
            
            _viewPending.hidden = YES;
            _viewAccept.hidden = NO;
            _viewPickup.hidden = YES;
            _viewTracking.hidden = YES;
            
            
            fromLocLat1 = [[JSON valueForKeyPath:@"pickupLat"] doubleValue];
            fromLocLong1 = [[JSON valueForKeyPath:@"pickupLong"] doubleValue];
            
            _lblCabNo.text = [JSON valueForKeyPath:@"cabNo"];
            _lblDriverName.text = [JSON valueForKeyPath:@"driverName"];
            mobileNo = [JSON valueForKeyPath:@"driverMobileNo"];
            
            _lblETA.hidden = YES;
            _labelETA.hidden = YES;
            
            
            
            //[ProgressHUD showSuccess:[NSString stringWithFormat:@"%@",[JSON valueForKey:@"message"]]];
            
          //  timerNewTwo=[NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(timerFiredNewHello) userInfo:nil repeats:YES];
            [self timerFiredNewHello];
            
           
            
            
            if([statusOfVehicle intValue]==3)
            {
                //_topLabel.text = @"Tracking";
                
                
                
            }
        }
        
        
        if([statusOfVehicle intValue]==4 || [statusOfVehicle intValue]==5)
        {
            _topLabel.text = @"Driver has Arrived";
            
            _viewPickup.frame = CGRectMake(0, 0, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
            
            [self.bottomView addSubview:_viewPickup];
            
            _viewPending.hidden = YES;
            _viewAccept.hidden = YES;
            _viewPickup.hidden =NO;
            _viewTracking.hidden = YES;
            
            _lblCabNoNew.text = [JSON valueForKeyPath:@"cabNo"];
            _lblDriverNameNew.text = [JSON valueForKeyPath:@"driverName"];
            mobileNo = [JSON valueForKeyPath:@"driverMobileNo"];
            
            _lblETA.hidden = YES;
            _labelETA.hidden = YES;
            
            
          //  [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@",[JSON valueForKey:@"message"]]];
            
            
           // timerNewTwo=[NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(timerFiredNewHello) userInfo:nil repeats:YES];
            [self timerFiredNewHello];
            
            if([statusOfVehicle intValue]==5)
            {
                _topLabel.text = @"End Trip";
            }
            
        }
        }
        else
        {
            
            [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@",@"Your Trip Ended"]];
            
            
            
            
            
            DashboardViewController *signObj =[[DashboardViewController alloc]init];
            [self.navigationController pushViewController:signObj animated:YES];

             [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",@""] forKey:@"RECENT_JOB_ID"];
            
            [timerNewTwo invalidate];
        }
        
        /*
        CLLocationCoordinate2D track;
        track.latitude = toLocLat;
        track.longitude = toLocLong;
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.03;
        span.longitudeDelta = 0.03;
        region.span = span;
        region.center = track;
        [self.mapObj setRegion:region animated:TRUE];
        [self.mapObj regionThatFits:region];*/
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        // [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    
}






-(void)timerFiredNewHello
{
    NSString *uniqueString =  [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"];
    
    
    
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:uniqueString forKey:@"userId"];
    
    NSString *jobId =  [[NSUserDefaults standardUserDefaults]stringForKey:@"RECENT_JOB_ID"];
    
    [parameters setObject:@"3" forKey:@"statusBookingId"];
    
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
        
        NSLog(@"JSON AAA:%@",JSON);
        
        NSString *statusOfVehicle = [JSON valueForKeyPath:@"statusBookingId"];
        
        
        if([statusOfVehicle intValue]==2 || [statusOfVehicle intValue]==3)
        {
           // _topLabel.text = @"Vehicle accepted by driver";
            
          
            
            toLocLat = [[JSON valueForKeyPath:@"lat"] doubleValue];
            toLocLong = [[JSON valueForKeyPath:@"lon"] doubleValue];
            
           // _lblCabNo.text = [JSON valueForKeyPath:@"cabNo"];
          //  _lblDriverName.text = [JSON valueForKeyPath:@"driverName"];
          //  mobileNo = [JSON valueForKeyPath:@"driverMobileNo"];
            
            _lblETA.hidden = NO;
            _labelETA.hidden = NO;
            
            if([_topLabel.text isEqualToString:@"Driver has Arrived"])
            {
                _lblETA.hidden = YES;
                _labelETA.hidden = YES;
            }
            
            _lblETA.text = [JSON valueForKeyPath:@"ETA"];
            
          //  timerNewTwo=[NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(timerFiredNewHello) userInfo:nil repeats:YES];
            
            
            if([statusOfVehicle intValue]==3)
            {
                //_topLabel.text = @"Tracking";
                
                
                
            }
        }
        
        /*
         if([statusOfVehicle intValue]==4 || [statusOfVehicle intValue]==5)
         {
         _topLabel.text = @"Pickup By driver";
         
         _viewPickup.frame = CGRectMake(0, 0, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
         
         [self.bottomView addSubview:_viewPickup];
         
         _viewPending.hidden = YES;
         _viewAccept.hidden = YES;
         _viewPickup.hidden =NO;
         _viewTracking.hidden = YES;
         
         if([statusOfVehicle intValue]==5)
         {
         _topLabel.text = @"End Trip";
         }
         
         }
         */
        
        /*
        CLLocationCoordinate2D track;
        track.latitude = toLocLat;
        track.longitude = toLocLong;
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.03;
        span.longitudeDelta = 0.03;
        region.span = span;
        region.center = track;
        [self.mapObj setRegion:region animated:TRUE];
        [self.mapObj regionThatFits:region];
        */
        [self drawMap];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        // [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    
}

-(void)drawMap
{
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"codebeautify"
                                                     ofType:@"html"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    
   // content=[content stringByReplacingOccurrencesOfString:@"SOURCE" withString:[NSString stringWithFormat:@"%f,%f",_mapObj.userLocation.location.coordinate.latitude,_mapObj.userLocation.location.coordinate.longitude]];
    
    content=[content stringByReplacingOccurrencesOfString:@"DESTINATION_H" withString:[NSString stringWithFormat:@"%f,%f",toLocLat,toLocLong]];
    
    if (fromLocLat1 == 0.000000 && fromLocLong1 == 0.000000)
    {
        fromLocLat1 = fromLocLat;
        fromLocLong1 = fromLocLong;
    }
    
    content=[content stringByReplacingOccurrencesOfString:@"SOURCE_H" withString:[NSString stringWithFormat:@"%f,%f",fromLocLat1,fromLocLong1]];
    
    content=[content stringByReplacingOccurrencesOfString:@"google.maps.DirectionsTravelMode.WALKING" withString:@"google.maps.DirectionsTravelMode.DRIVING"];
    
    if (IS_IPHONE_6)
    {
        content=[content stringByReplacingOccurrencesOfString:@"height: 685px;" withString:@"height: 420px;"];
        content=[content stringByReplacingOccurrencesOfString:@"width: 1004px;" withString:@"width: 360px;"];
        _mapImg.frame = _webView.frame;
    }
    else if (IS_IPHONE_5)
    {
        content=[content stringByReplacingOccurrencesOfString:@"height: 685px;" withString:@"height: 445px;"];
        content=[content stringByReplacingOccurrencesOfString:@"width: 1004px;" withString:@"width: 305px;"];
        _mapImg.frame = _webView.frame;
    }
    else if (IS_IPHONE_6P)
    {
        CGRect frame = _webView.frame;
        frame.origin.x = 10.0;
        frame.origin.y = 0;
        _webView.frame = frame;
        content=[content stringByReplacingOccurrencesOfString:@"height: 685px;" withString:@"height: 456px;"];
        content=[content stringByReplacingOccurrencesOfString:@"width: 1004px;" withString:@"width: 395px;"];
        _mapImg.frame = _webView.frame;
    }
    else
    {
        content=[content stringByReplacingOccurrencesOfString:@"height: 685px;" withString:@"height: 445px;"];
        content=[content stringByReplacingOccurrencesOfString:@"width: 1004px;" withString:@"width: 305px;"];
        _mapImg.frame = _webView.frame;
    }
    
    [_webView loadHTMLString:content baseURL:nil];
    
    
    NSLog(@"Lat:Long:%f,%f",fromLocLat1,fromLocLong1);
    
  
    
    NSLog(@"Lat:Long:%f,%f",toLocLat,toLocLong);
    
    
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    if (screenShot != nil)
    {
        _mapImg.image = screenShot;
        self.mapImg.hidden = false;
        webView.hidden = true;
    }
    else
    {
        webView.hidden = false;
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    webView.hidden = false;
    UIGraphicsBeginImageContext(CGSizeMake(webView.frame.size.width,webView.frame.size.height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [webView.layer renderInContext:context];
    screenShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    self.mapImg.hidden = true;

}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.mapImg.hidden = true;
    webView.hidden = false;
}


#pragma mark - Utility Methods
- (void)plotRouteOnMap:(MKRoute *)route
{
    if(_routeOverlay) {
        [self.mapObj removeOverlay:_routeOverlay];
    }
    
    // Update the ivar
    _routeOverlay = route.polyline;
    
    // Add it to the map
    [self.mapObj addOverlay:_routeOverlay];
    
}


#pragma mark - MKMapViewDelegate methods
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    renderer.strokeColor = [UIColor redColor];
    renderer.lineWidth = 4.0;
    return  renderer;
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
        
        
        LeveyPopListView *lplv = [[LeveyPopListView alloc] initWithTitle:@"Select Reason" options:tempArr handler:^(NSInteger anIndex)
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



-(void)assignView:(UIView *)view
{
    view.layer.cornerRadius = 3.0;
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.layer.masksToBounds = YES;
}





- (IBAction)backBtn:(id)sender
{
    
 [self.navigationController popViewControllerAnimated:YES];
    
}





- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = locations[[locations count] -1];
    CLLocation *currentLocation = newLocation;
    NSString *longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    
    if (currentLocation != nil)
    {
        [locationManager stopUpdatingLocation];
        CLLocationCoordinate2D track;
        track.latitude = [latitude doubleValue];
        track.longitude = [longitude doubleValue];
        
        fromLocLat1 = [latitude doubleValue];
        fromLocLong1 = [longitude doubleValue];
        
        MKCoordinateRegion region;
        MKCoordinateSpan span;
         span.latitudeDelta = 0.001;
        span.longitudeDelta = 0.001;
        region.span = span;
        region.center = track;
        [self.mapObj setRegion:region animated:TRUE];
        [self.mapObj regionThatFits:region];
        
        
    }
    else
    {
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle:@"Error" message:@"Failed to Get Your Location"
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
    }
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    CLLocationCoordinate2D center = self.mapObj.centerCoordinate;
    CLLocation *location = [[CLLocation alloc] initWithLatitude:center.latitude longitude:center.longitude];
    
    /*
    
    [self getAddressFromLocation:location complationBlock:^(NSString * address)
     {
         if(address)
         {
             
             if(tagValueNewNewNew==0)
             {
             
             self.toAddress.text =[NSString stringWithFormat:@"%@",address];
                 
                 toLocLat = center.latitude;
                 toLocLong = center.longitude;
                 
             }
         }
             
         
         
         
     }];
     
     */
}
typedef void(^addressCompletion)(NSString *);

-(void)getAddressFromLocation:(CLLocation *)location complationBlock:(addressCompletion)completionBlock
{
    __block CLPlacemark* placemark;
    __block NSString *address = nil;
    
    CLGeocoder* geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error == nil && [placemarks count] > 0)
         {
             
             
             placemark = [placemarks lastObject];
             address = [NSString stringWithFormat:@"%@, %@, %@", placemark.subLocality,placemark.subAdministrativeArea,placemark.country];
             completionBlock(address);
         }
     }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)userLocation:(id)sender
{
    [locationManager startUpdatingLocation];
    self.mapObj.showsUserLocation = YES;
}


- (IBAction)clickFromFav:(id)sender {
    newSegment.selectedSegmentIndex = 0;
    
    _viewFav.hidden = NO;
    _txtSegment.hidden = YES;
    _txtAddressSegment.text = _fromAddress.text;
}

- (IBAction)clickToFav:(id)sender {
    newSegment.selectedSegmentIndex = 0;
    
    _viewFav.hidden = NO;
    _txtSegment.hidden = YES;
    _txtAddressSegment.text = _toAddress.text;
}

- (IBAction)clickFrom:(id)sender {
    
    tagValueNewNewNew = 1;
    
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];

}

- (IBAction)clickTo:(id)sender {
    
   
    
    if(_segmentControl.selectedSegmentIndex == 0)
    {
    
    tagValueNewNewNew = 2;
    
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
    }
}
- (IBAction)segmentChange:(id)sender {
    
    if(_segmentControl.selectedSegmentIndex == 1)
    {
        
        _toAddress.text = @"Kempegowda International Airport (BLR)";
        
        toLocLat = 13.199379;
        toLocLong = 77.710136;
        
        _toAddress.enabled = FALSE;
    }
    else
    {
         _toAddress.enabled = TRUE;
        
        _toAddress.text = nil;
        
        toLocLat = 0;
        toLocLong = 0;

    }
    
}
- (IBAction)clickRideNow:(id)sender {
    
    
    
    [UIAlertView showWithTitle:@"Cancel Booking"
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

    
    /*
        NSLog(@"Booking Screen");
        
        NSLog(@"From:%f,%f",fromLocLat,fromLocLong);
        NSLog(@"TO:%f,%f",toLocLat,toLocLong);
        NSLog(@"From Address:%@",_fromAddress.text);
         NSLog(@"From Address:%@",_toAddress.text);
    
  NSString  *dataDate = [[NSUserDefaults standardUserDefaults]valueForKey:@"PICKUP_TIME"];
    
    [ProgressHUD show:nil Interaction:NO];
    
    //[MBProgressHUD show];
    
    NSString *uniqueString =  [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"];
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:uniqueString forKey:@"userId"];
    [parameters setObject:[NSString stringWithFormat:@"%@",dataDate] forKey:@"datetime"];
     [parameters setObject:[NSString stringWithFormat:@"%f",fromLocLat] forKey:@"pickUpLatitude"];
     [parameters setObject:[NSString stringWithFormat:@"%f",fromLocLong] forKey:@"pickUpLongitude"];
    [parameters setObject:[NSString stringWithFormat:@"%f",toLocLat] forKey:@"dropLatitude"];
    [parameters setObject:[NSString stringWithFormat:@"%f",toLocLong] forKey:@"dropLongitude"];
    
     [parameters setObject:[NSString stringWithFormat:@"%@",_fromAddress.text] forKey:@"pickUpLocation"];
     [parameters setObject:[NSString stringWithFormat:@"%@",_toAddress.text] forKey:@"dropLocation"];
    [parameters setObject:[NSString stringWithFormat:@"%@",_txtSegment.text] forKey:@"driverNote"];
    
    
    
    NSLog(@"Params:%@",parameters);
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@/BookCab",ApiBaseURL];
    
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
            
            
            [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@",[JSON valueForKey:@"message"]]];

            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[JSON valueForKey:@"JobId"]] forKey:@"RECENT_JOB_ID"];
            
            TimerViewController *dashObj =[[TimerViewController alloc]init];
            [self.navigationController pushViewController:dashObj animated:YES];
            

            
        }
        
        
      
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    */
}

- (IBAction)clickRideLater:(id)sender {
    
    
    [UIAlertView showWithTitle:@"Confirm Call"
                       message:@"Are you sure you want to Call Driver?"
             cancelButtonTitle:@"No"
             otherButtonTitles:@[@"Yes"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == [alertView cancelButtonIndex]) {
                              NSLog(@"Cancelled");
                          } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Yes"]) {
                              NSLog(@"Have a cold beer");
                              
                              NSString *phoneNumber = [@"tel://" stringByAppendingString:mobileNo];
                              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
                              
                              
                          }
                      }];
    
  
}

- (IBAction)clickHelloCar:(id)sender {
    
    RateCardViewController *dashObj =[[RateCardViewController alloc]init];
    [self.navigationController pushViewController:dashObj animated:YES];
    
    
}
- (IBAction)clickPremier:(id)sender {
    
    [ProgressHUD showSuccess:@"Coming Soon"];
    
}

- (IBAction)clickShare:(id)sender {
}


// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place);
    NSLog(@"lat and log%f", place.coordinate.latitude);
    NSLog(@"lang %f", place.coordinate.longitude);
    
    
    if(tagValueNewNewNew == 1)
    {
    
    fromLocLat = place.coordinate.latitude;
    fromLocLong = place.coordinate.longitude;
    
    _fromAddress.text = [NSString stringWithFormat:@"%@",place.formattedAddress];
        
        
        CLLocationCoordinate2D track;
        track.latitude = fromLocLat;
        track.longitude = fromLocLong;
        MKCoordinateRegion region;
        MKCoordinateSpan span;
         span.latitudeDelta = 0.001;
        span.longitudeDelta = 0.001;
        region.span = span;
        region.center = track;
        [self.mapObj setRegion:region animated:TRUE];
        [self.mapObj regionThatFits:region];
        
    }
    else
    {
        toLocLat = place.coordinate.latitude;
        toLocLong = place.coordinate.longitude;
        
        CLLocationCoordinate2D track;
        track.latitude = toLocLat;
        track.longitude = toLocLong;
        MKCoordinateRegion region;
        MKCoordinateSpan span;
         span.latitudeDelta = 0.001;
        span.longitudeDelta = 0.001;
        region.span = span;
        region.center = track;
        [self.mapObj setRegion:region animated:TRUE];
        [self.mapObj regionThatFits:region];
        
        _toAddress.text = [NSString stringWithFormat:@"%@",place.formattedAddress];
    }
    
   // tagValueNewNewNew = 0;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    // TODO: handle the error.
    NSLog(@"error: %ld", [error code]);
    [self dismissViewControllerAnimated:YES completion:nil];
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    NSLog(@"Autocomplete was cancelled.");
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)clickCancel:(id)sender {
    
    _viewFav.hidden = YES;
    
}

- (IBAction)clickSave:(id)sender {
    
    if(newSegment.selectedSegmentIndex==2)
    {
        if([_txtSegment.text isEqualToString:@""])
        {
             [ProgressHUD showError:@"Please Type Favorite Name."];
        }
        else
        {
             _viewFav.hidden = YES;
        }
    }
    else
    {
         _viewFav.hidden = YES;
    }
    
}

- (IBAction)newSegmentChanged:(id)sender {
    
    
    if(newSegment.selectedSegmentIndex == 0)
    {
        _imgSegment.image = [UIImage imageNamed:@"home_fav.png"];
        _txtSegment.hidden = YES;
    }
    if(newSegment.selectedSegmentIndex == 1)
    {
        _imgSegment.image = [UIImage imageNamed:@"workicon.png"];
        _txtSegment.hidden = YES;
    }
    if(newSegment.selectedSegmentIndex == 2)
    {
        _imgSegment.image = [UIImage imageNamed:@"heartfav.png"];
        _txtSegment.hidden = NO;
    }
}

- (IBAction)cancelBooking:(id)sender {
}


- (IBAction)clickViewBill:(id)sender {
    
    
    [[NSUserDefaults standardUserDefaults]setObject:_lblDriverName.text forKey:@"DRIVER_NAME"];
    
    CompletedViewController *signObj =[[CompletedViewController alloc]init];
    [self.navigationController pushViewController:signObj animated:YES];
}
@end
