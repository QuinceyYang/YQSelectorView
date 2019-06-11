//
//  YQSelectorView.h
//  YQSelectorView
//
//  Created by 杨清 on 2019/6/10.
//  Copyright © 2019 QuinceyYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YQButton.h>

typedef NS_ENUM(NSUInteger, YQSelectorViewType) {
    YQSelectorViewTypeDefault,
    YQSelectorViewTypeTitleAtCenter,
};


NS_ASSUME_NONNULL_BEGIN

@interface YQSelectorView : UIView

@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) NSMutableArray <YQButton *> * itemsArr;
/// 用户选择了某项后，是否自动关闭视图，默认为YES
@property (assign, nonatomic) BOOL isAutoCloseWhenSelected;

+ (instancetype)selectorViewWithFrame:(CGRect)frame title:(NSString *)title textArray:(NSArray *)textArr selectIndex:(NSInteger)selectIndex completion:(void (^)(NSInteger selectedIndex, NSString *selectedString))completion;

+ (instancetype)selectorViewWithFrame:(CGRect)frame title:(NSString *)title iconArr:(NSArray <UIImage *> * _Nullable)iconArr textArray:(NSArray *)textArr imageOfSelected:(UIImage *)imageOfSelected selectIndex:(NSInteger)selectIndex completion:(void (^)(NSInteger selectedIndex, NSString *selectedString))completion;

+ (instancetype)selectorViewWithFrame:(CGRect)frame title:(NSString *)title iconArr:(NSArray <UIImage *> * _Nullable)iconArr attributedTextArray:(NSArray <NSAttributedString *> *)attributedTextArr imageOfSelected:(UIImage *)imageOfSelected selectIndex:(NSInteger)selectIndex completion:(void (^)(NSInteger selectedIndex, NSString *selectedString))completion;


- (void)setItemsTextAlignment:(NSTextAlignment)textAlignment;

@end

NS_ASSUME_NONNULL_END
