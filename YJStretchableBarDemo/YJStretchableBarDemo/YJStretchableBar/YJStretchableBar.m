//
//  YJStretchableBar.m
//  YJStretchableBarDemo
//
//  Created by macintosh on 2016/10/25.
//  Copyright © 2016年 splashz. All rights reserved.

#import "YJStretchableBar.h"

#define MIN_DEMENSION 30
#define MIN_SPACING 0

@interface GatherControlToggle : UIView
{
    CAShapeLayer *_dynamicBar;
    CAShapeLayer *_stillBar;
}

@property (nonatomic, copy) void(^toggle)(BOOL isToggle);
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) BOOL isToggle;
@property (nonatomic, strong) UIColor *stickColor;
@property (nonatomic, strong) UIColor *toggleColor;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic) CGFloat demension;

@end

@implementation GatherControlToggle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _toggleColor = [UIColor colorWithWhite:0 alpha:0.4];
        
        _btn = [[UIButton alloc] initWithFrame:(CGRect){CGPointZero, frame.size}];
        [_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn];
        
        _demension = CGRectGetHeight(frame);
        
        _stillBar = [CAShapeLayer layer];
        _stickColor = [UIColor whiteColor];
        _stillBar.fillColor = _stickColor.CGColor;
        _stillBar.strokeColor = _stillBar.fillColor;
        _stillBar.lineWidth = 2;
        _stillBar.lineCap = kCALineCapRound;
        [self.layer addSublayer:_stillBar];
        
        _dynamicBar = [CAShapeLayer layer];
        _dynamicBar.fillColor = _stickColor.CGColor;
        _dynamicBar.strokeColor = _dynamicBar.fillColor;
        _dynamicBar.lineCap = kCALineCapRound;
        _dynamicBar.lineWidth = 2;
        [self.layer addSublayer:_dynamicBar];
        
        [self redraw];
        _duration = 0.25;
        _isToggle = NO;
    }
    return self;
}

- (void)redraw
{
    _btn.frame = CGRectMake(0, 0, _demension, _demension);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [self imageWithColor:_toggleColor size:_btn.frame.size];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_btn setImage:image forState:UIControlStateNormal];
        });
    });
    
    _stillBar.frame = CGRectMake(_demension * 0.25, _demension * 0.5 - 1, _demension * 0.5, 2);
    UIBezierPath *stillBarPath = [UIBezierPath bezierPath];
    [stillBarPath moveToPoint:CGPointMake(0, 1)];
    [stillBarPath addLineToPoint:CGPointMake(_stillBar.bounds.size.width, 1)];
    _stillBar.path = stillBarPath.CGPath;
    
    _dynamicBar.transform = CATransform3DIdentity;
    _dynamicBar.frame = CGRectMake(_demension * 0.5 - 1, _demension * 0.25, 2, _demension * 0.5);
    UIBezierPath *dynamicBarPath = [UIBezierPath bezierPath];
    [dynamicBarPath moveToPoint:CGPointMake(1, 0)];
    [dynamicBarPath addLineToPoint:CGPointMake(1, _dynamicBar.frame.size.height)];
    _dynamicBar.path = dynamicBarPath.CGPath;
    
    if (_btn.isSelected) {
        _dynamicBar.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
    } else {
        _dynamicBar.transform = CATransform3DIdentity;
    }
}

- (void)setDemension:(CGFloat)demension
{
    if (_demension == demension) {
        return;
    }
    
    _demension = demension;
    [self redraw];
}

- (void)setStickColor:(UIColor *)stickColor
{
    if (!stickColor || _stickColor == stickColor) {
        return;
    }
    
    _stickColor = stickColor;
    
    _stillBar.fillColor = stickColor.CGColor;
    _stillBar.strokeColor = _stillBar.fillColor;
    _dynamicBar.fillColor = stickColor.CGColor;
    _dynamicBar.strokeColor = _dynamicBar.fillColor;
}

- (void)setToggleColor:(UIColor *)toggleColor
{
    if (!toggleColor || _toggleColor == toggleColor) {
        return;
    }
    
    _toggleColor = toggleColor;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [self imageWithColor:_toggleColor size:_btn.frame.size];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_btn setImage:image forState:UIControlStateNormal];
        });
    });
}


