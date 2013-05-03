//
//  ANLCAppDelegate.h
//  Native Languages
//
//  Created by Rovolo on 2013-01-31.
//  Copyright (c) 2013 Rovolo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANLCAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

+(id) shared;

@end
