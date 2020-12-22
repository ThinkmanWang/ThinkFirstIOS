//
//  BannerViewController.m
//  ThinkIOS
//
//  Created by 王晓丰 on 2020/12/17.
//

#import "BannerViewController.h"
#import <TYCyclePagerView/TYCyclePagerView.h>
#import <TYCyclePagerView/TYPageControl.h>
#import "TYCyclePagerViewCell.h"
#import <Masonry/Masonry.h>

@interface BannerViewController ()
@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

#pragma mark - init

-(void) initView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initPagerView];
    [self initPageControl];
    [self initData];
    
}

- (void)initPagerView {
    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]init];
    pagerView.layer.borderWidth = 0;
    pagerView.isInfiniteLoop = YES;
    pagerView.autoScrollInterval = 3.0;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    // registerClass or registerNib
    [pagerView registerClass:[TYCyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [self.view addSubview:pagerView];
    
    self.pagerView = pagerView;
//    [self.pagerView mas_makeConstraints:^(MASConstraintMaker* make) {
//        make.top.equalTo(self.view.mas_top);
//        make.left.equalTo(self.view.mas_left);
//    }];
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
    NSMutableArray *datas = [NSMutableArray array];
    for (int i = 0; i < 7; ++i) {
        if (i == 0) {
            [datas addObject:[UIColor redColor]];
            continue;
        }
        [datas addObject:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0]];
    }
    self.datas = [datas copy];
    self.pageControl.numberOfPages = self.datas.count;
    [self.pagerView reloadData];
    //[self.pagerView scrollToItemAtIndex:3 animate:YES];
}


#pragma mark - TYCyclePagerViewDataSource
- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.datas.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    TYCyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    cell.backgroundColor = self.datas[index];
    cell.label.text = [NSString stringWithFormat:@"index->%ld",index];
    
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

#pragma mark - events

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    self.pageControl.currentPage = toIndex;
    //[self.pageControl setCurrentPage:newIndex animate:YES];
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index {
    NSLog(@"Open banner ad at position: %ld", index);
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
