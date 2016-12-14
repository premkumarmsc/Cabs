//
//  ReviewViewController.h
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>

@interface DriverViewController : UIViewController<CLLocationManagerDelegate,UIGestureRecognizerDelegate,GMSAutocompleteViewControllerDelegate>
{
    __weak IBOutlet UISegmentedControl *newSegment;
    CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapObj;
@property (weak, nonatomic) IBOutlet UITextField *fromAddress;
@property (weak, nonatomic) IBOutlet UITextField *toAddress;
- (IBAction)userLocation:(id)sender;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *viewFav;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
- (IBAction)clickFromFav:(id)sender;
- (IBAction)clickToFav:(id)sender;
- (IBAction)clickFrom:(id)sender;
- (IBAction)clickTo:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
- (IBAction)segmentChange:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
- (IBAction)clickRideNow:(id)sender;
- (IBAction)clickRideLater:(id)sender;
- (IBAction)clickHelloCar:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *clickPremierCar;
- (IBAction)clickPremier:(id)sender;
- (IBAction)clickShare:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *currentIcon;
@property (weak, nonatomic) IBOutlet UITextField *txtSegment;
@property (weak, nonatomic) IBOutlet UITextView *txtAddressSegment;
@property (weak, nonatomic) IBOutlet UIImageView *imgSegment;
- (IBAction)clickCancel:(id)sender;
- (IBAction)clickSave:(id)sender;
@property (nonatomic, retain) MKPolyline *routeLine; //your line
@property (nonatomic, retain) MKPolylineView *routeLineView; //overlay view

- (IBAction)newSegmentChanged:(id)sender;

@end
