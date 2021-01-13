//
//  FeedCell.m
//  ThinkFirstIOS
//
//  Created by 王晓丰 on 2021/1/13.
//

#import "FeedCell.h"
#import <BUAdSDK/BUNativeExpressAdView.h>


@interface FeedCell ()
@end

@implementation FeedCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor clearColor];
        
        [self initView];
    }
    return self;
}


- (void) initView {
    self.expressAdView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
//    self.expressAdView.delegate = rootViewController;
    
//    [self.bannerView loadAdData];
        
    [self addSubview:self.expressAdView];
}

@end

