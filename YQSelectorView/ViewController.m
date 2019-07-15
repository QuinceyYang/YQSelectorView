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
    NSArray *typesArr = @[@"住宅",@"写字楼",@"公共机构",@"商业",@"商住两用",@"商写两用",@"旅游景点",@"AAAAA",@"BBBBB",@"CCCCC",@"DDDDD",@"EEEEE",@"FFFFF"];
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
        view.isMustSelectedOne = NO;
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
        NSString *str = @"商住两用 \n2020-07-15";
        NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        textStyle.lineSpacing = 6;

        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blueColor],NSParagraphStyleAttributeName:textStyle}];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[str rangeOfString:@"两用"]];
        [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[str rangeOfString:@"商住"]];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:[str rangeOfString:@"2020-07-15"]];
        [attr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:[str rangeOfString:@"2020-07-15"]];
        NSString *str2 = @"不选择任何一项";
        NSMutableAttributedString *attr2 = [[NSMutableAttributedString alloc] initWithString:str2 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
        NSArray *attrArr = [NSArray arrayWithObjects:attr,attr,attr,attr2,nil];
        YQSelectorView *view = [YQSelectorView selectorViewWithFrame:UIScreen.mainScreen.bounds title:@"选择停车场类型" iconArr:@[icon,icon] attributedTextArray:attrArr imageOfSelected:[UIImage imageNamed:@"icon_duigou"] defaultSelectIndex:1 completion:^(NSInteger selectedIndex, NSString * _Nonnull selectedString) {
            //
        }];
        view.isAutoCloseWhenSelected = NO;
        [view setItemsTextAlignment:NSTextAlignmentLeft];
        [weakSelf.view.window addSubview:view];
    };
    //
    YQButton *btn4 = [[YQButton alloc] initWithFrame:CGRectMake(0, 395, 250, 100)];
    btn4.backgroundColor = UIColor.greenColor;
    [btn4 setTitle:@"YQSelectorView full func" forState:UIControlStateNormal];
    [self.view addSubview:btn4];
    btn4.tapAction = ^(YQButton *sender) {
        NSString *str = @"x元优惠券 \n2020-07-15";
        NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        textStyle.lineSpacing = 6;
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blueColor],NSParagraphStyleAttributeName:textStyle}];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[str rangeOfString:@"x元"]];
        [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[str rangeOfString:@"优惠券"]];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:[str rangeOfString:@"2020-07-15"]];
        [attr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:[str rangeOfString:@"2020-07-15"]];
        NSString *str2 = @"不选择任何一项";
        NSMutableAttributedString *attr2 = [[NSMutableAttributedString alloc] initWithString:str2 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
        NSArray *attrArr = [NSArray arrayWithObjects:attr,attr,attr,attr2,nil];
        
        YQSelectorView *view = [YQSelectorView selectorViewWithFrame:UIScreen.mainScreen.bounds contentWidthRatio:1.0 contentHeightRatio:0.5 title:@"选择优惠券" iconArr:@[icon,icon] textArray:nil attributedTextArray:attrArr imageOfSelected:[UIImage imageNamed:@"icon_duigou"] defaultSelectIndex:1 isConfirmButton:YES completion:^(NSInteger selectedIndex, NSString * _Nonnull selectedString) {
            //
        }];
        view.isAutoCloseWhenSelected = NO;
        [view setItemsTextAlignment:NSTextAlignmentLeft];
        view.contentView.frame = CGRectMake(view.contentView.frame.origin.x, view.frame.size.height-view.contentView.frame.size.height+10, view.contentView.frame.size.width, view.contentView.frame.size.height);
        view.contentView.layer.cornerRadius = 10;
        view.confirmBtn.layer.cornerRadius = 5;
        view.confirmBtn.layer.masksToBounds = YES;
        [weakSelf.view.window addSubview:view];
    };

}


@end
