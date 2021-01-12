//
//  TYCyclePagerViewCell.h
//  TYCyclePagerViewDemo
//
//  Created by tany on 2017/6/14.
//  Copyright © 2017年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUNativeExpressBannerView.h>
#import <BUAdSDK/BUAdSDK.h>

@interface TYCyclePagerViewCell : UICollectionViewCell
@property (nonatomic, weak) UILabel *label;
@property UIImageView* image;
@property(nonatomic, strong) BUNativeExpressBannerView *bannerView;
@end
