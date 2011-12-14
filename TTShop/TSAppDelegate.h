//
//  TSAppDelegate.h
//  TTShop
//
//  Created by Steven Li on 12/1/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;

@property (strong, nonatomic) IBOutlet UITabBarController *tabBarController;

@end
