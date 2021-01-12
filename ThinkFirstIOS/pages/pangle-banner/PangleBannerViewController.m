//
//  PangleBannerViewController.m
//  ThinkFirstIOS
//
//  Created by 王晓丰 on 2021/1/11.
//

#import "PangleBannerViewController.h"

#import <BUAdSDK/BUNativeExpressBannerView.h>
#import <BUAdSDK/BUAdSDK.h>

@interface PangleBannerViewController ()<BUNativeExpressBannerViewDelegate>
@property(nonatomic, strong) BUNativeExpressBannerView *bannerView;
@property(nonatomic, strong) BUNativeExpressBannerView *bannerView1;
@property(nonatomic, strong) BUNativeExpressBannerView *bannerView2;
@property(nonatomic, copy) NSDictionary *sizeDcit;
@end

@implementation PangleBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    
}

- (void)initView {
    self.sizeDcit = @{
        @"945742204"         :  [NSValue valueWithCGSize:CGSizeMake(600, 300)]
        , @"945741009"         :  [NSValue valueWithCGSize:CGSizeMake(600, 260)]
    };
    
    
    UIWindow *window = nil;
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        window = [[UIApplication sharedApplication].delegate window];
    }
    if (![window isKindOfClass:[UIView class]]) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    CGFloat bottom = 0.0;
    if (@available(iOS 11.0, *)) {
        bottom = window.safeAreaInsets.bottom;
    } else {
        // Fallback on earlier versions
    }
    
    CGFloat topbarHeight = ([UIApplication sharedApplication].statusBarFrame.size.height +
           (self.navigationController.navigationBar.frame.size.height ?: 0.0));
    
    //banner 1
    NSValue *sizeValue = [self.sizeDcit objectForKey:@"945742204"];
    CGSize size = [sizeValue CGSizeValue];
    self.bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:@"945742204" rootViewController:self adSize:size interval:30];
    self.bannerView.frame = CGRectMake(0
                                       , topbarHeight
                                       , CGRectGetWidth(self.view.frame)
                                       , CGRectGetWidth(self.view.frame) / 2);
    self.bannerView.delegate = self;
    [self.bannerView loadAdData];
    
    //banner 2
    self.bannerView1 = [[BUNativeExpressBannerView alloc] initWithSlotID:@"945741009" rootViewController:self adSize:size interval:30];
    self.bannerView1.frame = CGRectMake(0
                                        , topbarHeight + CGRectGetWidth(self.view.frame) / 2
                                        , CGRectGetWidth(self.view.frame)
                                        , CGRectGetWidth(self.view.frame) / 2);
    self.bannerView1.delegate = self;
    [self.bannerView1 loadAdData];
    
    //banner 3
    self.bannerView2 = [[BUNativeExpressBannerView alloc] initWithSlotID:@"945742204" rootViewController:self adSize:size interval:30];
    self.bannerView2.frame = CGRectMake(0
                                        , topbarHeight + CGRectGetWidth(self.view.frame)
                                        , CGRectGetWidth(self.view.frame)
                                        , CGRectGetWidth(self.view.frame) / 2);
    self.bannerView2.delegate = self;
    [self.bannerView2 loadAdData];
}

- (void)showBanner {
    [self.view addSubview:self.bannerView];
    [self.view addSubview:self.bannerView1];
    [self.view addSubview:self.bannerView2];
//    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

#pragma mark - events

- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *)error {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
    [self pbud_logWithSEL:_cmd msg:@""];
    [self showBanner];
}

- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError *)error {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeExpressBannerAdViewWillBecomVisible:(BUNativeExpressBannerView *)bannerAdView {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
    [UIView animateWithDuration:0.25 animations:^{
        bannerAdView.alpha = 0;
    } completion:^(BOOL finished) {
        [bannerAdView removeFromSuperview];
        self.bannerView = nil;
    }];
//    self.selectedView.promptStatus = BUDPromptStatusDefault;
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressBannerAdViewDidCloseOtherController:(BUNativeExpressBannerView *)bannerAdView interactionType:(BUInteractionType)interactionType {
    NSString *str;
    if (interactionType == BUInteractionTypePage) {
        str = @"ladingpage";
    } else if (interactionType == BUInteractionTypeVideoAdDetail) {
        str = @"videoDetail";
    } else {
        str = @"appstoreInApp";
    }
    [self pbud_logWithSEL:_cmd msg:str];
}
- (void)pbud_logWithSEL:(SEL)sel msg:(NSString *)msg {
//    BUD_Log(@"SDKDemoDelegate BUNativeExpressBannerView In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

