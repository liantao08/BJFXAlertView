# BJFXAlertView

### 效果如下

- jpeg：

![](https://github.com/liantao08/BJFXAlertView/blob/master/BJFXAlertView/BJFXAlertView/alertView.jpeg)

### 使用方法

* 先将头文件导入工程中，然后直接调用即可
有两种调用的方法：1.只需要显示alert弹窗，并不需要触发点击事件，一行代码即可，自带一个确认按钮无点击事件。
```objc
[BJFXAlertView showAlertWithTitle:@"提示" message:@"我是一个alertView"];
```

2.需要有至少一个点击事件，可在点击事件里添加需要的东西 push，block

```objc
BJFXAlertView * alertView = [BJFXAlertView AlertWithTitle:@"提示" message:@"请选择"];
[alertView addButtonTitle:@"sure" action:^{

NSLog(@"点击sure");
}];

[alertView addButtonTitle:@"cancel" action:^{

NSLog(@"点击cancel");
}];

[alertView show];
```
