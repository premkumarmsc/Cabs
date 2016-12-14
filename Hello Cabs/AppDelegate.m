//
//  AppDelegate.m
//  Hello Cabs
//
//  Created by SYZYGY on 25/11/16.
//  Copyright © 2016 Syzygy Enterprise Solutions. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [GMSPlacesClient provideAPIKey:@"AIzaSyCqpy_fhNbp0m4K9kvo1YVHQarSKPjd6S4"];
    [GMSServices provideAPIKey:@"AIzaSyCqpy_fhNbp0m4K9kvo1YVHQarSKPjd6S4"];
    
    
    if([[[NSUserDefaults standardUserDefaults]stringForKey:@"LANGUAGE"] isEqualToString:@""] || [[NSUserDefaults standardUserDefaults]stringForKey:@"LANGUAGE"] == [NSNull null] || [[NSUserDefaults standardUserDefaults]stringForKey:@"LANGUAGE"].length == 0)
    {
         [[NSUserDefaults standardUserDefaults]setObject:@"EN" forKey:@"LANGUAGE"];
    }
    
    
    
    
    
   // [ProgressHUD show:nil Interaction:NO];
    
       
    
    
    sleep(2);
    application.statusBarStyle = UIStatusBarStyleLightContent;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *vwObj = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    UINavigationController *naviObj =[[UINavigationController alloc]initWithRootViewController:vwObj];
    self.window.rootViewController=naviObj;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
