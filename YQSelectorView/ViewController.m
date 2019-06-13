//
//  ViewController.m
//  YQSelectorView
//
//  Created by 杨清 on 2019/6/10.
//  Copyright © 2019 QuinceyYang. All rights reserved.
//

#import "ViewController.h"
#import <YQButton/YQButton.h>
#import "YQSelectorView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __weak __typeof(self)weakSelf = self;
    NSArray *typesArr = @[@"住宅",@"写字楼",@"公共机构",@"商业",@"商住两用",@"商写两用",@"旅游景点"];
    UIImage *icon = [UIImage imageNamed:@"icon_scorePay"];
    NSArray *iconArr = @[icon,icon,icon,icon,icon,icon];
    YQButton *btn = [[YQButton alloc] initWithFrame:CGRectMake(0, 66, 250, 100)];
    btn.backgroundColor = UIColor.greenColor;
    [btn setTitle:@"YQSelectorView show" forState:UIControlStateNormal];
    //btn.center = self.view.center;
    [self.view addSubview:btn];
    btn.tapAction = ^(YQButton *sender) {
        YQSelectorView *view = [YQSelectorView selectorViewWithFrame:UIScreen.mainScreen.bounds title:@"选择停车场类型" textArray:[NSMutableArray arrayWithArray:typesArr] defaultSelectIndex:1 completion:^(NSInteger selectedIndex, NSString * _Nonnull selectedString) {
            //
        }];
        [weakSelf.view.window addSubview:view];
    };
    //
    YQButton *btn2 = [[YQButton alloc] initWithFrame:CGRectMake(0, 175, 250, 100)];
    btn2.backgroundColor = UIColor.greenColor;
    [btn2 setTitle:@"YQSelectorView show 2" forState:UIControlStateNormal];
    //btn.center = self.view.center;
    [self.view addSubview:btn2];
    btn2.tapAction = ^(YQButton *sender) {
        YQSelectorView *view = [YQSelectorView selectorViewWithFrame:UIScreen.mainScreen.bounds title:@"选择停车场类型" iconArr:iconArr textArray:typesArr imageOfSelected:[UIImage imageNamed:@"icon_duigou"] defaultSelectIndex:1 completion:^(NSInteger selectedIndex, NSString * _Nonnull selectedString) {
            //
        }];
        view.isAutoCloseWhenSelected = NO;
        [view setItemsTextAlignment:NSTextAlignmentLeft];
        [weakSelf.view.window addSubview:view];
    };
    //
    YQButton *btn3 = [[YQButton alloc] initWithFrame:CGRectMake(0, 285, 250, 100)];
    btn3.backgroundColor = UIColor.greenColor;
    [btn3 setTitle:@"YQSelectorView attribute" forState:UIControlStateNormal];
    //btn.center = self.view.center;
    [self.view addSubview:btn3];
    btn3.tapAction = ^(YQButton *sender) {
        NSString *str = @"商住两用";
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str];
        [attr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:[str rangeOfString:str]];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[str rangeOfString:@"两用"]];
        [attr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:[str rangeOfString:str]];
        [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[str rangeOfString:@"商住"]];
        NSArray *attrArr = [NSArray arrayWithObjects:attr,attr,attr,nil];
        YQSelectorView *view = [YQSelectorView selectorViewWithFrame:UIScreen.mainScreen.bounds title:@"选择停车场类型" iconArr:iconArr attributedTextArray:attrArr imageOfSelected:[UIImage imageNamed:@"icon_duigou"] defaultSelectIndex:1 completion:^(NSInteger selectedIndex, NSString * _Nonnull selectedString) {
            //
        }];
        view.isAutoCloseWhenSelected = NO;
        [view setItemsTextAlignment:NSTextAlignmentLeft];
        [weakSelf.view.window addSubview:view];
    };

}


@end
