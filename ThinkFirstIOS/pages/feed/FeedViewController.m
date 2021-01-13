//
//  FeedViewController.m
//  ThinkFirstIOS
//
//  Created by 王晓丰 on 2021/1/13.
//

#import "FeedViewController.h"

#import <BUAdSDK/BUAdSDK.h>
#import <BUAdSDK/BUNativeExpressAdManager.h>
#import <BUAdSDK/BUNativeExpressAdView.h>

#import <TYCyclePagerView/TYCyclePagerView.h>
#import <TYCyclePagerView/TYPageControl.h>
#import "FeedCell.h"
#import <Masonry/Masonry.h>

@interface FeedViewController () <BUNativeExpressAdViewDelegate>
@property (strong, nonatomic) BUNativeExpressAdManager *nativeExpressAdManager;
@property (strong, nonatomic) NSMutableArray<__kindof BUNativeExpressAdView *> *expressAdViews;
@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    [self initAd];
}

#pragma mark - init

-(void) initView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initPagerView];
    [self initPageControl];
    
}

- (void)initPagerView {
    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]init];
    pagerView.layer.borderWidth = 0;
    pagerView.isInfiniteLoop = YES;
    pagerView.autoScrollInterval = 3.0;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    // registerClass or registerNib
    [pagerView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [self.view addSubview:pagerView];
    
    self.pagerView = pagerView;
//    [self.pagerView mas_makeConstraints:^(MASConstraintMaker* make) {
//        make.top.equalTo(self.view.mas_top);
//        make.left.equalTo(self.view.mas_left);
//    }];
}

- (void) initAd {
    self.expressAdViews = [NSMutableArray new];
    
    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
    slot1.ID = @"945746795";
    slot1.AdType = BUAdSlotAdTypeFeed;
    BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Feed228_150];
    slot1.imgSize = imgSize;
    slot1.position = BUAdSlotPositionFeed;
    // self.nativeExpressAdManager可以重用
    if (!self.nativeExpressAdManager) {
        self.nativeExpressAdManager = [[BUNativeExpressAdManager alloc] initWithSlot:slot1 adSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0)];
    }
    self.nativeExpressAdManager.adSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 0);
    self.nativeExpressAdManager.delegate = self;

    [self.nativeExpressAdManager loadAd:3];
}

- (void)initPageControl {
    TYPageControl *pageControl = [[TYPageControl alloc]init];
    //pageControl.numberOfPages = self.datas.count;
    pageControl.currentPageIndicatorSize = CGSizeMake(8, 8);
    pageControl.pageIndicatorSize = CGSizeMake(6, 6);
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self.pagerView addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat topbarHeight = ([UIApplication sharedApplication].statusBarFrame.size.height +
           (self.navigationController.navigationBar.frame.size.height ?: 0.0));
    
    self.pagerView.frame = CGRectMake(0
                                      , topbarHeight
                                      , CGRectGetWidth(self.view.frame)
                                      , CGRectGetWidth(self.view.frame) / 2);
    self.pageControl.frame = CGRectMake(0
                                        , CGRectGetHeight(self.pagerView.frame) - 26
                                        , CGRectGetWidth(self.pagerView.frame)
                                        , 26);
}

- (void)initData {
    self.pageControl.numberOfPages = self.expressAdViews.count;
    [self.pagerView reloadData];
//    NSMutableArray *datas = [NSMutableArray array];
//    for (int i = 0; i < 7; ++i) {
//        if (i == 0) {
//            [datas addObject:[UIColor redColor]];
//            continue;
//        }
//        [datas addObject:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0]];
//    }
//    self.datas = [datas copy];
//    self.pageControl.numberOfPages = self.datas.count;
//    [self.pagerView reloadData];
    //[self.pagerView scrollToItemAtIndex:3 animate:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - TYCyclePagerViewDataSource
- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.expressAdViews.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    
//    UITableViewCell *cell = nil;
//    if (indexPath.row % BUD_FeedDistributionNumber == 0) {
//        cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        // 重用BUNativeExpressAdView，先把之前的广告试图取下来，再添加上当前视图
//        UIView *subView = (UIView *)[cell.contentView viewWithTag:1000];
//        if ([subView superview]) {
//            [subView removeFromSuperview];
//        }
//
//        UIView *view = [self.expressAdViews objectAtIndex:indexPath.row / BUD_FeedDistributionNumber];
//        view.tag = 1000;
//        [self addAccessibilityIdentifier:view];
//        [cell.contentView addSubview:view];
//    } else {
//        cell = [pagerView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:index];
//        cell.backgroundColor = [UIColor whiteColor];
//    }
    UICollectionViewCell* cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    cell.backgroundColor = [UIColor greenColor];
    
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
//    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame)*0.8, CGRectGetHeight(pageView.frame)*0.8);
    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame), CGRectGetHeight(pageView.frame));
    layout.itemSpacing = 15;
    //layout.minimumAlpha = 0.3;
//    layout.itemHorizontalCenter = self.horCenterSwitch.isOn;
    return layout;
}

#pragma mark - BUNativeExpressAdViewDelegate
- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAd views:(NSArray<__kindof BUNativeExpressAdView *> *)views {
    [self.expressAdViews removeAllObjects];
    if (views.count) {

        [self.expressAdViews addObjectsFromArray:views];
//        [self.expressAdViews addObject:views.firstObject];
        [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BUNativeExpressAdView *expressView = (BUNativeExpressAdView *)obj;
//            [self.expressAdViews addObject:expressView];
            expressView.rootViewController = self;
            // important: 此处会进行WKWebview的渲染，建议一次最多预加载三个广告，如果超过3个会很大概率导致WKWebview渲染失败。
            [expressView render];
//            *stop = YES;
        }];
    }
    
    [self initData];
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd error:(NSError *)error {
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
    NSLog(@"nativeExpressAdViewRenderSuccess");
    
    [self.pagerView reloadData];
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCurrentPlayedTime) userInfo:nil repeats:YES];
//        [self.timer fire];
//    });
}

- (void)updateCurrentPlayedTime {
    NSLog(@"nativeExpressAdViewRenderSuccess");

}

- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView stateDidChanged:(BUPlayerPlayState)playerState {
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"playerState:%ld", (long)playerState]];
}

- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error {
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressAdViewDidClick:(BUNativeExpressAdView *)nativeExpressAdView {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressAdViewPlayerDidPlayFinish:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
    
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressAdViewDidClosed:(BUNativeExpressAdView *)nativeExpressAdView {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressAdViewWillPresentScreen:(BUNativeExpressAdView *)nativeExpressAdView {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressAdViewDidCloseOtherController:(BUNativeExpressAdView *)nativeExpressAdView interactionType:(BUInteractionType)interactionType {
    [self pbud_logWithSEL:_cmd msg:@""];
}


- (void)pbud_logWithSEL:(SEL)sel msg:(NSString *)msg {
//    BUD_Log(@"SDKDemoDelegate BUNativeExpressFeedAdView In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}

#pragma mark - events

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    self.pageControl.currentPage = toIndex;
    //[self.pageControl setCurrentPage:newIndex animate:YES];
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index {
    NSLog(@"Open banner ad at position: %ld", index);
}

@end