- (void)btnClicked:(UIButton *)btn
{
    btn.selected = !btn.isSelected;
    _isToggle = btn.isSelected;
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:_duration];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    if (btn.isSelected) {
        _dynamicBar.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
    } else {
        _dynamicBar.transform = CATransform3DIdentity;
    }
    [CATransaction commit];
    
    if (_toggle) {
        _toggle(btn.isSelected);
    }
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextAddArc(context, size.width * 0.5, size.width * 0.5, size.width * 0.5, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end



@interface YJStretchableBar ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) GatherControlToggle *toggle;
@property (nonatomic, strong) NSArray<UIButton *> *buttons;
@property (nonatomic, assign) CGFloat barWidth;
@property (nonatomic, assign) CGRect foldedPortraitF;
@property (nonatomic, assign) CGRect foldedLandscapeF;
@property (nonatomic, assign) CGRect unfoldedPortraitF;
@property (nonatomic, assign) CGRect unfoldedLandscapeF;
@property (nonatomic, assign) BOOL isPortraitToggleFirst;
@property (nonatomic, assign) BOOL isLandscapeToggleFirst;

@end

@implementation YJStretchableBar

#define kScreenSize ScreenSize()
#define kScreenWidth ScreenSize().width
#define kScreenHeight ScreenSize().height

CGSize ScreenSize() {
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [UIScreen mainScreen].bounds.size;
        if (size.height < size.width) {
            CGFloat tmp = size.height;
            size.height = size.width;
            size.width = tmp;
        }
    });
    return size;
}

+ (CGRect)adaptFrameForUnfoldedBarWithBarWidth:(CGFloat)width
                                   foldedFrame:(CGRect)frame
                                    isPortrait:(BOOL)isPortrait
                                       isFirst:(inout BOOL *)isFirst
{
    CGRect newFrame;
    
    if (isPortrait) {
        //portrait
        newFrame = CGRectMake(CGRectGetMinX(frame), CGRectGetMidY(frame) > kScreenHeight * 0.5 ? (*isFirst = NO,CGRectGetMaxY(frame) - width) : (*isFirst = YES, CGRectGetMinY(frame)), CGRectGetWidth(frame), width);
    } else {
        //landscape
        newFrame = CGRectMake(CGRectGetMidX(frame) > kScreenWidth * 0.5 ? (*isFirst = NO, CGRectGetMaxX(frame) - width) : (*isFirst = YES, CGRectGetMinX(frame)), CGRectGetMinY(frame), width, CGRectGetHeight(frame));
    }
    
    return newFrame;
}

