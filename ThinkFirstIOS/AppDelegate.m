//
//  AppDelegate.m
//  ThinkFirstIOS
//
//  Created by 王晓丰 on 2020/12/22.
//

#import "AppDelegate.h"
#import <XHLaunchAd/XHLaunchAd.h>
#import "ViewController.h"
#import <BUAdSDK/BUAdSDK.h>

@interface AppDelegate ()
@property BUSplashAdView* splashAdView;
@property NSTimer* timer;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
        
    /** 开屏广告初始化,见XHLaunchAdManager */

    [self.window makeKeyAndVisible];
    
    [self initByteDanceAD];
    
    return YES;
}

- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd {
//    [self handleSplashDimiss:splashAd];
    // 'zoomOutView' is nil, there will be no subsequent operation to completely remove splashAdView and avoid memory leak
    // 'zoomOutView' is not nil，do nothing
    
    NSLog(@"splashAdDidClickSkip");
    [self removeSplashAdView];
}

- (void)splashAdDidLoad:(BUSplashAdView *)splashAd {
    NSLog(@"splashAdDidLoad");
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(dismissAd:) userInfo:nil repeats:NO];
}

- (void)splashAdDidClick:(BUSplashAdView *)splashAd {
    if (splashAd.zoomOutView) {
        [splashAd.zoomOutView removeFromSuperview];
    }
    [splashAd removeFromSuperview];
}

- (void) removeSplashAdView {
    [self.splashAdView removeFromSuperview];
}

- (void) dismissAd:(NSTimer*)timer {
    NSLog(@"dismissDialog");

    [self removeSplashAdView];
}

- (void) initByteDanceAD {
    [BUAdSDKManager setAppID:@"5134179"];
    [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
    [BUAdSDKManager setCoppa:0];
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.splashAdView = [[BUSplashAdView alloc] initWithSlotID:@"887421551" frame:frame];
    // tolerateTimeout = CGFLOAT_MAX , The conversion time to milliseconds will be equal to 0
    self.splashAdView.tolerateTimeout = 10;
    self.splashAdView.delegate = self;
    //optional
    self.splashAdView.needSplashZoomOutAd = YES;
    UIWindow *keyWindow = self.window;
//    self.startTime = CACurrentMediaTime();
    [self.splashAdView loadAdData];
    [keyWindow.rootViewController.view addSubview:self.splashAdView];
    self.splashAdView.rootViewController = keyWindow.rootViewController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
