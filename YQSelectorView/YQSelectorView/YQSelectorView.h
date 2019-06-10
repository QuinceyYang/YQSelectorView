//
//  YQSelectorView.h
//  YQSelectorView
//
//  Created by 杨清 on 2019/6/10.
//  Copyright © 2019 QuinceyYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQButton.h"

typedef NS_ENUM(NSUInteger, YQSelectorViewType) {
    YQSelectorViewTypeDefault,
    YQSelectorViewTypeTitleAtCenter,
};


NS_ASSUME_NONNULL_BEGIN

@interface YQSelectorView : UIView

@property (strong, nonatomic) NSMutableArray <YQButton *> * itemsArr;

+ (instancetype)selectorViewWithFrame:(CGRect)frame title:(NSString *)title itemArray:(NSMutableArray *)itemArr selectIndex:(NSInteger)selectIndex completion:(void (^)(NSInteger selectedIndex, NSString *selectedString))completion;

+ (instancetype)selectorViewWithFrame:(CGRect)frame title:(NSString *)title itemArray:(NSMutableArray *)itemArr imageOfSelected:(UIImage * _Nullable)imageOfSelected selectIndex:(NSInteger)selectIndex completion:(void (^)(NSInteger selectedIndex, NSString *selectedString))completion;

- (void)setItemsTitleAlignment:(NSTextAlignment)titleAlignment;

@end

NS_ASSUME_NONNULL_END
