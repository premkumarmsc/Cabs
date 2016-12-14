//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "ConfirmViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "AFNetworking.h"


@interface ConfirmViewController ()
{
   CLLocationCoordinate2D coordinate;
    
    double fromLocLat;
    double fromLocLong;
    
    
    double toLocLat;
    double toLocLong;
}
@end

@implementation ConfirmViewController

int tagValueNew;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tagValueNew = 0;
    
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
    
    
    UIPanGestureRecognizer* panRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDragMap:)];
    [panRec setDelegate:self];
    [self.mapObj addGestureRecognizer:panRec];
    
    [self assignView:_view1];
    [self assignView:_view2];
    [self assignView:_view3];
    [self assignView:_view4];
    
    [self assignView:_viewFav];
    
    
    tagValueNew = 23;
    
    _fromAddress.text = [[NSUserDefaults standardUserDefaults]stringForKey:@"FROM_ADDRESS"];
    
    _toAddress.text = [[NSUserDefaults standardUserDefaults]stringForKey:@"TO_ADDRESS"];
    
    fromLocLat = [[[NSUserDefaults standardUserDefaults]valueForKey:@"FROM_LAT"] doubleValue];
     fromLocLong = [[[NSUserDefaults standardUserDefaults]valueForKey:@"FROM_LONG"] doubleValue];
     toLocLat = [[[NSUserDefaults standardUserDefaults]valueForKey:@"TO_LAT"] doubleValue];
     toLocLong = [[[NSUserDefaults standardUserDefaults]valueForKey:@"TO_LONG"] doubleValue];

    
    if([[[NSUserDefaults standardUserDefaults]stringForKey:@"TYPE"] isEqualToString:@"AIR"])
    {
        _desView.hidden = NO;
        _btnFav.hidden = YES;
    }
    else
    {
        _desView.hidden = YES;
        _btnFav.hidden = NO;
    }
    
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
    
    if([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"LANGUAGE"] ]  isEqualToString:@"EN"])
    {
        
       
        
        _plaRateCard.text = @"Rate Card";
        _plaApplyCoupon.text = @"Apply Coupon";
        _plaConfirmation.text = @"Confirmation";
        _plaConfirmationBooking.text = @"Confirm Booking";
    }
    else
    {
        _plaRateCard.text = @"ႏႈန္းထား";
        _plaApplyCoupon.text = @"Apply Coupon";
        _plaConfirmation.text = @"အတည္ျပဳျခင္း";
        _plaConfirmationBooking.text = @"အတည္ျပဳသည္";

        
    }
    

    
    // Do any additional setup after loading the view, typically from a nib.
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (void)didDragMap:(UIGestureRecognizer*)gestureRecognizer
{
    
    tagValueNew = 0 ;
    
    self.topView.hidden = TRUE;
     self.bottomView.hidden = TRUE;
    _currentIcon.hidden = TRUE;
     _callNewBtn.hidden = TRUE;
    
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        self.topView.hidden = FALSE;
        self.bottomView.hidden = FALSE;
        _currentIcon.hidden = FALSE;
         _callNewBtn.hidden = FALSE;
    }
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
        
        fromLocLat = [latitude doubleValue];
        fromLocLong = [longitude doubleValue];
        
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
    
    [[GMSGeocoder geocoder] reverseGeocodeCoordinate:CLLocationCoordinate2DMake(center.latitude, center.longitude) completionHandler:^(GMSReverseGeocodeResponse *resp, NSError *error)
     {
         NSLog( @"Error is %@", error) ;
         
         if(!error)
         {
             
             if(tagValueNew==0)
             {
                 NSLog( @"%@" , resp.firstResult.addressLine1 ) ;
                 NSLog( @"%@" , resp.firstResult.addressLine2 ) ;
                 
                 NSString *address =[NSString stringWithFormat:@"%@,%@",resp.firstResult.addressLine1,resp.firstResult.addressLine2 ];
                 
                 self.toAddress.text = address;
                 
                 toLocLat = center.latitude;
                 toLocLong = center.longitude;

                 
             }
         }
         
         
     } ] ;
    
    /*[self getAddressFromLocation:location complationBlock:^(NSString * address)
     {
         if(address)
         {
             
             if(tagValueNew==0)
             {
             
                 if([[[NSUserDefaults standardUserDefaults]stringForKey:@"TYPE"] isEqualToString:@"AIR"])
                 {
                     
                 }
                 else
                 {
                     self.toAddress.text =[NSString stringWithFormat:@"%@",address];
                     
                     toLocLat = center.latitude;
                     toLocLong = center.longitude;
                 }
             
                 
             }
         }
             
         
         
         
     }];*/
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
    
    tagValueNew = 1;
    
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];

}

- (IBAction)clickTo:(id)sender {
    
   
    
    if(_segmentControl.selectedSegmentIndex == 0)
    {
    
    tagValueNew = 2;
    
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
            
            
           // [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@",[JSON valueForKey:@"message"]]];
            
            [ProgressHUD dismiss];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                            message:[NSString stringWithFormat:@"%@",[JSON valueForKey:@"message"]]
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];

            

            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[JSON valueForKey:@"JobId"]] forKey:@"RECENT_JOB_ID"];
            
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",@"PENDING"] forKey:@"RECENT_JOB_STATUS"];
            
            TimerViewController *dashObj =[[TimerViewController alloc]init];
            [self.navigationController pushViewController:dashObj animated:YES];
            

            
        }
        
        
      
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    
}

- (IBAction)clickRideLater:(id)sender {
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
    
    
    if(tagValueNew == 1)
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
    
   // tagValueNew = 0;
    
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
- (IBAction)clickfav:(id)sender {
    
    
    NSArray *favArray = [[NSUserDefaults standardUserDefaults]valueForKey:@"FAV_ARRAY"];
    NSArray *favLatArray = [[NSUserDefaults standardUserDefaults]valueForKey:@"FAV_LAT_ARRAY"];
    NSArray *favLongArray = [[NSUserDefaults standardUserDefaults]valueForKey:@"FAV_LONG_ARRAY"];
    NSArray *favTypeArray = [[NSUserDefaults standardUserDefaults]valueForKey:@"FAV_TYPE_ARRAY"];
    
    
    if([favArray count]!=0)
    {
        
        FavViewController *signObj =[[FavViewController alloc]init];
        signObj.delegate = self;
        
        [[NSUserDefaults standardUserDefaults]setObject:@"TO" forKey:@"COME_NEW"];
        
        [self presentViewController:signObj animated:YES completion:nil];
    }
    else
    {
        [ProgressHUD showError:@"No Favorite Available."];
    }
    
}
-(void)processCompleted:(NSString *)text latVa:(NSString *)latVal longVal:(NSString *)longVal type:(NSString *)type
{
    NSLog(@"Text:%@",text);
    NSLog(@"Text:%@",latVal);
    NSLog(@"Text:%@",longVal);
    
    
        
        _toAddress.text = text;
        toLocLat = [latVal doubleValue];
        toLocLong = [longVal doubleValue];
  
}

- (IBAction)clickCall:(id)sender
{
    [UIAlertView showWithTitle:@"Confirm Call"
                       message:@"Are you sure you want to Call?"
             cancelButtonTitle:@"No"
             otherButtonTitles:@[@"Yes"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == [alertView cancelButtonIndex]) {
                              NSLog(@"Cancelled");
                          } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Yes"]) {
                              NSLog(@"Have a cold beer");
                              
                              NSString *phoneNumber = [@"tel://" stringByAppendingString:@"019339111"];
                              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
                          }
                      }];
    
    
}


@end
