YJStretchableBar
==================
[![CocoaPods](http://img.shields.io/cocoapods/v/YJStretchableBar.svg?style=flat)](http://cocoapods.org/?q= YJStretchableBar)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/YJStretchableBar.svg?style=flat)](http://cocoapods.org/?q= YJStretchableBar)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg?style=flat)](https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg?style=flat)&nbsp;
[![Travis-CI](https://travis-ci.org/SplashZ/YJStretchableBar.svg?branch=master)](https://travis-ci.org/SplashZ/YJStretchableBar)
![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)

![demogif](https://github.com/SplashZ/YJStretchableBar/blob/master/demo.gif)
<br>

English
==================
YJStretchableToolBar is an easy and stretchable tool bar.。

Installation
==================

1. Add pod 'YJStretchableBar' to your Podfile.
2. Run pod install or pod update.
3. import <YJStretchableBar/YJStretchableBar.h>.

Feature
==================

- Support to portrait & landscape
- Sepcify stretching orientation automatically.
- Easy and loose coupling

Usage
==================

```objc
    
    _controlBar = [YJStretchableBar toolBarWithButtons:btnArr
                                           barItemSize:CGSizeMake(50, 50)
                                         portraitPoint:CGPointMake(0, CGRectGetMidY(self.view.frame) - 25 + 1)
                                        landscapePoint:CGPointMake(CGRectGetHeight(self.view.frame) * 0.5 - 25 - 1, 0)];
```

See demo for details.

Requirements
==================

- ARC
- Requires iOS 7.0+.
- Adapt to both iPhone & iPad.

License
==================

YJStretchableBar is provided under the MIT license.See LICENSE file for details.



Chiness
==================

YJStretchableToolBar 是一个非常简单易用的可伸缩控制条。

安装
==================

1. 在 Podfile 中添加  `pod 'YJStretchableBar'`。
2. 执行 `pod install` 或 `pod update`。
3. 导入 <YJStretchableBar/YJStretchableBar.h>。

特色
==================

- 支持横竖屏
- 智能判断伸缩方向
- 集成简单，无侵染

使用
==================


```objc

_controlBar = [YJStretchableBar toolBarWithButtons:btnArr
                                           barItemSize:CGSizeMake(50, 50)
                                         portraitPoint:CGPointMake(0, CGRectGetMidY(self.view.frame) - 25 + 1)
                                        landscapePoint:CGPointMake(CGRectGetHeight(self.view.frame) * 0.5 - 25 - 1, 0)];
```

完整例子请参照 demo

配置
==================

- ARC
- 该项目最低支持 `iOS 7.0`。
- 同时支持 iPhone 和 iPad

许可证
==================

YJStretchableBar 使用 MIT 许可证，详情见 LICENSE 文件。

