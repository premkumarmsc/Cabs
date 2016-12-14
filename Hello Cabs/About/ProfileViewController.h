//
//  ReviewViewController.h
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface ProfileViewController : UIViewController

- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIImageView *imgUser;

@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UIView *viewLogout;
- (IBAction)clickLogout:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentLanguage;
- (IBAction)languageChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *plaTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *plaGender;
@property (weak, nonatomic) IBOutlet UILabel *plaLanguage;

@end
