//
//  ReviewViewController.h
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ADPageControl.h"

@protocol SampleProtocolDelegate <NSObject>
@required
- (void) processCompleted:(NSString *)text latVa:(NSString *)latVal longVal:(NSString *)longVal type:(NSString *)type;
@end

@interface FavViewController : UIViewController<ADPageControlDelegate>
{
    ADPageControl *pageControlObj;
    
    id <SampleProtocolDelegate> _delegate;
}

- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UILabel *lblTopLabel;


@property (weak, nonatomic) IBOutlet UIView *viewPageControl;

@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (nonatomic,strong) id delegate;

-(void)startSampleProcess; // Instance method
@end
