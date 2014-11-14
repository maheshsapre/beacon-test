//
//  NDViewController.h
//  NDObjectiveGuideDemo
//
//  Created by Mikko Virkkilä on 21.9.2013.
//  Copyright (c) 2013 Mikko Virkkilä. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IndoorGuide/IGMapViewController.h>

/* We subclass from IGMapViewController to mostly use the default behaviour of the map view */
@interface NDMapViewController : IGMapViewController

@property IBOutlet UILabel *zoneLabel;
@property IBOutlet UILabel *arrowLabel;
@end
