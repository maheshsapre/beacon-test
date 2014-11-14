//
//  NDSettingsViewController.m
//  NDObjectiveGuideDemo
//
//  Created by Mikko Virkkilä on 04/03/14.
//  Copyright (c) 2014 Mikko Virkkilä. All rights reserved.
//

#import "NDSettingsViewController.h"

@interface NDSettingsViewController ()<UITextFieldDelegate>

@end

@implementation NDSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    self.mapCodeField.text  = [settings stringForKey:@"MapCode"];
    self.mapCodeField.delegate = self;
    
    self.routeTargetField.text  = [settings stringForKey:@"RouteTarget"];
    self.routeTargetField.delegate = self;
    

    self.enableAccelerometerSwitch.on = [settings boolForKey:@"EnableAccelerometer"];
    [self.enableAccelerometerSwitch addTarget:self action:@selector(setSwitchState:) forControlEvents:UIControlEventValueChanged];
    
    self.enableCompassSwitch.on = [settings boolForKey:@"EnableCompass"];
    [self.enableCompassSwitch addTarget:self action:@selector(setSwitchState:) forControlEvents:UIControlEventValueChanged];
    
    self.enableGyroscopeSwitch.on = [settings boolForKey:@"EnableGyroscope"];
    [self.enableGyroscopeSwitch addTarget:self action:@selector(setSwitchState:) forControlEvents:UIControlEventValueChanged];

    
    self.streamTargetField.text  = [settings stringForKey:@"StreamTarget"];
    self.streamTargetField.delegate = self;

    self.streamEventsSwitch.on = [settings boolForKey:@"StreamEvents"];
    [self.streamEventsSwitch addTarget:self action:@selector(setSwitchState:) forControlEvents:UIControlEventValueChanged];

    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"Reload"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)setSwitchState:(UISwitch *)theSwitch {
    if(theSwitch == self.streamEventsSwitch) {
        [[NSUserDefaults standardUserDefaults] setBool:theSwitch.on forKey:@"StreamEvents"];
        
    } else if(theSwitch == self.enableAccelerometerSwitch) {
        [[NSUserDefaults standardUserDefaults] setBool:theSwitch.on forKey:@"EnableAccelerometer"];
    } else if(theSwitch == self.enableCompassSwitch) {
        [[NSUserDefaults standardUserDefaults] setBool:theSwitch.on forKey:@"EnableCompass"];
    } else if(theSwitch == self.enableGyroscopeSwitch) {
        [[NSUserDefaults standardUserDefaults] setBool:theSwitch.on forKey:@"EnableGyroscope"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    /* Makes the synchronization work when you switch focus */
    return [self textFieldShouldReturn:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if(textField == self.streamTargetField) {
        [[NSUserDefaults standardUserDefaults] setObject:self.streamTargetField.text forKey:@"StreamTarget"];
    } else if (textField == self.mapCodeField) {
        [[NSUserDefaults standardUserDefaults] setObject:self.mapCodeField.text forKey:@"MapCode"];
    } else if (textField == self.routeTargetField) {
        [[NSUserDefaults standardUserDefaults] setObject:self.routeTargetField.text forKey:@"RouteTarget"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
