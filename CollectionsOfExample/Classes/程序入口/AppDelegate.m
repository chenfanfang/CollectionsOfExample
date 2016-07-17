//
//  AppDelegate.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "AppDelegate.h"

//controller
#import "FFMainViewController.h"
#import "FFMainNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:FFScreenBounds];
    
    FFMainNavigationController *rootVC = [[FFMainNavigationController alloc] initWithRootViewController:[FFMainViewController new]];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
