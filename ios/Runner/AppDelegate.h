#import <Flutter/Flutter.h>
#import <UIKit/UIKit.h>

//  AppDelegate.m
#import <FBSDKCoreKit/FBSDKCoreKit.h>

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  [[FBSDKApplicationDelegate sharedInstance] application:application
    didFinishLaunchingWithOptions:launchOptions];
  // Add any custom logic here.
  return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

  BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
    openURL:url
    sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
    annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
  ];
  // Add any custom logic here.
  return handled;
}


//  SceneDelegate.m
#import <FBSDKCoreKit/FBSDKCoreKit.h>

- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts {
  UIOpenURLContext *openURLContext = URLContexts.allObjects.firstObject;
  if (openURLContext) {
    [[FBSDKApplicationDelegate sharedInstance] application:UIApplication.sharedApplication
    openURL:openURLContext.URL
    sourceApplication:openURLContext.options.sourceApplication
    annotation:openURLContext.options.annotation];
  }
  // Add any custom logic here.
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {

  BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
    openURL:url
    sourceApplication:sourceApplication
    annotation:annotation
  ];
  // Add any custom logic here.
  return handled;
}


@interface AppDelegate : FlutterAppDelegate

@end
