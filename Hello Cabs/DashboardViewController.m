//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "DashboardViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "AFNetworking.h"


@interface DashboardViewController ()
{
   CLLocationCoordinate2D coordinate;
    
    double fromLocLat;
    double fromLocLong;
    
    
    double toLocLat;
    double toLocLong;
    
    
    double commonLocLat;
    double commonLocLong;
}
@end

@implementation DashboardViewController

int tagValue;


NSMutableArray *cabsInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tagValue = 0;
    
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
       
    //UIImageView * roundedView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"wood.jpg"]];
    // Get the Layer of any view
    CALayer * l = [_imgCorner layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:10.0];
    
    // You can even add a border
    [l setBorderWidth:1.0];
    [l setBorderColor:[[UIColor blueColor] CGColor]];
   

    
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)viewWillAppear:(BOOL)animated
{
    if([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"LANGUAGE"] ]  isEqualToString:@"EN"])
    {
        
        [_segmentControl setTitle:@"Local" forSegmentAtIndex:0];
        
        [_segmentControl setTitle:@"Airport" forSegmentAtIndex:1];
        
        _lblRideNow.text = @"Ride Now";
        _lblRideLater.text = @"Ride Later";
    }
    else
    {
        [_segmentControl setTitle:@"ၿမိဳ႕တြင္း" forSegmentAtIndex:0];
        
        [_segmentControl setTitle:@"ေလဆိပ္" forSegmentAtIndex:1];
        
        _lblRideNow.text = @"ယခုစီးမည္";
        _lblRideLater.text = @"ေနာက္မွစီးမည္";
        
    }
}

-(void)getDatas
{
    NSString *uniqueString =  [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"];
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:uniqueString forKey:@"userId"];
    [parameters setObject:[NSString stringWithFormat:@"%f",_mapObj.userLocation.location.coordinate.latitude] forKey:@"latitude"];
    [parameters setObject:[NSString stringWithFormat:@"%f",_mapObj.userLocation.location.coordinate.longitude] forKey:@"longitude"];
    
    
    NSLog(@"Params:%@",parameters);
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@/NearByCabs",ApiBaseURL];
    
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
        
        if ([[JSON valueForKey:@"status"] intValue]!=1)
        {
            [ProgressHUD showError:[NSString stringWithFormat:@"%@",[JSON valueForKey:@"message"]]];
        }
        else
        {
            cabsInfo = [[NSMutableArray alloc]init];
            
            [cabsInfo addObjectsFromArray:[JSON valueForKey:@"nearbycabsInfo"]];
            
            [ProgressHUD dismiss];
            
        }
        
        for(int i = 0; i < cabsInfo.count; i++)
        {
            
            NSDictionary *temp=cabsInfo[i];
            
            [self addPinWithTitle:nil AndCoordinate:[NSString stringWithFormat:@"%@,%@",[temp valueForKey:@"Latitude"],[temp valueForKey:@"Longitude"]]];
        }
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    
}


