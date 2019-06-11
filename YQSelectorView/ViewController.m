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
    UIImage *icon = [UIImage imageNamed:@"icon_scorePay"];
    NSArray *iconArr = @[icon,icon,icon,icon,icon,icon];
    YQButton *btn = [[YQButton alloc] initWithFrame:CGRectMake(0, 66, 200, 100)];
    btn.backgroundColor = UIColor.greenColor;
    [btn setTitle:@"YQSelectorView show" forState:UIControlStateNormal];
    //btn.center = self.view.center;
    [self.view addSubview:btn];
    btn.tapAction = ^(YQButton *sender) {
        YQSelectorView *view = [YQSelectorView selectorViewWithFrame:UIScreen.mainScreen.bounds title:@"选择停车场类型" textArray:[NSMutableArray arrayWithArray:typesArr] selectIndex:1 completion:^(NSInteger selectedIndex, NSString * _Nonnull selectedString) {
            //
        }];
        [self.view.window addSubview:view];
    };
    //
    YQButton *btn2 = [[YQButton alloc] initWithFrame:CGRectMake(0, 175, 200, 100)];
    btn2.backgroundColor = UIColor.greenColor;
    [btn2 setTitle:@"YQSelectorView show 2" forState:UIControlStateNormal];
    //btn.center = self.view.center;
    [self.view addSubview:btn2];
    btn2.tapAction = ^(YQButton *sender) {
        YQSelectorView *view = [YQSelectorView selectorViewWithFrame:UIScreen.mainScreen.bounds title:@"选择停车场类型" textArray:typesArr iconArr:iconArr imageOfSelected:[UIImage imageNamed:@"icon_duigou"] selectIndex:1 completion:^(NSInteger selectedIndex, NSString * _Nonnull selectedString) {
            //
        }];
        view.isAutoCloseWhenSelected = NO;
        [view setItemsTitleAlignment:NSTextAlignmentLeft];
        [self.view.window addSubview:view];
    };

}


@end
