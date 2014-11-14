//
//  NDDebuggingViewController.m
//  GuideDemo
//
//  Created by Mikko Virkkilä on 09/04/14.
//  Copyright (c) 2014 Mikko Virkkilä. All rights reserved.
//

#import "NDDebuggingViewController.h"

@interface NDDebuggingViewController ()
{
    NSMutableData *rgbImageMutableData;
    uint8_t *rgbImagePixies;
}
@end


@implementation NDDebuggingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void) calcColor:(uint16_t)val min:(uint16_t)minimumValue max:(uint16_t)maximumValue output:(uint8_t[3])vals
{
    uint16_t range = maximumValue-minimumValue;
    uint16_t half = minimumValue + 0.5*range;
    uint8_t startColor[3]={0x00, 0x2d, 0xb5}, endColor[3]={0xff,0xff,0xff};
    float percent;
    if(val>=half) {
        startColor[0]=0xff; startColor[1]=0xff; startColor[2]=0xff;
        endColor[0]=0xd3; endColor[1]=0x00; endColor[2]=0x00;//Deep red
        val -= (0.5*range);
    }
    percent = (val-minimumValue)/(0.5*range);
    
    vals[0] = (startColor[0] + percent*(endColor[0] - startColor[0]));
    vals[1] = (startColor[1] + percent*(endColor[1] - startColor[1]));
    vals[2] = (startColor[2] + percent*(endColor[2] - startColor[2]));
}

- (void)updateGridImage:(const uint16_t *)pixies width:(uint16_t)width height:(uint16_t)height
{
    int nrOfColorComponents = 4; //RGBA
    int bitsPerColorComponent = 8;
    unsigned long rawImageDataLength = width * height * nrOfColorComponents;
    BOOL interpolateAndSmoothPixels = NO;
    if(rgbImageMutableData == nil) {
        rgbImageMutableData = [NSMutableData dataWithCapacity:rawImageDataLength];
        rgbImagePixies = [rgbImageMutableData mutableBytes];
    }
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
 
    CGDataProviderRef dataProviderRef;
    CGColorSpaceRef colorSpaceRef;
    CGImageRef imageRef;
    uint16_t pixieMinimum = 0xffff;
    uint16_t pixieMaximum = 0x0;
    for(int i=0; i<width*height; i++){
        if(pixies[i]<pixieMinimum) pixieMinimum = pixies[i];
        if(pixies[i]>pixieMaximum) pixieMaximum = pixies[i];
    }
    
    int pixieNumber = 0;
    for(int i=0;i<rawImageDataLength;i+=4)
    {
        uint16_t pixeVal =pixies[pixieNumber++];
        if(pixeVal != 0) {
            [self calcColor:pixeVal min:pixieMinimum max:pixieMaximum output:&rgbImagePixies[i]];
            rgbImagePixies[i+3]=0xff;
        } else {
            rgbImagePixies[i+0]=0x00;
            rgbImagePixies[i+1]=0x00;
            rgbImagePixies[i+2]=0x00;
            rgbImagePixies[i+3]=0x00;
        }
    }
    
    UIImage *newImage;
    
    @try
    {
        GLubyte *rawImageDataBuffer = rgbImagePixies;
        
        dataProviderRef = CGDataProviderCreateWithData(NULL, rawImageDataBuffer, rawImageDataLength, nil);
        colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        imageRef = CGImageCreate(width, height, bitsPerColorComponent, bitsPerColorComponent * nrOfColorComponents, width * nrOfColorComponents, colorSpaceRef, bitmapInfo, dataProviderRef, NULL, interpolateAndSmoothPixels, renderingIntent);
        newImage = [[UIImage alloc] initWithCGImage:imageRef];

    }
    @finally
    {
        CGDataProviderRelease(dataProviderRef);
        CGColorSpaceRelease(colorSpaceRef);
        CGImageRelease(imageRef);
    }
    /* NSLog(@"New image! %.0f,%.0f datalen=%lu",newImage.size.width, newImage.size.width, rawImageDataLength); */
    [self.gridView setImage:newImage];
    [self.gridView setNeedsLayout];
    [self.gridView setNeedsDisplay];
}

- (void)addDebug:(NSString *)s
{
 
    if([self.debugTextView.text length] > 2048) {
        [self.debugTextView setText:[NSString stringWithFormat:@"%@\n%@", s, [self.debugTextView.text substringToIndex:2048]]];
    } else {
        [self.debugTextView setText:[NSString stringWithFormat:@"%@\n%@", s, self.debugTextView.text]];
    }
}

@end
