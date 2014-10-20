//
//  ViewController.m
//  NimbleTest
//
//  Created by Conn on 20/10/14.
//  Copyright (c) 2014 Connovatech. All rights reserved.
//

#import "ViewController.h"
#import <IndoorGuide/IGGuideManager.h>

@interface ViewController ()<IGPositioningDelegate, IGDirectionsDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    IGGuideManager *manager = [IGGuideManager sharedManager];
    
    manager.positioningDelegate = self;
    manager.directionsDelegate = self;
    
//    manager.preventRerouting = TRUE;
//    manager.useAccelerometer = TRUE;
//    manager.useCompass = TRUE;
//    manager.useAccelerometer = TRUE;
//    manager.useBluetooth = TRUE;
    
    [manager startUpdates];
}

-(void)guideManager:(IGGuideManager *)manager didCompleteRouting:(NSArray *)routepoints
{
    
}

-(void)guideManager:(IGGuideManager *)manager didFailRoutingWithError:(NSError *)err
{
    
}

-(void)guideManager:(IGGuideManager *)manager didUpdateRoutePosition:(CLLocationCoordinate2D)pos altitude:(CLLocationDistance)alt direction:(CLLocationDirection)direction distanceToChange:(CLLocationDistance)toChange distanceToGoal:(CLLocationDistance)toGoal
{
    
}


-(void)guideManager:(IGGuideManager *)manager didEnterZone:(uint32_t)zone_id name:(NSString *)name
{
    
}

-(void)guideManager:(IGGuideManager *)manager didExitZone:(uint32_t)zone_id name:(NSString *)name
{
    
}

@end
