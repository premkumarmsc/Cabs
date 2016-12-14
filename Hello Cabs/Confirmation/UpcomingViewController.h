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
#import "StarRatingControl.h"

@interface UpcomingViewController : UIViewController<CLLocationManagerDelegate,UIGestureRecognizerDelegate,GMSAutocompleteViewControllerDelegate>
{
    __weak IBOutlet UISegmentedControl *newSegment;
    CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet UIImageView *mapImg;
@property (weak, nonatomic) IBOutlet MKMapView *mapObj;
@property (weak, nonatomic) IBOutlet UITextField *fromAddress;
@property (weak, nonatomic) IBOutlet UITextField *toAddress;
- (IBAction)userLocation:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *iconLauncher;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (strong, nonatomic) IBOutlet UIView *viewPending;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *viewFav;
@property (strong, nonatomic) IBOutlet UIView *viewAccept;
@property (strong, nonatomic) IBOutlet UIView *viewTracking;
@property (strong, nonatomic) IBOutlet UIView *viewPickup;

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

- (IBAction)newSegmentChanged:(id)sender;


- (IBAction)cancelBooking:(id)sender;

@property (weak, nonatomic) IBOutlet StarRatingControl *starRating;

@property (weak, nonatomic) IBOutlet UILabel *lblCabNo;
@property (weak, nonatomic) IBOutlet UILabel *lblDriverName;
@property (weak, nonatomic) IBOutlet UILabel *lblETA;
@property (weak, nonatomic) IBOutlet UILabel *labelETA;


@property (weak, nonatomic) IBOutlet UILabel *lblCabNoNew;
@property (weak, nonatomic) IBOutlet UILabel *lblDriverNameNew;
@property (weak, nonatomic) IBOutlet UILabel *lblETANew;
@property (weak, nonatomic) IBOutlet UILabel *labelETANew;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)clickViewBill:(id)sender;


@end
