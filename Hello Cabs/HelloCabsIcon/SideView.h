//
//  SideView.h
//  MyPractice
//
//  Created by eph132 on 10/06/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "SectionView.h"

@protocol customProtocol
- (void)didTapSomeButton:(NSString *)getController;
@optional
- (void)didTapAnOptionalButton;
@end

@interface SideView : UIView<UITableViewDataSource,UITableViewDelegate,SectionView>
- (IBAction)closeDrawer:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewBottom;

@property (weak, nonatomic) IBOutlet UILabel *lblSubName;

@property(nonatomic,strong) NSArray *items;
@property (nonatomic, retain) NSMutableArray *itemsInTable;
@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet UIView *gesView;

@property (weak, nonatomic) IBOutlet UIView *closeView;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
- (IBAction)clickProfile:(id)sender;



@property (copy, nonatomic) void(^handlerBlock)(NSInteger anIndex);
- (void)showInView:(UIView *)aView animated:(BOOL)animated;

- (id)initWithTitle:(NSString *)aTitle options:(NSArray *)aOptions;
- (id)initWithTitle:(NSString *)aTitle
            options:(NSArray *)aOptions
            handler:(void (^)(NSInteger))aHandlerBlock;


- (void)setUpTableView;
@property (weak, nonatomic) IBOutlet UILabel *lblBuild;



- (IBAction)clickSettings:(id)sender;


@property (weak,nonatomic) id<customProtocol>delegate;

- (void)configureWith:(id<customProtocol>)delegate;


@end

