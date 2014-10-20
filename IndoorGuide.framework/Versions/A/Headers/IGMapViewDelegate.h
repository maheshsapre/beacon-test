/*
//  IGMapViewDelegate.h
//  IndoorGuide
//
//  Created by Mikko Virkkilä on 19/08/14.
//  Copyright (c) 2014 Nimble Devices Oy. All rights reserved.
*/

#import <Foundation/Foundation.h>

@class IGMapView;

@protocol IGMapViewDelegate <NSObject>


- (void) mapView:(IGMapView*)mapView didReceiveAction:(NSURL *)url;
- (void) mapView:(IGMapView*)mapView didFailLoadWithError:(NSError *)error;
- (void) mapViewDidFinishLoad:(IGMapView*)mapView;


@end
