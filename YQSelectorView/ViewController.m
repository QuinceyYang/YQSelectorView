//
//  ViewController.m
//  YQSelectorView
//
//  Created by 杨清 on 2019/6/10.
//  Copyright © 2019 QuinceyYang. All rights reserved.
//

#import "ViewController.h"
#import "YQButton.h"
#import "YQSelectorView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *typesArr = @[@"住宅",@"写字楼",@"公共机构",@"商业",@"商住两用",@"商写两用",@"旅游景点"];
    YQButton *btn = [[YQButton alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    btn.backgroundColor = UIColor.greenColor;
    [btn setTitle:@"YQSelectorView show" forState:UIControlStateNormal];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    btn.tapAction = ^(YQButton *sender) {
        YQSelectorView *view = [YQSelectorView selectorViewWithFrame:UIScreen.mainScreen.bounds title:@"选择停车场类型" itemArray:typesArr selectIndex:1 completion:^(NSInteger selectedIndex, NSString * _Nonnull selectedString) {
            //
        }];
        [self.view.window addSubview:view];
    };
}


@end
