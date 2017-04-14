//
//  BJFXAlertView.h
//  BJFXAlertView
//
//  Created by Apple on 2017/4/12.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJFXAlertView : UIView


/**
 快速创建并显示弹框的方法

 @param title 弹框标题
 @param message 提示的内容
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;


/**
 创建弹框的方法（默认不会显示，需调用show方法）

 @param title 弹框标题
 @param message 提示的内容
 @return 返回创建好的弹框对象
 */
+ (BJFXAlertView *)AlertWithTitle:(NSString *)title message:(NSString *)message;


/**
 给弹框的添加按钮和点击方法

 @param title 按钮上的文字
 @param action 点击事件
 @return 返回处理后的弹框对象
 */
- (BJFXAlertView *)addButtonTitle:(NSString *)title action:(void(^)())action;


/**
 显示弹框
 */
- (void)show;


@end
