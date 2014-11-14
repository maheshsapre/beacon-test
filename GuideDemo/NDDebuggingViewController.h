//
//  NDDebuggingViewController.h
//  GuideDemo
//
//  Created by Mikko Virkkilä on 09/04/14.
//  Copyright (c) 2014 Mikko Virkkilä. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDDebuggingViewController : UIViewController

@property IBOutlet UIImageView *gridView;
@property IBOutlet UITextView *debugTextView;

- (void)updateGridImage:(const uint16_t *)pixies width:(uint16_t)width height:(uint16_t)height;
- (void)addDebug:(NSString *)s;
@end