-(void)addPinWithTitle:(NSString *)title AndCoordinate:(NSString *)strCoordinate
{
    MKPointAnnotation *mapPin = [[MKPointAnnotation alloc] init];
    
    // clear out any white space
    strCoordinate = [strCoordinate stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // convert string into actual latitude and longitude values
    NSArray *components = [strCoordinate componentsSeparatedByString:@","];
    
    double latitude = [components[0] doubleValue];
    double longitude = [components[1] doubleValue];
    
    // setup the map pin with all data and add to map view
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    mapPin.title = @"Hello Cabs";
    mapPin.coordinate = coordinate;
    
    [self.mapObj addAnnotation:mapPin];
}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *pinView = nil;
    if(annotation != self.mapObj.userLocation)
    {
        static NSString *defaultPinID = @"com.invasivecode.pin";
        pinView = (MKAnnotationView *)[self.mapObj dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil )
            pinView = [[MKAnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        
        //pinView.pinColor = MKPinAnnotationColorGreen;
        pinView.canShowCallout = YES;
        //pinView.animatesDrop = YES;
        pinView.image = [UIImage imageNamed:@"car32.png"];    //as suggested by Squatch
    }
    else {
        [self.mapObj.userLocation setTitle:@"I am here"];
    }
    return pinView;
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
    
    CGRect basketTopFrame = _backView.frame;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _backView.frame = basketTopFrame;
                         // basketBottom.frame = basketBottomFrame;
                     }
                     completion:^(BOOL finished)
     {
         //NSLog(@"Done 1233!");
         
         
         
         
     }];
    
    
    
    
    
    
    SideView *sideView=[[SideView alloc]init];
    sideView.delegate= self;
    sideView.frame = self.view.bounds;
    [self.view addSubview:sideView];

    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (void)didDragMap:(UIGestureRecognizer*)gestureRecognizer
{
    
    tagValue = 0 ;
    
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

- (void)didTapSomeButton:(NSString *)getController
{
    NSLog(@"Tabbed:%@",getController);
    
    [ProgressHUD dismiss];
    
    if ([getController isEqualToString:@"My Rides"]) {
        
        TimeViewController *dashObj =[[TimeViewController alloc]init];
        [self.navigationController pushViewController:dashObj animated:YES];
        
        
    }
    
    if ([getController isEqualToString:@"Support"]) {
        
        SupportViewController *dashObj =[[SupportViewController alloc]init];
        [self.navigationController pushViewController:dashObj animated:YES];
        
        
    }
    
    if ([getController isEqualToString:@"Rate Card"]) {
        
        RateCardViewController *dashObj =[[RateCardViewController alloc]init];
        [self.navigationController pushViewController:dashObj animated:YES];
        
        
    }
    
    if ([getController isEqualToString:@"About"]) {
        
        AboutViewController *dashObj =[[AboutViewController alloc]init];
        [self.navigationController pushViewController:dashObj animated:YES];
        
        
    }
    
    if ([getController isEqualToString:@"UserSettings"]) {
        
        
        
        
        ProfileViewController *dashObj =[[ProfileViewController alloc]init];
        [self.navigationController pushViewController:dashObj animated:YES];
        
        
        
        
        
        
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
    
        
        [ProgressHUD show:nil Interaction:NO];
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
    NSLog(@"Zoom Level %f",[self.mapObj getZoomLevel]);

    if ([self.mapObj getZoomLevel] >5)
    {
        CLLocationCoordinate2D center = self.mapObj.centerCoordinate;
        [[GMSGeocoder geocoder] reverseGeocodeCoordinate:center completionHandler:^(GMSReverseGeocodeResponse *resp, NSError *error)
         {
             if(!error)
             {
                 
                 if(tagValue==0)
                 {
                     NSLog( @"%@" , resp.firstResult.addressLine1 ) ;
                     NSLog( @"%@" , resp.firstResult.addressLine2 ) ;
                     
                     NSString *address =[NSString stringWithFormat:@"%@,%@",resp.firstResult.addressLine1,resp.firstResult.addressLine2 ];
                     
                     NSString    *new = [address stringByReplacingOccurrencesOfString: @"Chhattisgarh 494661,India" withString:@""];
                     
                     if([resp.firstResult.addressLine1 isEqualToString:@"Chhattisgarh 494661"])
                     {
                         new = @"";
                     }
                     
                     if ([resp.firstResult.addressLine1 rangeOfString:@"494661"].location != NSNotFound) {
                         NSLog(@"string contain bla");
                         
                         self.fromAddress.text = @"";
                     }
                     else
                     {
                         new = [address stringByReplacingOccurrencesOfString: @"(null)," withString:@""];
                         
                         new = [address stringByReplacingOccurrencesOfString: @"(null)" withString:@""];
                         
                         
                         self.fromAddress.text = new;
                     }
                     fromLocLat = center.latitude;
                     fromLocLong = center.longitude;
                     [self getDatas];
                     
                 }
             }
         } ] ;

    }
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
             
             
             
             
             address = [address stringByReplacingOccurrencesOfString:@"(null),"
                                                  withString:@""];
             
             
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
}


- (IBAction)clickFromFav:(id)sender {
    newSegment.selectedSegmentIndex = 0;
    
    _viewFav.hidden = NO;
    _txtSegment.hidden = YES;
    _txtAddressSegment.text = _fromAddress.text;
    
    commonLocLat = fromLocLat;
    commonLocLong = fromLocLong;
}

- (IBAction)clickToFav:(id)sender {
    newSegment.selectedSegmentIndex = 0;
    
    _viewFav.hidden = NO;
    _txtSegment.hidden = YES;
    _txtAddressSegment.text = _toAddress.text;
    
    
    commonLocLat = toLocLat;
    commonLocLong = toLocLong;
}

- (IBAction)clickFrom:(id)sender {
    
    tagValue = 1;
    
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];

}

- (IBAction)clickTo:(id)sender {
    
   
    
    if(_segmentControl.selectedSegmentIndex == 0)
    {
    
    tagValue = 2;
    
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
    }
}
- (IBAction)segmentChange:(id)sender {
    
    if(_segmentControl.selectedSegmentIndex == 1)
    {
        
        _toAddress.text = @"Mingaladon Township, Yangon, Myanmar (Burma)";
        
        toLocLat = 16.9030555;
        toLocLong = 96.1331284;
        
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
    
    
    if([_toAddress.text isEqualToString:@""])
    {
        [ProgressHUD showError:@"Please select Drop location."];
    }
    else
    {
        NSLog(@"Booking Screen");
        
        NSLog(@"From:%f,%f",fromLocLat,fromLocLong);
        NSLog(@"TO:%f,%f",toLocLat,toLocLong);
        NSLog(@"From Address:%@",_fromAddress.text);
         NSLog(@"From Address:%@",_toAddress.text);
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
        NSString *dayName = [dateFormatter stringFromDate:[NSDate date]];
        
        [[NSUserDefaults standardUserDefaults]setObject:_fromAddress.text forKey:@"FROM_ADDRESS"];
         [[NSUserDefaults standardUserDefaults]setObject:_toAddress.text forKey:@"TO_ADDRESS"];
         [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",fromLocLat] forKey:@"FROM_LAT"];
         [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",fromLocLong] forKey:@"FROM_LONG"];
         [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",toLocLat] forKey:@"TO_LAT"];
         [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",toLocLong] forKey:@"TO_LONG"];
         [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",dayName] forKey:@"PICKUP_TIME"];
        
        if(_segmentControl.selectedSegmentIndex == 1)
        {
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"AIR"] forKey:@"TYPE"];
        }
        if(_segmentControl.selectedSegmentIndex == 0)
        {
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"NORMAL"] forKey:@"TYPE"];
        }
        
        ConfirmViewController *signObj =[[ConfirmViewController alloc]init];
        [self.navigationController pushViewController:signObj animated:YES];

    }
    
}

- (IBAction)clickRideLater:(id)sender {
    
    if([_toAddress.text isEqualToString:@""])
    {
        [ProgressHUD showError:@"Please select Drop location."];
    }
    else
    {
        NSLog(@"Booking Screen");
        
      
        
        
        ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Select Pickup Date & Time" datePickerMode:UIDatePickerModeDateAndTime selectedDate:[NSDate date] minimumDate:[NSDate date]  maximumDate:nil target:self action:@selector(timeWasSelected:element:) origin:sender];
        datePicker.minuteInterval = 5;
        [datePicker showActionSheetPicker];

        
    }
    
}

-(void)timeWasSelected:(NSDate *)selectedTime element:(id)element {
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    NSString *dayName = [dateFormatter stringFromDate:selectedTime];
    
    
    
    long long milliseconds = (long long)([selectedTime timeIntervalSince1970]);
    
    NSLog(@"From:%f,%f",fromLocLat,fromLocLong);
    NSLog(@"TO:%f,%f",toLocLat,toLocLong);
    NSLog(@"From Address:%@",_fromAddress.text);
    NSLog(@"From Address:%@",_toAddress.text);
    
    [[NSUserDefaults standardUserDefaults]setObject:_fromAddress.text forKey:@"FROM_ADDRESS"];
    [[NSUserDefaults standardUserDefaults]setObject:_toAddress.text forKey:@"TO_ADDRESS"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",fromLocLat] forKey:@"FROM_LAT"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",fromLocLong] forKey:@"FROM_LONG"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",toLocLat] forKey:@"TO_LAT"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",toLocLong] forKey:@"TO_LONG"];
   
     [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",dayName] forKey:@"PICKUP_TIME"];
    
    if(_segmentControl.selectedSegmentIndex == 1)
    {
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"AIR"] forKey:@"TYPE"];
    }
    if(_segmentControl.selectedSegmentIndex == 0)
    {
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"NORMAL"] forKey:@"TYPE"];
    }
    
    ConfirmViewController *signObj =[[ConfirmViewController alloc]init];
    [self.navigationController pushViewController:signObj animated:YES];
    
}


