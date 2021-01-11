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

#import "BUDAnimationTool.h"

@interface AppDelegate ()
@property BUSplashAdView* splashAdView;
@property NSTimer* timer;
@property (nonatomic, assign) CFTimeInterval startTime;
@end

@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
        
    /** 开屏广告初始化,见XHLaunchAdManager */

    [self.window makeKeyAndVisible];
    
    // initialize AD SDK
    [self initByteDanceAD];
    
    return YES;
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

#pragma mark - BUAdSDK


- (void) initByteDanceAD {
    [BUAdSDKManager setAppID:@"5134179"];
    [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
    [BUAdSDKManager setCoppa:0];
    [BUAdSDKManager setIsPaidApp:NO];
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.splashAdView = [[BUSplashAdView alloc] initWithSlotID:@"887421551" frame:frame];
    // tolerateTimeout = CGFLOAT_MAX , The conversion time to milliseconds will be equal to 0
    self.splashAdView.tolerateTimeout = 5;
    self.splashAdView.delegate = self;
    //optional
    self.splashAdView.needSplashZoomOutAd = YES;
    UIWindow *keyWindow = self.window;
    self.startTime = CACurrentMediaTime();
    [self.splashAdView loadAdData];
    [keyWindow.rootViewController.view addSubview:self.splashAdView];
    self.splashAdView.rootViewController = keyWindow.rootViewController;
}

- (void)removeSplashAdView {
    if (self.splashAdView) {
        [self.splashAdView removeFromSuperview];
        self.splashAdView = nil;
    }
}


- (void)splashAdDidLoad:(BUSplashAdView *)splashAd {
    if (splashAd.zoomOutView) {
        UIViewController *parentVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        [parentVC.view addSubview:splashAd.zoomOutView];
        [parentVC.view bringSubviewToFront:splashAd];
        //Add this view to your container
        [parentVC.view insertSubview:splashAd.zoomOutView belowSubview:splashAd];
        splashAd.zoomOutView.rootViewController = parentVC;
        splashAd.zoomOutView.delegate = self;
    }
}

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    if (splashAd.zoomOutView) {
        [[BUDAnimationTool sharedInstance] transitionFromView:splashAd toView:splashAd.zoomOutView];
    } else{
        // Be careful not to say 'self.splashadview = nil' here.
        // Subsequent agent callbacks will not be triggered after the 'splashAdView' is released early.
        [splashAd removeFromSuperview];
    }
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidClick:(BUSplashAdView *)splashAd {
    if (splashAd.zoomOutView) {
        [splashAd.zoomOutView removeFromSuperview];
    }
    // Be careful not to say 'self.splashadview = nil' here.
    // Subsequent agent callbacks will not be triggered after the 'splashAdView' is released early.
    [splashAd removeFromSuperview];
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd {
    if (splashAd.zoomOutView) {
        [[BUDAnimationTool sharedInstance] transitionFromView:splashAd toView:splashAd.zoomOutView];
    } else{
        // Click Skip, there is no subsequent operation, completely remove 'splashAdView', avoid memory leak
        [self removeSplashAdView];
    }
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    // Display fails, completely remove 'splashAdView', avoid memory leak
    [self removeSplashAdView];
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdWillVisible:(BUSplashAdView *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}





- (void)splashAdWillClose:(BUSplashAdView *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashAd interactionType:(BUInteractionType)interactionType {
    // No further action after closing the other Controllers, completely remove the 'splashAdView' and avoid memory leaks
    [self removeSplashAdView];
    
    [self pbu_logWithSEL:_cmd msg:@""];
}



- (void)splashAdCountdownToZero:(BUSplashAdView *)splashAd {
    // When the countdown is over, it is equivalent to clicking Skip to completely remove 'splashAdView' and avoid memory leak
    if (!splashAd.zoomOutView) {
        [self removeSplashAdView];
    }
    [self pbu_logWithSEL:_cmd msg:@""];
}

#pragma mark - BUSplashZoomOutViewDelegate
- (void)splashZoomOutViewAdDidClick:(BUSplashZoomOutView *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashZoomOutViewAdDidClose:(BUSplashZoomOutView *)splashAd {
    // Click close, completely remove 'splashAdView', avoid memory leak
    [self removeSplashAdView];
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashZoomOutViewAdDidAutoDimiss:(BUSplashZoomOutView *)splashAd {
    // Back down at the end of the countdown to completely remove the 'splashAdView' to avoid memory leaks
    [self removeSplashAdView];
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashZoomOutViewAdDidCloseOtherController:(BUSplashZoomOutView *)splashAd interactionType:(BUInteractionType)interactionType {
    // No further action after closing the other Controllers, completely remove the 'splashAdView' and avoid memory leaks
    [self removeSplashAdView];
    [self pbu_logWithSEL:_cmd msg:@""];
}


- (void)pbu_logWithSEL:(SEL)sel msg:(NSString *)msg {
//    CFTimeInterval endTime = CACurrentMediaTime();
//    BUD_Log(@"SplashAdView In AppDelegate (%@) total run time: %gs, extraMsg:%@", NSStringFromSelector(sel), endTime - self.startTime, msg);
}

@end
