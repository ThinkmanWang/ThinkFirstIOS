//
//  BaseViewController.h
//  UICollectionViewDemo-iOS 13
//
//  Created by 张延深 on 2019/11/9.
//  Copyright © 2019 张延深. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "BaseViewController.h"
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseListViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

- (UICollectionViewLayout *)generateLayout;
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