+ (instancetype)toolBarWithButtons:(NSArray<UIButton *> *)buttons
                       barItemSize:(CGSize)barItemSize
                     portraitPoint:(CGPoint)portraitPoint
                    landscapePoint:(CGPoint)landscapePoint
{
    CGFloat barW = (buttons.count + 1) * barItemSize.width * 1.5;
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGRect foldedPortraitFrame = (CGRect){portraitPoint, barItemSize};
    CGRect foldedLandscapeFrame = (CGRect){landscapePoint, barItemSize};
    
    CGRect newFrame = screenSize.width > screenSize.height ? foldedLandscapeFrame: foldedPortraitFrame;
    
    YJStretchableBar *controlBar = [[YJStretchableBar alloc] initWithFrame:newFrame];;
    controlBar.barWidth = barW;
    controlBar.spacing = barItemSize.width * 0.5;
    controlBar.demension = barItemSize.width;
    controlBar.foldedPortraitF = foldedPortraitFrame;
    controlBar.foldedLandscapeF = foldedLandscapeFrame;
    BOOL isPortraitToggleFirst;
    BOOL isLandscapeToggleFirst;
    controlBar.unfoldedPortraitF = [YJStretchableBar adaptFrameForUnfoldedBarWithBarWidth:barW
                                                                              foldedFrame:foldedPortraitFrame
                                                                               isPortrait:YES
                                                                                  isFirst:&isPortraitToggleFirst];
    controlBar.isPortraitToggleFirst = isPortraitToggleFirst;
    controlBar.unfoldedLandscapeF = [YJStretchableBar adaptFrameForUnfoldedBarWithBarWidth:barW
                                                                               foldedFrame:foldedLandscapeFrame
                                                                                isPortrait:NO
                                                                                   isFirst:&isLandscapeToggleFirst];
    controlBar.isLandscapeToggleFirst = isLandscapeToggleFirst;
    controlBar.buttons = buttons;
    [controlBar addSubview:controlBar.toggle];
    return controlBar;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _barColor = [UIColor colorWithWhite:0 alpha:0.3];
        _shapeLayer.fillColor = _barColor.CGColor;
        _shapeLayer.strokeColor = _shapeLayer.fillColor;
        _shapeLayer.lineCap = kCALineCapRound;
        _shapeLayer.strokeStart = 0;
        [self.layer addSublayer:_shapeLayer];
        _duration = 0.25;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didMoveToSuperview
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutSubviews) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    [self redrawBar];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    if (screenSize.width < screenSize.height) {
        self.frame = _unfoldedPortraitF;
        CGFloat btnW = CGRectGetWidth(self.frame);
        if (!_isPortraitToggleFirst) {
            [_buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.transform = CGAffineTransformIdentity;
                obj.frame = CGRectMake(0, btnW * 0.5 + (_spacing + btnW) * idx, btnW, btnW);
            }];
            _toggle.frame = CGRectMake(0, CGRectGetHeight(self.frame) - btnW, btnW, btnW);
            
            [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds) - 0.5 * btnW)];
            [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), 0.5 * btnW)];
        } else {
            _toggle.frame = CGRectMake(0, 0, btnW, btnW);
            [_buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.transform = CGAffineTransformIdentity;
                obj.frame = CGRectMake(0, CGRectGetMaxY(_toggle.frame) + 0.5 * btnW + (_spacing + btnW) * idx, btnW, btnW);
            }];
            
            [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), 0.5 * btnW)];
            [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds) - 0.5 * btnW)];
        }
    } else {
        self.frame = _unfoldedLandscapeF;
        CGFloat btnW = CGRectGetHeight(self.frame);
        if (!_isLandscapeToggleFirst) {
            [_buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.transform = CGAffineTransformIdentity;
                obj.frame = CGRectMake(btnW * 0.5 + (_spacing + btnW) * idx, 0, btnW, btnW);
            }];
            _toggle.frame = CGRectMake(CGRectGetWidth(self.frame) - btnW, 0, btnW, btnW);
            
            [path moveToPoint:CGPointMake(CGRectGetWidth(self.bounds) - 0.5 * btnW, CGRectGetMidY(self.bounds))];
            [path addLineToPoint:CGPointMake(0.5 * btnW, CGRectGetMidY(self.bounds))];
        } else {
            _toggle.frame = CGRectMake(0, 0, btnW, btnW);
            
            [_buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.transform = CGAffineTransformIdentity;
                obj.frame = CGRectMake(CGRectGetMaxX(_toggle.frame) + 0.5 * btnW + (_spacing + btnW) * idx, 0, btnW, btnW);
            }];
            
            [path moveToPoint:CGPointMake(0.5 * btnW, CGRectGetMidY(self.bounds))];
            [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) - 0.5 * btnW, CGRectGetMidY(self.bounds))];
        }
    }
    
    _shapeLayer.path = path.CGPath;
    
    if (!_toggle.isToggle) {
        [_buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.transform = CGAffineTransformMakeScale(0, 0);
        }];
    }
    
    [self redrawBar];
}

- (void)redrawBar
{
    _shapeLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _shapeLayer.lineWidth = _demension;
    if (self.toggle.isToggle) {
        _shapeLayer.strokeEnd = 1;
    } else {
        _shapeLayer.strokeEnd = 0;
    }
}

- (void)setButtons:(NSArray<UIButton *> *)buttons
{
    if (_buttons) {
        [_buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    
    _buttons = buttons;
    
    if (!_buttons) return;
    
    [_buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addSubview:obj];
    }];
}

- (void)setBarColor:(UIColor *)barColor
{
    if (!barColor || _barColor == barColor) {
        return;
    }
    
    _barColor = barColor;
    
    _shapeLayer.fillColor = _barColor.CGColor;
    _shapeLayer.strokeColor = _shapeLayer.fillColor;
}

- (void)setStickColor:(UIColor *)stickColor
{
    self.toggle.stickColor = stickColor;
}

- (void)setToggleColor:(UIColor *)toggleColor
{
    self.toggle.toggleColor = toggleColor;
}

- (void)setSpacing:(CGFloat)spacing
{
    spacing = spacing < MIN_SPACING ? MIN_SPACING : spacing;
    if (_spacing == spacing) {
        return;
    }
    _spacing = spacing;
    
    CGFloat barW = (_buttons.count + 1) * _demension + _spacing * _buttons.count + _demension * 0.5;
    _unfoldedLandscapeF = CGRectMake(_isLandscapeToggleFirst ? _unfoldedLandscapeF.origin.x : _foldedLandscapeF.origin.x - barW + _demension, _foldedLandscapeF.origin.y, barW, _demension);
    
    _unfoldedPortraitF = CGRectMake(_foldedPortraitF.origin.x, _isPortraitToggleFirst ? _unfoldedPortraitF.origin.y: _foldedPortraitF.origin.y - barW + _demension, _demension, barW);
    
    if (self.superview) {
        [self setNeedsLayout];
    }
}

