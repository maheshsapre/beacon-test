//
//  IGMapViewNavigationHandler.h
//  IndoorGuide
//
//  Created by Mikko Virkkilä on 25/08/14.
//  Copyright (c) 2014 Nimble Devices Oy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <IndoorGuide/IGMapView.h>
#import <IndoorGuide/IGPositioningDelegate.h>
#import <IndoorGuide/IGDirectionsDelegate.h>

@interface IGMapViewController: UIViewController<IGPositioningDelegate, IGDirectionsDelegate,IGMapViewDelegate>

@property IBOutlet IGMapView *mapView;

@end
