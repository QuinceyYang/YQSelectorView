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
    
    return [YQSelectorView selectorViewWithFrame:frame contentWidthRatio:0 contentHeightRatio:0 cellHeight:50 title:title iconArr:iconArr textArray:textArr attributedTextArray:attributedTextArr imageOfSelected:imageOfSelected defaultSelectIndex:defaultSelectIndex isConfirmButton:NO completion:completion];
}

+ (instancetype)selectorViewWithFrame:(CGRect)frame contentWidthRatio:(CGFloat)contentWidthRatio contentHeightRatio:(CGFloat)contentHeightRatio cellHeight:(CGFloat)cellHeight title:(NSString *)title iconArr:(NSArray <UIImage *> * _Nullable)iconArr textArray:(NSArray * _Nullable)textArr attributedTextArray:(NSArray <NSAttributedString *> * _Nullable)attributedTextArr imageOfSelected:(UIImage * _Nullable)imageOfSelected defaultSelectIndex:(NSInteger)defaultSelectIndex isConfirmButton:(BOOL)isConfirmButton completion:(void (^)(NSInteger selectedIndex, NSString *selectedString))completion {
    
    YQSelectorView *selectorView = [[YQSelectorView alloc] initWithFrame:frame];
    selectorView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    selectorView.isAutoCloseWhenSelected = YES;
    selectorView.isMustSelectedOne = YES;
    //
    CGFloat maxContentWidth = contentWidthRatio>0 ? contentWidthRatio*selectorView.frame.size.width : (295.0/375.0)*selectorView.frame.size.width;
    CGFloat maxContentHeight = contentHeightRatio>0 ? contentHeightRatio*selectorView.frame.size.height : (507.0/667.0)*selectorView.frame.size.height;

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, maxContentWidth, maxContentHeight)];
    view.layer.cornerRadius = 6;
    view.layer.masksToBounds = YES;
    view.backgroundColor = UIColor.whiteColor;
    [selectorView addSubview:view];
    selectorView.contentView = view;
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
        [selectorView removeFromSuperview];
        [UIView commitAnimations];
    };
    if (isConfirmButton == YES) {
        closeBtn.hidden = YES;
    }
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
    CGFloat btnHeight = cellHeight>=44 ? cellHeight : 44;
    if (btnHeight>=50) {
        titleLab.center = CGPointMake(view.frame.size.width/2, 32);
        line.frame = CGRectMake(0, 59.5, view.frame.size.width, 0.5);
    }
    else if (btnHeight>=47) {
        titleLab.center = CGPointMake(view.frame.size.width/2, 31);
        line.frame = CGRectMake(0, 56.5, view.frame.size.width, 0.5);
    }
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), view.frame.size.width, view.frame.size.height-CGRectGetMaxY(line.frame))];
    [view addSubview:scrollView];
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
        YQButton *btn = [selectorView createCellWithFrame:CGRectMake(0, 3+i*btnHeight, scrollView.frame.size.width, btnHeight) icon:icon title:textArr[i] attributedTitle:attrStr image:imageOfSelected];
        btn.tag = i;
        [scrollView addSubview:btn];
        [btnsArr addObject:btn];
        if (i==defaultSelectIndex) {
            btn.selected = YES;
        }
        btn.tapAction = ^(YQButton *sender) {
            
            for (NSInteger i=0; i<btnsArr.count; i++) {
                if (btnsArr[i] != sender) {
                    btnsArr[i].selected = NO;
                }
            }
            if (selectorView.isMustSelectedOne == YES) {
                sender.selected = YES;
            }
            else {
                sender.selected = !sender.selected;
            }
            
            if (completion && isConfirmButton==NO) {
                if (sender.selected == YES) {
                    completion(sender.tag, [sender titleForState:UIControlStateNormal] ?: [sender attributedTitleForState:UIControlStateNormal].string);
                }
                else {
                    completion(-1, nil);
                }
            }
            
            if (selectorView.isAutoCloseWhenSelected == YES && sender.selected == YES && isConfirmButton==NO) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [UIView beginAnimations:nil context:nil];
                    [selectorView removeFromSuperview];
                    [UIView commitAnimations];
                });
            }
        };
    }
    if (btnsArr.lastObject) {
        if (scrollView.frame.origin.y+CGRectGetMaxY(btnsArr.lastObject.frame) > maxContentHeight) {
            scrollView.frame = CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, scrollView.frame.size.width, maxContentHeight-scrollView.frame.origin.y);
        }
        else {
            scrollView.frame = CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, scrollView.frame.size.width, CGRectGetMaxY(btnsArr.lastObject.frame));
        }
        if (CGRectGetMaxY(btnsArr.lastObject.frame) > scrollView.frame.size.height) {
            scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(btnsArr.lastObject.frame)+30);
        }
        else {
            scrollView.contentSize = CGSizeZero;
        }
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, CGRectGetMaxY(scrollView.frame));
    }
    selectorView.itemsArr = btnsArr;
    view.center = CGPointMake(selectorView.frame.size.width/2, selectorView.frame.size.height/2);
    
    if (isConfirmButton == YES) {
        CGFloat scrollViewHeight = maxContentHeight-scrollView.frame.origin.y-110 > 0 ?  maxContentHeight-scrollView.frame.origin.y-110 : 50;
        scrollView.frame = CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, scrollView.frame.size.width, scrollViewHeight);
        if (CGRectGetMaxY(btnsArr.lastObject.frame) > scrollView.frame.size.height) {
            scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(btnsArr.lastObject.frame)+30);
        }
        else {
            scrollView.contentSize = CGSizeZero;
        }
        //
        YQButton * confirmBtn = [[YQButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(scrollView.frame)+40, view.frame.size.width-30, 46)];
        [confirmBtn setBackgroundImage:[YQSelectorView imageWithColor:[UIColor colorWithRed:0xff/255.0 green:0xa7/255.0 blue:0x26/255.0 alpha:1.0] size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
        [confirmBtn setTitle:@"确 定" forState:UIControlStateNormal];
        [confirmBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        confirmBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [view addSubview:confirmBtn];
        selectorView.confirmBtn = confirmBtn;
        //
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, maxContentHeight);
        view.center = CGPointMake(selectorView.frame.size.width/2, selectorView.frame.size.height/2);
        //
        confirmBtn.tapAction = ^(YQButton *sender) {
            
            NSInteger flg = -1;
            for (NSInteger i=0; i<btnsArr.count; i++) {
                if (btnsArr[i].selected == YES) {
                    flg = i;
                    break;
                }
            }
            
            if (completion) {
                if (0<=flg && flg<btnsArr.count) {
                    completion(flg, [btnsArr[flg] titleForState:UIControlStateNormal] ?: [btnsArr[flg] attributedTitleForState:UIControlStateNormal].string);
                }
                else {
                    completion(-1, nil);
                }
            }

            [UIView beginAnimations:nil context:nil];
            [selectorView removeFromSuperview];
            [UIView commitAnimations];

        };
    }
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
    
    CGRect iconFrame = CGRectMake(15, (frame.size.height-icon.size.height)/2, icon.size.width, icon.size.height);
    CGRect titleFrame = CGRectMake(CGRectGetMaxX(iconFrame)+5, 1, frame.size.width-(CGRectGetMaxX(iconFrame)+5)-(image.size.width+15)-3, frame.size.height-2);
    CGRect imageFrame = CGRectMake(frame.size.width-image.size.width-15, (frame.size.height-image.size.height)/2, image.size.width, image.size.height);
    
    YQButton *btn = [[YQButton alloc] initWithFrame:frame imageFrame:imageFrame titleFrame:titleFrame];
    //
    UIImageView *iconIv = [[UIImageView alloc] initWithFrame:iconFrame];
    iconIv.tag = 100001;
    iconIv.image = icon;
    [btn addSubview:iconIv];
    //
    [btn setImage:[YQSelectorView imageWithColor:UIColor.clearColor size:image.size] forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateSelected];
    if (attributedTitle) {
        btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;//换行模式自动换行
        btn.titleLabel.numberOfLines = 0;
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
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, frame.size.height-0.5, frame.size.width-30, 0.5)];
    line.tag = 100004;
    line.backgroundColor = [UIColor colorWithRed:0xe8/255.0 green:0xe8/255.0 blue:0xe8/255.0 alpha:1.0];
    [btn addSubview:line];
    return btn;
}


@end
