/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "RCTPushNotificationManager.h"

#import "AppDelegate.h"
#import "RCTRootView.h"
#import "StatusBarBackground.h"
//Added import statement
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "RCTLinkingManager.h"

#import "RNGoogleSignin.h"
#import "CodePush.h"

//Added code
@implementation AppDelegate
- (void)applicationDidBecomeActive:(UIApplication *)application {
  [FBSDKAppEvents activateApp];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  NSURL *jsCodeLocation;

  [[FBSDKApplicationDelegate sharedInstance] application:application
                           didFinishLaunchingWithOptions:launchOptions];

#ifdef DEBUG
  jsCodeLocation = [NSURL URLWithString:@"http://192.168.1.114:8081/index.ios.bundle?platform=ios&dev=true"];
#else
  jsCodeLocation = [CodePush bundleURL];
#endif

  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"Lymchat"
                                               initialProperties:nil
                                                   launchOptions:launchOptions];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];

  // https://github.com/facebook/react-native/issues/1402
  NSArray *allPngImageNames = [[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:nil];
  for (NSString *imgName in allPngImageNames){
      if ([imgName containsString:@"LaunchImage"]){
          UIImage *img = [UIImage imageNamed:imgName];

          if (img.scale == [UIScreen mainScreen].scale && CGSizeEqualToSize(img.size, [UIScreen mainScreen].bounds.size)) {
              rootView.backgroundColor = [UIColor colorWithPatternImage:img];
          }
      }
  }

  return YES;
}

   // Required to register for notifications
   - (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
   {
    [RCTPushNotificationManager didRegisterUserNotificationSettings:notificationSettings];
   }
   // Required for the register event.
   - (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
   {
    [RCTPushNotificationManager didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
   }
   // Required for the notification event.
   - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)notification
   {
    [RCTPushNotificationManager didReceiveRemoteNotification:notification];
   }
   // Required for the localNotification event.
   - (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
   {
    [RCTPushNotificationManager didReceiveLocalNotification:notification];
   }

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
  if([[FBSDKApplicationDelegate sharedInstance] application:application
                                                    openURL:url
                                          sourceApplication:sourceApplication
                                                 annotation:annotation])
  {
    return YES;
  }

  if ([RNGoogleSignin application:application
                          openURL:url
                sourceApplication:sourceApplication
                       annotation:annotation])
  {
      return YES;
  }

  return [RCTLinkingManager application:application
                         openURL:url
               sourceApplication:sourceApplication
                      annotation:annotation];
}

@end
