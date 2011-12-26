//
//  TSAppDelegate.m
//  TTShop
//
//  Created by Steven Li on 12/1/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import "TSAppDelegate.h"
#import "TSConfigs.h"
#import "STURLLoader.h"

static NSInteger check_new_ver_counter = 0;

@implementation TSAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    
    UIApplication* app = [UIApplication sharedApplication];
	
	__block UIBackgroundTaskIdentifier bgTask;
	bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
		bgTask = UIBackgroundTaskInvalid;
	}];
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		dispatch_async(dispatch_get_main_queue(), ^{
			
            
			[app endBackgroundTask:bgTask];
			bgTask = UIBackgroundTaskInvalid;
		});
	});
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    check_new_ver_counter++;
    
    if (check_new_ver_counter == 5)
    {	
        check_new_ver_counter = 0;
        [self checkNewVersion];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

#pragma mark -

- (void) checkNewVersion
{
    NSLog(@"---did check new version");
//    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_CHECK_NEW_VERSION];
//	STURLRequest *req = [[STURLRequest alloc] initWithURLString:full_url];
//	[req setFormValue:@"iPhone" forField:@"merId"];
//    [req setFormValue:@"123" forField:@"source"];
//    [req setFormValue:VERSION_STR forField:@"edition"];
//	[req setHTTPMethod:@"POST"];
//	
//	STURLLoader *loader = [[STURLLoader alloc] initWithRequest:req];
//    [loader addEventListener:STLOADER_COMPLETE target:self action:@selector(onCheckNewVersion:)];
//	[loader load];
//	
//	[req release];
}

- (void) onCheckNewVersion:(NSNotification *)notify
{
    
}

@end
