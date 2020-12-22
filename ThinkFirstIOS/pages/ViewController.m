//
//  ViewController.m
//  ThinkLaunchScreen
//
//  Created by 王晓丰 on 2020/12/22.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"进入首页");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"XHLaunchAdExample";
    
//    self.label.text = @"使用说明及注意事项见github:\n https://github.com/CoderZhuXH/XHLaunchAd";
    NSLog(@"Hello World");
    
    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}


@end
