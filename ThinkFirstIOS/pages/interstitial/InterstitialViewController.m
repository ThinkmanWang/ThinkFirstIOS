//
//  InterstitialViewController.m
//  ThinkFirstIOS
//
//  Created by 王晓丰 on 2021/1/12.
//

#import "InterstitialViewController.h"

#import <BUAdSDK/BUNativeExpressInterstitialAd.h>
#import <BUAdSDK/BUSize.h>
#import <BUAdSDK/BUAdSDK.h>


@interface InterstitialViewController ()<BUNativeExpresInterstitialAdDelegate>
@property (nonatomic, strong) BUNativeExpressInterstitialAd *interstitialAd;
@end

@implementation InterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void)initView {
    self.interstitialAd = [[BUNativeExpressInterstitialAd alloc] initWithSlotID:@"945746799" adSize:CGSizeMake(350, 350)];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];
    
    
}

#pragma ---BUNativeExpresInterstitialAdDelegate
- (void)nativeExpresInterstitialAdDidLoad:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpresInterstitialAd:(BUNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeExpresInterstitialAdRenderSuccess:(BUNativeExpressInterstitialAd *)interstitialAd {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
    [self pbud_logWithSEL:_cmd msg:@""];
    
    if (self.interstitialAd) {
       [self.interstitialAd showAdFromRootViewController:self];
    }
}

- (void)nativeExpresInterstitialAdRenderFail:(BUNativeExpressInterstitialAd *)interstitialAd error:(NSError *)error {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeExpresInterstitialAdWillVisible:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpresInterstitialAdDidClick:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpresInterstitialAdWillClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpresInterstitialAdDidClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self pbud_logWithSEL:_cmd msg:@""];
    self.interstitialAd = nil;
}

- (void)nativeExpresInterstitialAdDidCloseOtherController:(BUNativeExpressInterstitialAd *)interstitialAd interactionType:(BUInteractionType)interactionType {
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
//    BUD_Log(@"SDKDemoDelegate BUNativeExpressInterstitialAd In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
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
