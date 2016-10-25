YJStretchableBar
==================

YJStretchableToolBar 是一个非常简单易用的可伸缩控制条。

安装
==================

1. 在 Podfile 中添加  `pod 'YJStretchableBar'`。
2. 执行 `pod install` 或 `pod update`。
3. 导入 \<YJStretchableBar/YJStretchableBar.h>\>。

特色
==================

- 支持横竖屏
- 智能判断伸缩方向
- 集成简单，无侵染

使用
==================

一个类方法即可轻松完成初始化

```objc
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
```

完整例子请参照 demo

![image](https://github.com/SplashZ/YJStretchableBar/blob/master/portrait.gif)
![image](https://github.com/SplashZ/YJStretchableBar/blob/master/landscape.gif)

配置
==================

- ARC
- 该项目最低支持 `iOS 8.0` 和 `Xcode 7.0`。
- 同时支持 iPhone 和 iPad

许可证
==================

YJStretchableBar 使用 MIT 许可证，详情见 LICENSE 文件。

