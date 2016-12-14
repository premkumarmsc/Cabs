//
//  SideView.m
//  MyPractice
//
//  Created by eph132 on 10/06/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "SideView.h"
#import "CategoryMenu.h"
#import "DetailCell.h"
#import "SectionInfo.h"



#define DEFAULT_ROW_HEIGHT 157
#define HEADER_HEIGHT 50


@interface SideView ()
-(void)openDrawer;
-(void)closeDrqwer;
@property (nonatomic, assign) NSInteger openSectionIndex;
@property (nonatomic, strong) NSMutableArray *sectionInfoArray;
@property (nonatomic, strong) NSArray *categoryList;
- (void) setCategoryArray;
@end

@implementation SideView
{
    
    NSArray *topItems;
    NSMutableArray *subItems; // array of arrays
    
    int currentExpandedIndex;
    UITableView *_tableView;
}


@synthesize categoryList = _categoryList;
@synthesize openSectionIndex;
@synthesize sectionInfoArray;


SideView *side;

NSArray *titleArray;
NSArray *imageArray;
NSArray *vcArray;


- (id)init{
    
    
    
    side = [[[NSBundle mainBundle] loadNibNamed:@"SideView"
                                          owner:self
                                        options:nil]
            objectAtIndex:0];
    
    
    [side sizeToFit];
    
   
       
    
   
    
    
    CGRect basketTopFrame = side.frame;
    
    basketTopFrame.origin.x = -320;
    
   // NSLog(@"Width:%f",basketTopFrame.size.width);
   //  NSLog(@"Width:%f",basketTopFrame.size.height);
    
    
    side.frame = basketTopFrame;
   
    
    _closeView.hidden=YES;
    
    
    _gesView.hidden = NO;
    
        [self openDrawer];
    
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    
    
    
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [_gesView addGestureRecognizer:gestureRecognizer];

    
    
    [_menuTableView reloadData];
    
    
    return side;
    
}

-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Swipe received.");
    _gesView.hidden = YES;
    [self closeDrawer:nil];
}


- (void)configureWith:(id<customProtocol>)delegate{
    //Configure the delegate it will manage the events
    //from subviews like buttons and other controls
    self.delegate = delegate;
    //.. to configure any subView
}


- (void) awakeFromNib
{
    
    if(IS_IPHONE_5 || IS_IPHONE_4_OR_LESS)
    {
 
        _imgUser.layer.frame = CGRectMake(15, 50, 70, 70);
    _imgUser.layer.cornerRadius = _imgUser.frame.size.height/2.30;
    _imgUser.clipsToBounds = true;

    }
   
    
   // [self setCategoryArray];
    //self.menuTableView.sectionHeaderHeight = 45;
   // self.menuTableView.sectionFooterHeight = 0;
   // self.openSectionIndex = NSNotFound;
    
    vcArray=[NSArray arrayWithObjects:@"Rate Card",@"My Rides",@"Support",@"About", nil];
    
    
    if([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"LANGUAGE"] ]  isEqualToString:@"EN"])
    {
        titleArray=[NSArray arrayWithObjects:@"Rate Card",@"My Rides",@"Support",@"About", nil];
        
        
    }
    else
    {
        titleArray=[NSArray arrayWithObjects:@"ႏႈန္းထား",@"အေျခအေန",@"ဆက္သြယ္ရန္",@"ကြ်ႏု္ပ္တုိ႕အေၾကာင္း", nil];
        
    }
    
    
    
    imageArray=[NSArray arrayWithObjects:@"ratecard_icon.png", @"rides.png", @"support.png", @"about.png", nil];
    
    
    
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_DATA"];
    
    NSDictionary *getUserData=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
    
    
    NSLog(@"Get Data:%@",getUserData);
    
    
    NSString *mainUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"STAFF_PIC"] ];
    
    [_imgUser sd_setImageWithURL:[NSURL URLWithString:mainUrl]
                       placeholderImage:[UIImage imageNamed:@"default_profile_icon"]];
    
    
    
    
    _lblName.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"USER_NAME"] ];
    
    _lblSubName.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"USER_EMAIl"] ];
    
    
    NSString * appBuildString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString * versionBuildString = [NSString stringWithFormat:@"Version: %@ (%@)", appVersionString, appBuildString];
    
        
    
    [super awakeFromNib];
    
}