- (void)setDemension:(CGFloat)demension
{
    if (_demension == demension) {
        return;
    }
    
    demension = demension < MIN_DEMENSION ? MIN_DEMENSION : demension;
    
    if (_demension == demension) {
        return;
    }
    
    _demension = demension;
    
    _foldedLandscapeF = CGRectMake(CGRectGetMidX(_foldedLandscapeF) - _demension * 0.5, CGRectGetMidY(_foldedLandscapeF) - _demension * 0.5, _demension, _demension);
    _foldedPortraitF = CGRectMake(CGRectGetMidX(_foldedPortraitF) - _demension * 0.5, CGRectGetMidY(_foldedPortraitF) - _demension * 0.5, _demension, _demension);
    
    CGFloat barW = (_buttons.count + 1) * _demension + _spacing * _buttons.count + _demension * 0.5;
    _unfoldedLandscapeF = CGRectMake(_isLandscapeToggleFirst ? _unfoldedLandscapeF.origin.x : _foldedLandscapeF.origin.x - barW + _demension, _foldedLandscapeF.origin.y, barW, _demension);
    
    _unfoldedPortraitF = CGRectMake(_foldedPortraitF.origin.x, _isPortraitToggleFirst ? _unfoldedPortraitF.origin.y: _foldedPortraitF.origin.y - barW + _demension, _demension, barW);
    
    _toggle.demension = _demension;
    if (self.superview) {
        [self setNeedsLayout];
    }
}

- (GatherControlToggle *)toggle
{
    if (!_toggle) {
        _toggle = [[GatherControlToggle alloc] initWithFrame:(CGRect){CGPointZero, _foldedPortraitF.size}];
        __weak typeof(self) weakSelf = self;
        _toggle.duration = _duration;
        _toggle.toggle = ^(BOOL isToggle) {
            CGSize screenSize = [UIScreen mainScreen].bounds.size;
            [UIView animateKeyframesWithDuration:weakSelf.duration delay:0 options:0 animations:^{
                if (isToggle) {
                    for (int i = 0; i < weakSelf.buttons.count; i ++) {
                        [UIView addKeyframeWithRelativeStartTime: (double)i / weakSelf.buttons.count
                                                relativeDuration: (double)1 / weakSelf.buttons.count
                                                      animations: ^{
                                                          UIButton *btn;
                                                          if (screenSize.width < screenSize.height) {
                                                              if (!weakSelf.isPortraitToggleFirst) {
                                                                  btn = weakSelf.buttons[weakSelf.buttons.count - (i + 1)];
                                                              } else {
                                                                  btn = weakSelf.buttons[i];
                                                              }
                                                          } else {
                                                              if (!weakSelf.isLandscapeToggleFirst) {
                                                                  btn = weakSelf.buttons[weakSelf.buttons.count - (i + 1)];
                                                              } else {
                                                                  btn = weakSelf.buttons[i];
                                                              }
                                                          }
                                                          btn.transform = CGAffineTransformIdentity;
                                                      }];
                    }
                } else {
                    for (int i = 0; i < weakSelf.buttons.count; i ++) {
                        [UIView addKeyframeWithRelativeStartTime: (double)i / weakSelf.buttons.count
                                                relativeDuration: (double)1 / weakSelf.buttons.count
                                                      animations: ^{
                                                          UIButton *btn;
                                                          if (screenSize.width < screenSize.height) {
                                                              if (!weakSelf.isPortraitToggleFirst) {
                                                                  btn = weakSelf.buttons[i];
                                                              } else {
                                                                  btn = weakSelf.buttons[weakSelf.buttons.count - (i + 1)];
                                                              }
                                                          } else {
                                                              if (!weakSelf.isLandscapeToggleFirst) {
                                                                  btn = weakSelf.buttons[i];
                                                              } else {
                                                                  btn = weakSelf.buttons[weakSelf.buttons.count - (i + 1)];
                                                              }
                                                          }
                                                
                                                          btn.transform = CGAffineTransformMakeScale(0, 0);
                                                      }];
                    }
                }
            } completion:nil];
            
            [CATransaction begin];
            [CATransaction setAnimationDuration:weakSelf.duration];
            if (isToggle) {
                weakSelf.shapeLayer.strokeEnd = 1;
            } else {
                weakSelf.shapeLayer.strokeEnd = 0;
            }
            [CATransaction commit];
        };
    }
    return _toggle;
}



@end
