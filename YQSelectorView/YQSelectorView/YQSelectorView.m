//
//  YQSelectorView.m
//  YQSelectorView
//
//  Created by 杨清 on 2019/6/10.
//  Copyright © 2019 QuinceyYang. All rights reserved.
//

#import "YQSelectorView.h"

@implementation YQSelectorView

+ (instancetype)selectorViewWithFrame:(CGRect)frame title:(NSString *)title textArray:(NSArray *)textArr defaultSelectIndex:(NSInteger)defaultSelectIndex completion:(void (^)(NSInteger selectedIndex, NSString *selectedString))completion {
    
    return [YQSelectorView selectorViewWithFrame:frame title:title iconArr:nil textArray:textArr attributedTextArray:nil imageOfSelected:nil defaultSelectIndex:defaultSelectIndex completion:completion];
}

+ (instancetype)selectorViewWithFrame:(CGRect)frame title:(NSString *)title iconArr:(NSArray <UIImage *> * _Nullable)iconArr textArray:(NSArray *)textArr imageOfSelected:(UIImage *)imageOfSelected defaultSelectIndex:(NSInteger)defaultSelectIndex completion:(void (^)(NSInteger selectedIndex, NSString *selectedString))completion {
    
    return [YQSelectorView selectorViewWithFrame:frame title:title iconArr:iconArr textArray:textArr attributedTextArray:nil imageOfSelected:imageOfSelected defaultSelectIndex:defaultSelectIndex completion:completion];
}

+ (instancetype)selectorViewWithFrame:(CGRect)frame title:(NSString *)title iconArr:(NSArray <UIImage *> * _Nullable)iconArr attributedTextArray:(NSArray <NSAttributedString *> *)attributedTextArr imageOfSelected:(UIImage *)imageOfSelected defaultSelectIndex:(NSInteger)defaultSelectIndex completion:(void (^)(NSInteger selectedIndex, NSString *selectedString))completion {
    
    return [YQSelectorView selectorViewWithFrame:frame title:title iconArr:iconArr textArray:nil attributedTextArray:attributedTextArr imageOfSelected:imageOfSelected defaultSelectIndex:defaultSelectIndex completion:completion];
}