- (id)initWithTitle:(NSString *)aTitle options:(NSArray *)aOptions {
    CGRect rect = [[UIScreen mainScreen] applicationFrame]; // portrait bounds
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        rect.size = CGSizeMake(rect.size.height, rect.size.width);
    }
    if (self = [super initWithFrame:rect])
    {
       
       
        
    }
    return self;
}





/*
- (id)initWithTitle:(NSString *)aTitle
            options:(NSArray *)aOptions
            handler:(void (^)(NSInteger anIndex))aHandlerBlock {
    
    
    
    
   
    
    if(self = [self initWithTitle:aTitle options:aOptions])
        self.handlerBlock = aHandlerBlock;
    
    return self;
}
 */

- (void)setUpTableView
{
}


#pragma mark - Instance Methods
- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    
    
    
 
    
  
    
    
    
    side = [[[NSBundle mainBundle] loadNibNamed:@"SideView"
                                         owner:self
                                       options:nil]
           objectAtIndex:0];
    
    CGRect basketTopFrame = side.frame;
    //basketTopFrame.origin.x = basketTopFrame.size.width;
    basketTopFrame.origin.x = -320;
    side.frame = basketTopFrame;
    
    //side.delegate = self;
    
    [aView addSubview: side];
    //side.hidden=YES;
    
    
    
    if (animated) {
        
         _gesView.hidden = NO;
        [self openDrawer];
    }
    
    [_menuTableView reloadData];
    
    
}

-(void)openDrawer
{
    side.hidden=NO;
    _closeView.hidden=YES;
    
    
    
    
    
    CGRect basketTopFrame = side.frame;
    //basketTopFrame.origin.x = basketTopFrame.size.width;
    basketTopFrame.origin.x = 0;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         side.frame = basketTopFrame;
                         // basketBottom.frame = basketBottomFrame;
                     }
                     completion:^(BOOL finished)
     {
         NSLog(@"Done! AAA");
         
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _closeView.hidden=NO;
         });
         
         
     }];
    
    
    
    

}



- (IBAction)closeDrawer:(id)sender {
    
     _gesView.hidden = YES;
    
    [_delegate didTapSomeButton:@"Close"];
    
    side.hidden=NO;
    _closeView.hidden=YES;
    CGRect basketTopFrame = side.frame;
    //basketTopFrame.origin.x = basketTopFrame.size.width;
    basketTopFrame.origin.x = -320;
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         side.frame = basketTopFrame;
                         // basketBottom.frame = basketBottomFrame;
                     }
                     completion:^(BOOL finished)
     {
         NSLog(@"Done!");
         
         
         
         
         [self removeFromSuperview];
         
     }];

    
     
    
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DetailCell * cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil)
    {
        
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:nil options:nil];
        
        for (UIView *view in views)
        {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell1 = (DetailCell*)view;
            }
        }
    }
    
    cell1.emptyDate.text=titleArray[indexPath.row];
    cell1.img.image= [UIImage imageNamed:imageArray[indexPath.row]];
   
    return cell1;

    
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    //SectionInfo *array = [self.sectionInfoArray objectAtIndex:indexPath.section];
    //return [[array objectInRowHeightsAtIndex:indexPath.row] floatValue];
    
    
    return 60;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"Index:%ld",(long)indexPath.row);
        
        [_delegate didTapSomeButton:vcArray[indexPath.row]];
   
    _gesView.hidden = YES;
    [self closeDrawer:nil];
    
    
   // [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (IBAction)clickSettings:(id)sender {
    
     [_delegate didTapSomeButton:@"UserSettings"];
    
    _gesView.hidden = YES;
    
    [self closeDrawer:nil];
    
}
- (IBAction)clickProfile:(id)sender {
    
    _gesView.hidden = YES;
    [_delegate didTapSomeButton:@"UserProfile"];
    [self closeDrawer:nil];
}
@end
