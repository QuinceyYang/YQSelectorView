//
//  YQSelectorView.h
//  YQSelectorView
//
//  Created by 杨清 on 2019/6/10.
//  Copyright © 2019 QuinceyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YQSelectorViewType) {
    YQSelectorViewTypeDefault,
    YQSelectorViewTypeTitleAtCenter,
};


NS_ASSUME_NONNULL_BEGIN

@interface YQSelectorView : UIView

+ (instancetype)selectorViewWithFrame:(CGRect)frame title:(NSString *)title itemArray:(NSMutableArray *)itemArr selectIndex:(NSInteger)selectIndex completion:(void (^)(NSInteger selectedIndex, NSString *selectedString))completion;

+ (instancetype)selectorViewWithFrame:(CGRect)frame title:(NSString *)title itemArray:(NSMutableArray *)itemArr imageOfSelected:(UIImage *)imageOfSelected selectIndex:(NSInteger)selectIndex completion:(void (^)(NSInteger selectedIndex, NSString *selectedString))completion;
@end

NS_ASSUME_NONNULL_END
