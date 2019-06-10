//
//  YQSelectorView.m
//  YQSelectorView
//
//  Created by 杨清 on 2019/6/10.
//  Copyright © 2019 QuinceyYang. All rights reserved.
//

#import "YQSelectorView.h"

@implementation YQSelectorView

+ (instancetype)selectorViewWithFrame:(CGRect)frame title:(NSString *)title itemArray:(NSMutableArray *)itemArr selectIndex:(NSInteger)selectIndex completion:(void (^)(NSInteger selectedIndex, NSString *selectedString))completion {
    return [YQSelectorView selectorViewWithFrame:frame title:title itemArray:itemArr imageOfSelected:nil selectIndex:selectIndex completion:completion];
}


+ (instancetype)selectorViewWithFrame:(CGRect)frame title:(NSString *)title itemArray:(NSMutableArray *)itemArr imageOfSelected:(UIImage *)imageOfSelected selectIndex:(NSInteger)selectIndex completion:(void (^)(NSInteger selectedIndex, NSString *selectedString))completion {
    
    YQSelectorView *selectorView = [[YQSelectorView alloc] initWithFrame:frame];
    selectorView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    selectorView.isAutoCloseWhenSelected = YES;
    //
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, selectorView.frame.size.width-100, selectorView.frame.size.height-160)];
    view.layer.cornerRadius = 6;
    view.layer.masksToBounds = YES;
    view.backgroundColor = UIColor.whiteColor;
    [selectorView addSubview:view];
    //
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 13, view.frame.size.width-80, 20)];
    titleLab.text = title;
    titleLab.textColor = [UIColor colorWithRed:0x33/255.0 green:0x33/255.0 blue:0x33/255.0 alpha:1.0];
    titleLab.font = [UIFont systemFontOfSize:17];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLab];
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
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 44.5, view.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0xe8/255.0 green:0xe8/255.0 blue:0xe8/255.0 alpha:1.0];
    [view addSubview:line];
    //
    if (itemArr==nil || itemArr.count<=0) {
        return selectorView;
    }
    NSMutableArray <YQButton *> *btnsArr = [NSMutableArray new];
    for (NSInteger i=0; i<itemArr.count; i++) {
        YQButton *btn = [selectorView createCellWithFrame:CGRectMake(15, 50+i*44, view.frame.size.width-30, 44) title:itemArr[i] image:imageOfSelected];
        btn.tag = i;
        [view addSubview:btn];
        [btnsArr addObject:btn];
        if (i==selectIndex) {
            btn.selected = YES;
        }
        btn.tapAction = ^(YQButton *sender) {
            for (NSInteger i=0; i<btnsArr.count; i++) {
                btnsArr[i].selected = NO;
            }
            sender.selected = YES;
            if (completion) {
                completion(sender.tag, [sender titleForState:UIControlStateNormal]);
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
        iFrame.size.height = CGRectGetMaxY(btnsArr.lastObject.frame)+30;
        view.frame = iFrame;
    }
    selectorView.itemsArr = btnsArr;
    view.center = CGPointMake(selectorView.frame.size.width/2, selectorView.frame.size.height/2);

    return selectorView;
}


+ (instancetype)selectorViewWithFrame:(CGRect)frame title:(NSString *)title itemArray:(NSMutableArray *)itemArr iconArr:(NSArray <UIImage *> *)iconArr imageOfSelected:(UIImage *)imageOfSelected selectIndex:(NSInteger)selectIndex completion:(void (^)(NSInteger selectedIndex, NSString *selectedString))completion {
    
    YQSelectorView *selectorView = [[YQSelectorView alloc] initWithFrame:frame];
    selectorView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    selectorView.isAutoCloseWhenSelected = YES;
    //
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, selectorView.frame.size.width-100, selectorView.frame.size.height-160)];
    view.layer.cornerRadius = 6;
    view.layer.masksToBounds = YES;
    view.backgroundColor = UIColor.whiteColor;
    [selectorView addSubview:view];
    //
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 13, view.frame.size.width-80, 20)];
    titleLab.text = title;
    titleLab.textColor = [UIColor colorWithRed:0x33/255.0 green:0x33/255.0 blue:0x33/255.0 alpha:1.0];
    titleLab.font = [UIFont systemFontOfSize:17];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLab];
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
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 44.5, view.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0xe8/255.0 green:0xe8/255.0 blue:0xe8/255.0 alpha:1.0];
    [view addSubview:line];
    //
    if (itemArr==nil || itemArr.count<=0) {
        return selectorView;
    }
    NSMutableArray <YQButton *> *btnsArr = [NSMutableArray new];
    for (NSInteger i=0; i<itemArr.count; i++) {
        UIImage *icon = nil;
        if (iconArr != nil && i < iconArr.count) {
            icon = iconArr[i];
        }
        YQButton *btn = [selectorView createCellWithFrame:CGRectMake(15, 50+i*44, view.frame.size.width-30, 44) icon:icon title:itemArr[i] image:imageOfSelected];
        btn.tag = i;
        [view addSubview:btn];
        [btnsArr addObject:btn];
        if (i==selectIndex) {
            btn.selected = YES;
        }
        btn.tapAction = ^(YQButton *sender) {
            for (NSInteger i=0; i<btnsArr.count; i++) {
                btnsArr[i].selected = NO;
            }
            sender.selected = YES;
            if (completion) {
                completion(sender.tag, [sender titleForState:UIControlStateNormal]);
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
        iFrame.size.height = CGRectGetMaxY(btnsArr.lastObject.frame)+30;
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
- (void)setItemsTitleAlignment:(NSTextAlignment)titleAlignment {
    if (self.itemsArr==nil || self.itemsArr.count<=0) {
        return;
    }
    for (NSInteger i=0; i<self.itemsArr.count; i++) {
        self.itemsArr[i].titleLabel.textAlignment = titleAlignment;
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

- (YQButton *)createCellWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image {
    YQButton *btn;
    if (image == nil) {
        image = [YQSelectorView imageWithColor:UIColor.clearColor size:CGSizeMake(1, 1)];
        btn = [[YQButton alloc] initWithFrame:frame imageFrame:CGRectMake(frame.size.width-image.size.width, (frame.size.height-image.size.height)/2, image.size.width, image.size.height) titleFrame:CGRectMake(10, (frame.size.height-20)/2, frame.size.width-10-10-image.size.width, 20)];
    }
    else {
        btn = [[YQButton alloc] initWithFrame:frame imageFrame:CGRectMake(frame.size.width-image.size.width-10, (frame.size.height-image.size.height)/2, image.size.width, image.size.height) titleFrame:CGRectMake(10, (frame.size.height-20)/2, frame.size.width-10-10-image.size.width-5, 20)];
    }
    
    [btn setImage:[YQSelectorView imageWithColor:UIColor.clearColor size:image.size] forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0x66/255.0 green:0x66/255.0 blue:0x66/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0xff/255.0 green:0xa7/255.0 blue:0x26/255.0 alpha:1.0] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    //
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0xe8/255.0 green:0xe8/255.0 blue:0xe8/255.0 alpha:1.0];
    [btn addSubview:line];
    return btn;
}

- (YQButton *)createCellWithFrame:(CGRect)frame icon:(UIImage *)icon title:(NSString *)title image:(UIImage *)image {
    if (icon == nil) {
        icon = [YQSelectorView imageWithColor:UIColor.clearColor size:CGSizeMake(1, 1)];
    }
    YQButton *btn;
    if (image == nil) {
        image = [YQSelectorView imageWithColor:UIColor.clearColor size:CGSizeMake(1, 1)];
        btn = [[YQButton alloc] initWithFrame:frame imageFrame:CGRectMake(frame.size.width-image.size.width, (frame.size.height-image.size.height)/2, image.size.width, image.size.height) titleFrame:CGRectMake(icon.size.width+3, (frame.size.height-20)/2, frame.size.width-(icon.size.width+3)-10-image.size.width, 20)];
    }
    else {
        btn = [[YQButton alloc] initWithFrame:frame imageFrame:CGRectMake(frame.size.width-image.size.width-10, (frame.size.height-image.size.height)/2, image.size.width, image.size.height) titleFrame:CGRectMake(icon.size.width+3, (frame.size.height-20)/2, frame.size.width-(icon.size.width+3)-10-image.size.width-5, 20)];
    }
    UIImageView *iconIv = [[UIImageView alloc] initWithImage:icon];
    iconIv.tag = 100;
    iconIv.center = CGPointMake(iconIv.frame.size.width/2, btn.frame.size.height/2);
    [btn addSubview:iconIv];
    //
    [btn setImage:[YQSelectorView imageWithColor:UIColor.clearColor size:image.size] forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0x66/255.0 green:0x66/255.0 blue:0x66/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0xff/255.0 green:0xa7/255.0 blue:0x26/255.0 alpha:1.0] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    //
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0xe8/255.0 green:0xe8/255.0 blue:0xe8/255.0 alpha:1.0];
    [btn addSubview:line];
    return btn;
}


@end
