//
//  DialogViewController.m
//  ThinkFirstIOS
//
//  Created by 王晓丰 on 2020/12/23.
//

#import "DialogViewController.h"
#import <SCLAlertView.h>

@interface DialogViewController ()
@property SCLAlertView *alert;
@property NSTimer* timer;
@end

@implementation DialogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showWaiting:self];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dismissDialog:) userInfo:nil repeats:NO];

}

- (void) dismissDialog:(NSTimer*)timer {
    NSLog(@"dismissDialog");

    [self.alert hideView];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.timer invalidate];
}

- (IBAction)showWaiting:(id)sender
{
    self.alert = [[SCLAlertView alloc] init];
    
    self.alert.showAnimationType = SCLAlertViewHideAnimationSlideOutToCenter;
    self.alert.hideAnimationType = SCLAlertViewHideAnimationSlideOutFromCenter;
    
    self.alert.backgroundType = SCLAlertViewBackgroundTransparent;
    
    [self.alert showWaiting:self title:@"Loading..."
            subTitle:nil
    closeButtonTitle:nil duration:0.0f];
    
    
    
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