- (IBAction)clickHelloCar:(id)sender {
}
- (IBAction)clickPremier:(id)sender {
    
    
    PremierViewController *signObj =[[PremierViewController alloc]init];
    [self.navigationController pushViewController:signObj animated:YES];
    
}

- (IBAction)clickShare:(id)sender {

    
    DriverViewController *signObj =[[DriverViewController alloc]init];
    [self.navigationController pushViewController:signObj animated:YES];
     

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
    
    
    if(tagValue == 1)
    {
    
    fromLocLat = place.coordinate.latitude;
    fromLocLong = place.coordinate.longitude;
    
        
    NSString    *new = [place.formattedAddress stringByReplacingOccurrencesOfString: @"Chhattisgarh 494661" withString:@""];

        
        
    _fromAddress.text = [NSString stringWithFormat:@"%@",new];
        
        
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
        
        NSString    *new = [place.formattedAddress stringByReplacingOccurrencesOfString: @"Chhattisgarh 494661" withString:@""];
        
        
        
        
        _toAddress.text = [NSString stringWithFormat:@"%@",new];
    }
    
   // tagValue = 0;
    
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
            
            [self addFavFun];
        }
    }
    else
    {
         _viewFav.hidden = YES;
        
         [self addFavFun];
    }
    
}


-(void)addFavFun
{
    NSArray *favArray = [[NSUserDefaults standardUserDefaults]valueForKey:@"FAV_ARRAY"];
    NSArray *favLatArray = [[NSUserDefaults standardUserDefaults]valueForKey:@"FAV_LAT_ARRAY"];
    NSArray *favLongArray = [[NSUserDefaults standardUserDefaults]valueForKey:@"FAV_LONG_ARRAY"];
    NSArray *favTypeArray = [[NSUserDefaults standardUserDefaults]valueForKey:@"FAV_TYPE_ARRAY"];
    
    
    
    NSMutableArray *favArr=[[NSMutableArray alloc]init];
     NSMutableArray *favLatArr=[[NSMutableArray alloc]init];
     NSMutableArray *favLongArr=[[NSMutableArray alloc]init];
     NSMutableArray *favTypeArr=[[NSMutableArray alloc]init];
    
    [favArr addObjectsFromArray:favArray];
    [favLatArr addObjectsFromArray:favLatArray];

    [favLongArr addObjectsFromArray:favLongArray];

    [favTypeArr addObjectsFromArray:favTypeArray];

    
    
    
    
    
    
    [favArr addObject:_txtAddressSegment.text];
    [favLatArr addObject:[NSString stringWithFormat:@"%f",commonLocLat]];
   [favLongArr addObject:[NSString stringWithFormat:@"%f",commonLocLong]];
    
    
    if(newSegment.selectedSegmentIndex==0)
    {
    
    [favTypeArr addObject:@"Home"];
    }
    if(newSegment.selectedSegmentIndex==1)
    {
        
        [favTypeArr addObject:@"Office"];
    }
    if(newSegment.selectedSegmentIndex==2)
    {
        
        [favTypeArr addObject:_txtSegment.text];
    }
    
    
    [[NSUserDefaults standardUserDefaults]setObject:favArr forKey:@"FAV_ARRAY"];
     [[NSUserDefaults standardUserDefaults]setObject:favLatArr forKey:@"FAV_LAT_ARRAY"];
     [[NSUserDefaults standardUserDefaults]setObject:favLongArr forKey:@"FAV_LONG_ARRAY"];
     [[NSUserDefaults standardUserDefaults]setObject:favTypeArr forKey:@"FAV_TYPE_ARRAY"];
    
    
    NSLog(@"Fav Array:%@",favArr);
    NSLog(@"Fav Array:%@",favLatArr);
    NSLog(@"Fav Array:%@",favLongArr);
    NSLog(@"Fav Array:%@",favTypeArr);

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
- (IBAction)clickFavList:(id)sender {
    
    
    NSArray *favArray = [[NSUserDefaults standardUserDefaults]valueForKey:@"FAV_ARRAY"];
    NSArray *favLatArray = [[NSUserDefaults standardUserDefaults]valueForKey:@"FAV_LAT_ARRAY"];
    NSArray *favLongArray = [[NSUserDefaults standardUserDefaults]valueForKey:@"FAV_LONG_ARRAY"];
    NSArray *favTypeArray = [[NSUserDefaults standardUserDefaults]valueForKey:@"FAV_TYPE_ARRAY"];
    
    
    if([favArray count]!=0)
    {
    
    FavViewController *signObj =[[FavViewController alloc]init];
        signObj.delegate = self;
         [[NSUserDefaults standardUserDefaults]setObject:@"FROM" forKey:@"COME_NEW"];
    [self presentViewController:signObj animated:YES completion:nil];
    }
    else
    {
         [ProgressHUD showError:@"No Favorite Available."];
    }
    
    
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

-(void)processCompleted:(NSString *)text latVa:(NSString *)latVal longVal:(NSString *)longVal type:(NSString *)type
{
    NSLog(@"Text:%@",text);
    NSLog(@"Text:%@",latVal);
    NSLog(@"Text:%@",longVal);
    
    
    if([type isEqualToString:@"Drop"])
    {
    
    _toAddress.text = text;
    toLocLat = [latVal doubleValue];
    toLocLong = [longVal doubleValue];
    }
    else
    {
        _fromAddress.text = text;
        fromLocLat = [latVal doubleValue];
        fromLocLong = [longVal doubleValue];
    }
}


@end
