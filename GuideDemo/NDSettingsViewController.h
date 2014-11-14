//
//  NDSettingsViewController.h
//  NDObjectiveGuideDemo
//
//  Created by Mikko Virkkilä on 04/03/14.
//  Copyright (c) 2014 Mikko Virkkilä. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDSettingsViewController : UIViewController

@property IBOutlet UISwitch *streamEventsSwitch;


@property IBOutlet UITextField *mapCodeField;
@property IBOutlet UITextField *routeTargetField;
@property IBOutlet UITextField *streamTargetField;

@property IBOutlet UISwitch *enableAccelerometerSwitch;
@property IBOutlet UISwitch *enableCompassSwitch;
@property IBOutlet UISwitch *enableGyroscopeSwitch;

- (void)setSwitchState:(UISwitch *)theSwitch;

@end
