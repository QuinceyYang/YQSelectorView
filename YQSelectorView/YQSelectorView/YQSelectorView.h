//
//  YQSelectorView.h
//  YQSelectorView
//
//  Created by 杨清 on 2019/6/10.
//  Copyright © 2019 QuinceyYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YQButton/YQButton.h>

NS_ASSUME_NONNULL_BEGIN

@interface YQSelectorView : UIView

@property (strong, nonatomic) UIView * contentView;
@property (strong, nonatomic) YQButton * confirmBtn; ///< 确定按钮，默认为nil
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) NSMutableArray <YQButton *> * itemsArr;
/// 用户必须选中一项，默认为YES
@property (assign, nonatomic) BOOL isMustSelectedOne;
/// 用户选择了某项后，是否自动关闭视图，默认为YES
@property (assign, nonatomic) BOOL isAutoCloseWhenSelected;

/**
 * 创建弹框选择器
 */
+ (instancetype)selectorViewWithFrame:(CGRect)frame title:(NSString *)title textArray:(NSArray *)textArr defaultSelectIndex:(NSInteger)defaultSelectIndex completion:(void (^)(NSInteger selectedIndex, NSString *selectedString))completion;

/**
 * 创建弹框选择器，选项有图标
 */
+ (instancetype)selectorViewWithFrame:(CGRect)frame title:(NSString *)title iconArr:(NSArray <UIImage *> * _Nullable)iconArr textArray:(NSArray *)textArr imageOfSelected:(UIImage *)imageOfSelected defaultSelectIndex:(NSInteger)defaultSelectIndex completion:(void (^)(NSInteger selectedIndex, NSString *selectedString))completion;

/**
 * 创建弹框选择器，选项有图标，选项文本为富文本
 */
+ (instancetype)selectorViewWithFrame:(CGRect)frame title:(NSString *)title iconArr:(NSArray <UIImage *> * _Nullable)iconArr attributedTextArray:(NSArray <NSAttributedString *> *)attributedTextArr imageOfSelected:(UIImage *)imageOfSelected defaultSelectIndex:(NSInteger)defaultSelectIndex completion:(void (^)(NSInteger selectedIndex, NSString *selectedString))completion;

/**
 * 创建全功能弹框选择器，不支持的参数可传空
 */
+ (instancetype)selectorViewWithFrame:(CGRect)frame contentWidthRatio:(CGFloat)contentWidthRatio contentHeightRatio:(CGFloat)contentHeightRatio cellHeight:(CGFloat)cellHeight title:(NSString *)title iconArr:(NSArray <UIImage *> * _Nullable)iconArr textArray:(NSArray * _Nullable)textArr attributedTextArray:(NSArray <NSAttributedString *> * _Nullable)attributedTextArr imageOfSelected:(UIImage * _Nullable)imageOfSelected defaultSelectIndex:(NSInteger)defaultSelectIndex isConfirmButton:(BOOL)isConfirmButton completion:(void (^)(NSInteger selectedIndex, NSString *selectedString))completion;


- (void)setItemsTextAlignment:(NSTextAlignment)textAlignment;

@end

NS_ASSUME_NONNULL_END
