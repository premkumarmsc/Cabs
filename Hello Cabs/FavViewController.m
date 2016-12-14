//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "FavViewController.h"

#import "AFNetworking.h"

#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT

@interface FavViewController ()
{
   
    NSMutableArray *dataArray;
    
    NSMutableArray *dataArrayNew;
    
    NSMutableArray *checkMarkArrayNew;
    int totalChecked;
    
    int currentIndex;
}
@end

@implementation FavViewController

NSMutableArray *favArray;
NSMutableArray *favLatArray;
NSMutableArray *favLongArray;
NSMutableArray *favTypeArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    favTypeArray = [[NSMutableArray alloc]init];
    favLongArray = [[NSMutableArray alloc]init];
    favLatArray = [[NSMutableArray alloc]init];
    favArray = [[NSMutableArray alloc]init];
    
    
    
    NSArray *favArray1= [[NSUserDefaults standardUserDefaults]valueForKey:@"FAV_ARRAY"];
    NSArray *favLatArray1 = [[NSUserDefaults standardUserDefaults]valueForKey:@"FAV_LAT_ARRAY"];
    NSArray *favLongArray1 = [[NSUserDefaults standardUserDefaults]valueForKey:@"FAV_LONG_ARRAY"];
    NSArray *favTypeArray1 = [[NSUserDefaults standardUserDefaults]valueForKey:@"FAV_TYPE_ARRAY"];
    
    
    [favArray addObjectsFromArray:favArray1];
    [favLatArray addObjectsFromArray: favLatArray1];
    [favLongArray addObjectsFromArray: favLongArray1];
    [favTypeArray addObjectsFromArray: favTypeArray1];
    
    
    self.topView.layer.masksToBounds = NO;
    self.topView.layer.shadowOffset = CGSizeMake(0, 3);
    self.topView.layer.shadowRadius = 5;
    self.topView.layer.shadowOpacity = 0.5;
    
    [_tblView reloadData];
    
}



- (IBAction)backBtn:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
   // [self.navigationController popViewControllerAnimated:YES];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
   // return [dataArray count];
    
    return [favArray count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    [view setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 5;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    
    
    
    FavCell * cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil)
    {
        
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"FavCell" owner:nil options:nil];
        
        for (UIView *view in views)
        {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell1 = (FavCell*)view;
                //cell.img=@"date.png";
                
            }
        }
    }
    
    
    
    
    cell1.viewInner.layer.cornerRadius = 5;
    cell1.viewInner.layer.masksToBounds = YES;
    
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell1.lblSubtitle.text = favArray[indexPath.row];
    
    cell1.lblLevel.text = favTypeArray[indexPath.row];
    
    
    [cell1.btnDel setTag:indexPath.row];
    [cell1.btnDel addTarget:self action:@selector(LevelClicked:)
             forControlEvents:UIControlEventTouchDown];
    
      return cell1;
    
    
}

-(void)LevelClicked:(UIButton*)button
{
    //NSDictionary *dict = dataArrayNew[(long int)[button tag]];
    
    
    [UIAlertView showWithTitle:@"Delete"
                       message:@"Are you sure you want to Delete?"
             cancelButtonTitle:@"No"
             otherButtonTitles:@[@"Yes"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == [alertView cancelButtonIndex]) {
                              NSLog(@"Cancelled");
                          } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Yes"]) {
                              NSLog(@"Have a cold beer");
                              
                              [favArray removeObjectAtIndex:(long int)[button tag]];
                               [favLatArray removeObjectAtIndex:(long int)[button tag]];
                               [favLongArray removeObjectAtIndex:(long int)[button tag]];
                               [favTypeArray removeObjectAtIndex:(long int)[button tag]];
                              
                              
                              
                              [[NSUserDefaults standardUserDefaults]setObject:favArray forKey:@"FAV_ARRAY"];
                              [[NSUserDefaults standardUserDefaults]setObject:favLatArray forKey:@"FAV_LAT_ARRAY"];
                              [[NSUserDefaults standardUserDefaults]setObject:favLongArray forKey:@"FAV_LONG_ARRAY"];
                              [[NSUserDefaults standardUserDefaults]setObject:favTypeArray forKey:@"FAV_TYPE_ARRAY"];
                              
                              
                              [_tblView reloadData];
                              
                          }
                      }];
    

    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 114;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[ProgressHUD dismiss];
    
    NSLog(@"Index:%d",currentIndex);
    
    
    if([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"COME_NEW"] ]  isEqualToString:@"TO"])
    {
        
        [_delegate processCompleted:favArray[indexPath.row] latVa:favLatArray[indexPath.row] longVal:favLongArray[indexPath.row] type:@"Pick"];
        
         [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
    
    [UIAlertView showWithTitle:@"Confirmation"
                       message:@"Use this address for?"
             cancelButtonTitle:@"Drop-off Location"
             otherButtonTitles:@[@"Pick-up Location"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == [alertView cancelButtonIndex]) {
                              NSLog(@"Cancelled");
                              
                              [_delegate processCompleted:favArray[indexPath.row] latVa:favLatArray[indexPath.row] longVal:favLongArray[indexPath.row] type:@"Drop"];
                              
                              [self dismissViewControllerAnimated:YES completion:nil];
                              
                          } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Pick-up Location"]) {
                              NSLog(@"Have a cold beer");
                              
                              [_delegate processCompleted:favArray[indexPath.row] latVa:favLatArray[indexPath.row] longVal:favLongArray[indexPath.row] type:@"Pick"];
                              
                              [self dismissViewControllerAnimated:YES completion:nil];
                              
                          }
                      }];
    }
   
   
}



@end
