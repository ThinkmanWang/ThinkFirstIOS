//
//  ViewController.m
//  ThinkLaunchScreen
//
//  Created by 王晓丰 on 2020/12/22.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>


@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"进入首页");
    
    [self initUI];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"ThinkIOS";
    
//    self.label.text = @"使用说明及注意事项见github:\n https://github.com/CoderZhuXH/XHLaunchAd";
    NSLog(@"Hello World");
    
    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}


- (void)initUI {
    
    self.dataArray = @[
        @{@"sectionTitle": @"基本使用", @"classes": @[
            @{@"title": @"Banner", @"class": @"BannerViewController"},
            @{@"title": @"ListView", @"class": @"SimpleListViewController"},
            @{@"title": @"Dialog", @"class": @"DialogViewController"},
        ]},
        @{@"sectionTitle": @"穿山甲", @"classes": @[
            @{@"title": @"Banner", @"class": @"PangleBannerViewController"},
            @{@"title": @"", @"class": @"HeaderFooterViewController"}
        ]},
        @{@"sectionTitle": @"", @"classes": @[
            @{@"title": @"", @"class": @"DecorateViewController"},
        ]},
        @{@"sectionTitle": @"", @"classes": @[
            @{@"title": @"", @"class": @"NestedGroupViewController"},
            @{@"title": @"", @"class": @"NestedCollectionViewController"},
        ]},
        @{@"sectionTitle": @"综合Demo", @"classes": @[
            @{@"title": @"", @"class": @"AlbumsViewController"},
        ]},
    ];
    
    self.title = @"China Best IOS Demo";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *sectionDic = self.dataArray[section];
    return [sectionDic[@"classes"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSDictionary *sectionDic = self.dataArray[indexPath.section];
    cell.textLabel.text = sectionDic[@"classes"][indexPath.row][@"title"];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *sectionDic = self.dataArray[section];
    return sectionDic[@"sectionTitle"];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *sectionDic = self.dataArray[indexPath.section];
    NSDictionary *dic = sectionDic[@"classes"][indexPath.row];
    Class cls = NSClassFromString(dic[@"class"]);
    id obj = [[cls alloc] init];
    [obj setTitle:dic[@"title"]];
    [self.navigationController pushViewController:obj animated:YES];
}

#pragma mark - Setters/Getters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


@end
