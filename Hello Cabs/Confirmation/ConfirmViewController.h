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
#import "FavViewController.h"
@interface ConfirmViewController : UIViewController<CLLocationManagerDelegate,UIGestureRecognizerDelegate,GMSAutocompleteViewControllerDelegate,SampleProtocolDelegate>
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
@property (weak, nonatomic) IBOutlet UIButton *callNewBtn;
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
@property (weak, nonatomic) IBOutlet UIView *desView;
@property (weak, nonatomic) IBOutlet UIButton *btnFav;
- (IBAction)clickCall:(id)sender;
- (IBAction)newSegmentChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *plaConfirmationBooking;
@property (weak, nonatomic) IBOutlet UILabel *plaRateCard;
@property (weak, nonatomic) IBOutlet UILabel *plaApplyCoupon;
@property (weak, nonatomic) IBOutlet UILabel *plaConfirmation;
- (IBAction)clickfav:(id)sender;

@end
