//
//  NDViewController.m
//  NDObjectiveGuideDemo
//
//  Created by Mikko Virkkilä on 21.9.2013.
//  Copyright (c) 2013 Mikko Virkkilä. All rights reserved.
//

#import <MapKit/MapKit.h>


#import <CoreLocation/CoreLocation.h>

#import <IndoorGuide/IGGuideManager.h>
#import <IndoorGuide/IGMapViewController.h>
#import "NDMapViewController.h"
#import "NDDebuggingViewController.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@interface NDMapViewController ()//<IGPositioningDelegate, IGDirectionsDelegate>
{
    IGGuideManager* guide;
    
    UIAlertView *alert;
}

@end

@implementation NDMapViewController





- (void)viewDidLoad
{
    [super viewDidLoad];
    guide = [IGGuideManager sharedManager];

    NSString *foofile = [[NSBundle mainBundle] pathForResource:@"demoTest" ofType:@"ndd"];
    
    [guide setNDDPath:foofile];
    [guide startUpdates];
//    
//    guide.positioningDelegate = self;
//    guide.directionsDelegate = self;
    
    NSArray *controllers = self.tabBarController.viewControllers;
    
    [guide setDebugHandler:^(int lvl, NSString *s) {
        NSLog(@"%@", s);
        NDDebuggingViewController *debugView = (NDDebuggingViewController *) [controllers objectAtIndex:1];
        if(debugView && debugView.isViewLoaded) {
            [debugView addDebug:s];
        }
    }];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"Reload"];
    /* [self reload]; */

}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"Reload"]) {
        [self reload];
        [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"Reload"];
    }
}

- (void) reload
{
//    [guide stopUpdates];
//    NSString *mapCode = [[NSUserDefaults standardUserDefaults] stringForKey:@"MapCode"];
//    NSString *extension = @".ndd";
//    if(!mapCode) {
//        mapCode=@"demo";
//    } else if([[mapCode pathExtension] isEqualToString:@"ndd"]) {
//        extension = @"";
//    }
//
//    NSString *mapDataLocation = [NSString stringWithFormat:@"https://s3-eu-west-1.amazonaws.com/ndd/%@%@", mapCode, extension];
//    //NSURL *dataUrl = [NSURL URLWithString:@"https://s3-eu-west-1.amazonaws.com/ndd/nimblehq.ndd"];
//    NSURL *dataUrl = [NSURL URLWithString:mapDataLocation];
//    if(dataUrl) {
//        NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//        NSString *imageString = @"demoTest.ndd";
//        NSString* foofile = [docsDir stringByAppendingPathComponent:imageString];
//        
//        [self.mapView startWithNDDUrl:[NSURL URLWithString:foofile]];
//        self.mapView.panWithLocation = true;
//
//        NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
//        guide.useAccelerometer = [settings boolForKey:@"EnableAccelerometer"];
//        guide.useCompass = [settings boolForKey:@"EnableCompass"];
//        guide.useDeviceMotion = [settings boolForKey:@"EnableGyroscope"];
//
//        if([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
//            guide.useIBeaconUUID = [[NSUUID alloc] initWithUUIDString:@"5EC0AE91-3CF2-D989-E311-192F98DADD45"];
//        }
//        
//        [guide startUpdates];
//        
//        /* Streaming events will cause the library to send the device sensor output to a server */
//        if([[NSUserDefaults standardUserDefaults] stringForKey:@"StreamTarget"] &&
//           [[NSUserDefaults standardUserDefaults] boolForKey:@"StreamEvents"])
//        {
//            NSLog(@"Streaming events!");
//            [guide startStreamingTo:[[NSUserDefaults standardUserDefaults] stringForKey:@"StreamTarget"]];
//        } else {
//            [guide stopStreaming];
//        }
//    } else {
//        NSLog(@"Error: NDD file not found, nothing will work.");
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) mapView:(IGMapView*)mapView didReceiveAction:(NSURL *)url
{
    [super mapView:mapView didReceiveAction:url];
    NSLog(@"Did receive action %@", url);
}

- (void) mapView:(IGMapView*)mapView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Failed to load map view %@", error);
}


- (void) mapViewDidFinishLoad:(IGMapView*)mapView
{
    [super mapViewDidFinishLoad:mapView];
    
    NSString *keyword = [[NSUserDefaults standardUserDefaults] stringForKey:@"RouteTarget"];
    if(keyword && ![keyword isEqualToString:@" "] &&  ![keyword isEqualToString:@""] ) {
        [guide startRoutingToName: keyword];

    }

}

-(void)updateDebugView
{
    /* Used just for debugging */
    uint16_t width, height;
    double lat, lon;
    const uint16_t* d = [guide getDebuggingGridWidth:&width height:&height lat:&lat lon:&lon];
    NSArray *controllers = self.tabBarController.viewControllers;
    NDDebuggingViewController *debugView = (NDDebuggingViewController *) [controllers objectAtIndex:1];
    [debugView updateGridImage:d width:width height:height];
}

-(void)guideManager:(IGGuideManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    /* Use IGMapViewController's default behaviour for map widget */
    [super guideManager:manager didUpdateToLocation:newLocation fromLocation:oldLocation];
    [self updateDebugView];
}

-(void)guideManager:(IGGuideManager *)manager didEnterZone:(uint32_t)zone_id name:(NSString *)name
{
    /* Use IGMapViewController's default behaviour for map widget */
    [super guideManager:manager didEnterZone:zone_id name:name];
    NSLog(@"Entered zone %@", name);
    
    [alert dismissWithClickedButtonIndex:0 animated:NO];
    alert = [[UIAlertView alloc ]initWithTitle:@"ENTER" message:[NSString stringWithFormat:@"Entered on %@",name] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}

-(void)guideManager:(IGGuideManager *)manager didExitZone:(uint32_t)zone_id name:(NSString *)name
{
    /* Use IGMapViewController's default behaviour for map widget */
    [super guideManager:manager didExitZone:zone_id name:name];
    NSLog(@"Exited zone %@", name);
    
    [alert dismissWithClickedButtonIndex:0 animated:NO];
    alert = [[UIAlertView alloc ]initWithTitle:@"EXIT" message:[NSString stringWithFormat:@"Exit from %@",name] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}

- (void)guideManager:(IGGuideManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",error.userInfo);
}

@end
