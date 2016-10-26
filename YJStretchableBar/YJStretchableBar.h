//
//  YJStretchableBar.h
//  YJStretchableBarDemo
//
//  Created by macintosh on 2016/10/25.
//  Copyright © 2016年 splashz. All rights reserved.

#import <UIKit/UIKit.h>

@interface YJStretchableBar : UIView

///伸缩动画的持续时间，默认为0.25
@property (nonatomic, assign) NSTimeInterval duration;

///伸缩条的颜色
@property (nonatomic, strong) UIColor *barColor;

///加减符号的颜色
@property (nonatomic, strong) UIColor *stickColor;

///伸缩控制按钮颜色
@property (nonatomic, strong) UIColor *toggleColor;

///按钮之间的间距，默认为按钮宽度的一半
@property (nonatomic) CGFloat spacing;

///按钮大小
@property (nonatomic) CGFloat demension;


/**
 初始化伸缩条

 @param buttons        伸缩条上的按钮
 @param barItemSize    按钮大小
 @param portraitPoint  竖屏位置
 @param landscapePoint 横屏位置

 @return 伸缩条
 */
+ (instancetype)toolBarWithButtons:(NSArray<UIButton *> *)buttons
                       barItemSize:(CGSize)barItemSize
                     portraitPoint:(CGPoint)portraitPoint
                    landscapePoint:(CGPoint)landscapePoint;

@end
