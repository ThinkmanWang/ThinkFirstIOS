//
//  FeedCell.h
//  ThinkFirstIOS
//
//  Created by 王晓丰 on 2021/1/13.
//

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUNativeExpressAdView.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedCell : UICollectionViewCell
@property (strong, nonatomic) BUNativeExpressAdView* expressAdView;
@property (strong, nonatomic) UIViewController* rootViewController;
@end

NS_ASSUME_NONNULL_END
