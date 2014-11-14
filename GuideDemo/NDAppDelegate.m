//
//  NDAppDelegate.m
//  NDObjectiveGuideDemo
//
//  Created by Mikko Virkkilä on 21.9.2013.
//  Copyright (c) 2013 Mikko Virkkilä. All rights reserved.
//

#import "NDAppDelegate.h"

#import <IndoorGuide/IGGuideManager.h>
#import <IndoorGuide/IGMapView.h>


@implementation NDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [IGMapView class];
    [UIApplication sharedApplication].idleTimerDisabled = YES;

    NSDictionary *userDefaultsDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"demo.ndd", @"MapCode",
                                          @"", @"RouteTarget",
                                          [NSNumber numberWithBool:YES], @"EnableAccelerometer",
                                          [NSNumber numberWithBool:YES], @"EnableCompass",
                                          [NSNumber numberWithBool:YES], @"EnableGyroscope",
                                          nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaultsDefaults];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"StreamEvents"];
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"applicationWillResignActive");
    /* [[IGGuideManager sharedManager] stopUpdates]; */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    /* [[IGGuideManager sharedManager] startUpdates]; */
    NSLog(@"applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"applicationWillTerminate");
}
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"applicationDidReceiveLocalNotification");
}
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    NSLog(@"applicationDidReceiveMemoryWarning");

}

@end