+ (instancetype)selectorViewWithFrame:(CGRect)frame title:(NSString *)title iconArr:(NSArray <UIImage *> * _Nullable)iconArr textArray:(NSArray *)textArr attributedTextArray:(NSArray <NSAttributedString *> *)attributedTextArr imageOfSelected:(UIImage *)imageOfSelected defaultSelectIndex:(NSInteger)defaultSelectIndex completion:(void (^)(NSInteger selectedIndex, NSString *selectedString))completion {
    
    YQSelectorView *selectorView = [[YQSelectorView alloc] initWithFrame:frame];
    selectorView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    selectorView.isAutoCloseWhenSelected = YES;
    //
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, selectorView.frame.size.width>375?selectorView.frame.size.width-100:selectorView.frame.size.width-80, selectorView.frame.size.height-160)];
    view.layer.cornerRadius = 6;
    view.layer.masksToBounds = YES;
    view.backgroundColor = UIColor.whiteColor;
    [selectorView addSubview:view];
    //
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 18, view.frame.size.width-40, 22)];
    titleLab.text = title;
    titleLab.textColor = [UIColor colorWithRed:0x22/255.0 green:0x22/255.0 blue:0x22/255.0 alpha:1.0];
    titleLab.font = [UIFont systemFontOfSize:18];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLab];
    selectorView.titleLab = titleLab;
    //
    YQButton *closeBtn = [[YQButton alloc] initWithFrame:CGRectMake(view.frame.size.width-40, 0, 40, 40)];
    [closeBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [view addSubview:closeBtn];
    closeBtn.tapAction = ^(YQButton *sender) {
        [UIView beginAnimations:nil context:nil];
        [sender.superview.superview removeFromSuperview];
        [UIView commitAnimations];
    };
    //
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 53.5, view.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0xe8/255.0 green:0xe8/255.0 blue:0xe8/255.0 alpha:1.0];
    [view addSubview:line];
    //
    if ( (textArr==nil || textArr.count<=0) && (attributedTextArr==nil || attributedTextArr.count<=0) ) {
        view.center = CGPointMake(selectorView.frame.size.width/2, selectorView.frame.size.height/2);
        return selectorView;
    }
    //如果textArr==nil时，将attributedTextArr的string给textArr
    if (textArr==nil || textArr.count<=0) {
        NSMutableArray *tmpArr = [NSMutableArray new];
        for (NSInteger i=0; i<attributedTextArr.count; i++) {
            [tmpArr addObject:attributedTextArr[i].string];
        }
        textArr = tmpArr;
    }
    CGFloat btnHeight = 44;
    if (textArr.count <= 3) {
        btnHeight = 50;
        titleLab.center = CGPointMake(view.frame.size.width/2, 32);
        line.frame = CGRectMake(0, 59.5, view.frame.size.width, 0.5);
    }
    else if (textArr.count <= 6) {
        btnHeight = 47;
        titleLab.center = CGPointMake(view.frame.size.width/2, 31);
        line.frame = CGRectMake(0, 56.5, view.frame.size.width, 0.5);
    }
    NSMutableArray <YQButton *> *btnsArr = [NSMutableArray new];
    for (NSInteger i=0; i<textArr.count; i++) {
        UIImage *icon = nil;
        if (iconArr!=nil && i<iconArr.count) {
            icon = iconArr[i];
        }
        NSAttributedString *attrStr = nil;
        if (attributedTextArr!=nil && i<attributedTextArr.count) {
            attrStr = attributedTextArr[i];
        }
        YQButton *btn = [selectorView createCellWithFrame:CGRectMake(15, CGRectGetMaxY(line.frame)+3+i*btnHeight, view.frame.size.width-30, btnHeight) icon:icon title:textArr[i] attributedTitle:attrStr image:imageOfSelected];
        btn.tag = i;
        [view addSubview:btn];
        [btnsArr addObject:btn];
        if (i==defaultSelectIndex) {
            btn.selected = YES;
        }
        btn.tapAction = ^(YQButton *sender) {
            for (NSInteger i=0; i<btnsArr.count; i++) {
                btnsArr[i].selected = NO;
            }
            sender.selected = YES;
            if (completion) {
                completion(sender.tag, [sender titleForState:UIControlStateNormal] ?: [sender attributedTitleForState:UIControlStateNormal].string);
            }
            if (selectorView.isAutoCloseWhenSelected == YES) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [UIView beginAnimations:nil context:nil];
                    [sender.superview.superview removeFromSuperview];
                    [UIView commitAnimations];
                });
            }
        };
    }
    if (btnsArr.lastObject) {
        CGRect iFrame = view.frame;
        iFrame.size.height = CGRectGetMaxY(btnsArr.lastObject.frame)+20;
        view.frame = iFrame;
    }
    selectorView.itemsArr = btnsArr;
    view.center = CGPointMake(selectorView.frame.size.width/2, selectorView.frame.size.height/2);
    
    return selectorView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Public
- (void)setItemsTextAlignment:(NSTextAlignment)textAlignment {
    if (self.itemsArr==nil || self.itemsArr.count<=0) {
        return;
    }
    for (NSInteger i=0; i<self.itemsArr.count; i++) {
        self.itemsArr[i].titleLabel.textAlignment = textAlignment;
    }
}



#pragma mark - Private
/**
 * 通过颜色来生成一个纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (YQButton *)createCellWithFrame:(CGRect)frame icon:(UIImage *)icon title:(NSString *)title attributedTitle:(NSAttributedString *)attributedTitle image:(UIImage *)image {
    if (icon == nil) {
        icon = [YQSelectorView imageWithColor:UIColor.clearColor size:CGSizeMake(1, 1)];
    }
    if (image == nil) {
        image = [YQSelectorView imageWithColor:UIColor.clearColor size:CGSizeMake(1, 1)];
    }
    YQButton *btn = [[YQButton alloc] initWithFrame:frame imageFrame:CGRectMake(frame.size.width-image.size.width, (frame.size.height-image.size.height)/2, image.size.width, image.size.height) titleFrame:CGRectMake(icon.size.width+5, (frame.size.height-22)/2, frame.size.width-(icon.size.width+5)-image.size.width-3, 22)];
    //
    UIImageView *iconIv = [[UIImageView alloc] initWithFrame:CGRectMake(0, (frame.size.height-icon.size.height)/2, icon.size.width, icon.size.height)];
    iconIv.tag = 100;
    iconIv.image = icon;
    [btn addSubview:iconIv];
    //
    [btn setImage:[YQSelectorView imageWithColor:UIColor.clearColor size:image.size] forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateSelected];
    if (attributedTitle) {
        [btn setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    }
    else {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0x55/255.0 green:0x55/255.0 blue:0x55/255.0 alpha:1.0] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0xff/255.0 green:0xa7/255.0 blue:0x26/255.0 alpha:1.0] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    if (icon.size.width==1 && image.size.width==1) {
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    //
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0xe8/255.0 green:0xe8/255.0 blue:0xe8/255.0 alpha:1.0];
    [btn addSubview:line];
    return btn;
}


@end
