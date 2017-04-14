//
//  BJFXAlertView.m
//  BJFXAlertView
//
//  Created by Apple on 2017/4/12.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "BJFXAlertView.h"
#import "Masonry.h"

//屏幕宽
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
//屏幕高
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//色值
#define RGAB(R, G, B, A)  [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
//缩放因子
#define SCALE [UIScreen mainScreen].bounds.size.width / 375.0
// 非空字符串
#define  NoNilString(s) (s) ? (s) : @""


@interface BJFXAlertView ()

@property (nonatomic, weak)UIView * bgView;

@property (nonatomic, weak)UIView * showView;

@property (nonatomic, weak)UILabel * myTitleLabel;

@property (nonatomic, weak)UILabel * messageLabel;

@property (nonatomic, weak)UIView * line1;

@property (nonatomic, weak)UIButton * button1;

@property (nonatomic,strong)NSMutableArray * actionArray;

@end

@implementation BJFXAlertView

- (NSMutableArray *)actionArray{
    
    if (nil == _actionArray) {
        _actionArray = [NSMutableArray array];
    }
    return _actionArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    UIView * showView = [[UIView alloc] init];
    UILabel * myTitleLabel    = [[UILabel alloc] init];
    UILabel * messageLabel  = [[UILabel alloc] init];
    UIView * line1 = [[UIView alloc] init];
    UIButton * button1 = [[UIButton alloc] init];
    
    [self addSubview:bgView];
    [bgView addSubview:showView];
    [showView addSubview:myTitleLabel];
    [showView addSubview:messageLabel];
    [showView addSubview:line1];
    [showView addSubview:button1];
    
    self.bgView = bgView;
    self.showView = showView;
    self.myTitleLabel = myTitleLabel;
    self.messageLabel = messageLabel;
    self.line1 = line1;
    self.button1 = button1;
    
    bgView.backgroundColor = RGAB(0, 0, 0, 0.25);
    showView.backgroundColor = RGAB(249, 248, 248, 1);
    line1.backgroundColor = RGAB(220, 210, 215, 1);
    [button1 setTitleColor:RGAB(17, 107, 255, 1) forState:UIControlStateNormal];
    
    myTitleLabel.font = [UIFont boldSystemFontOfSize:16 * SCALE];
    messageLabel.font = [UIFont systemFontOfSize:13 * SCALE];
    
    showView.layer.cornerRadius = 10;
    showView.clipsToBounds = YES;
    
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    
    [button1 setTitle:@"确定" forState:UIControlStateNormal];
    
    [showView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(bgView);
        make.width.mas_equalTo(270 * SCALE);
    }];
    
    [myTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(showView);
        make.top.equalTo(showView).offset(22 * SCALE);
    }];
    
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(showView);
        make.top.equalTo(myTitleLabel.mas_bottom).offset(7 * SCALE);
        make.width.mas_equalTo(222 * SCALE);
    }];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(messageLabel.mas_bottom).offset(22 * SCALE);
        make.height.mas_equalTo(0.5);
        make.left.right.equalTo(showView);
    }];
    
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(showView);
        make.top.equalTo(line1.mas_bottom);
        make.height.mas_equalTo(44 * SCALE);
        make.bottom.equalTo(showView);
    }];
}



+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message{
    
    BJFXAlertView * tempView = [self AlertWithTitle:title message:message];
    [tempView show];
}


+ (BJFXAlertView *)AlertWithTitle:(NSString *)title message:(NSString *)message{
    
    BJFXAlertView * tempView = [[BJFXAlertView alloc] init];
    
    [tempView setValue:title forKeyPath:@"myTitleLabel.text"];
    [tempView setValue:message forKeyPath:@"messageLabel.text"];
    
    return tempView;
}

- (BJFXAlertView *)addButtonTitle:(NSString *)title action:(void (^)())action{
    
    BJFXAlertView * tempView = [[BJFXAlertView alloc] init];
    
    if (action) {
        
        [self.actionArray addObject:@{NoNilString(title) : action}];
    } else {
        
        __weak typeof(self) weakSelf = self;
        [self.actionArray addObject:@{NoNilString(title) : ^(){[weakSelf cancelClicked];}}];
    }
    
    return tempView;
}

- (void)show{
    
    if (self.actionArray.count > 0) {
        
        [self changeViewsLayouts];
    } else {
        
        [self.button1 addTarget:self action:@selector(cancelClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
}


/**
 改变控件布局
 */
- (void)changeViewsLayouts{
    
    if (self.actionArray.count == 1) {
        
        [self.button1 addTarget:self action:@selector(buttonActions:) forControlEvents:UIControlEventTouchUpInside];
        
        NSDictionary * dic = self.actionArray.firstObject;
        
        [self.button1 setTitle:dic.allKeys.firstObject forState:UIControlStateNormal];
        
        self.button1.tag = 1000 + 0;
    } else if (self.actionArray.count == 2){
        
        UIView * line2 = [[UIView alloc] init];
        UIButton * button2 = [[UIButton alloc] init];
        
        line2.backgroundColor = RGAB(220, 210, 215, 1);
        [button2 setTitleColor:RGAB(17, 107, 255, 1) forState:UIControlStateNormal];
        
        [self.showView addSubview:line2];
        [self.showView addSubview:button2];
        
        self.button1.tag = 1000 + 0;
        button2.tag = 1000 + 1;
        
        NSDictionary * dic1 = self.actionArray[0];
        NSDictionary * dic2 = self.actionArray[1];
        
        [self.button1 setTitle:dic1.allKeys.firstObject forState:UIControlStateNormal];
        [button2 setTitle:dic2.allKeys.firstObject forState:UIControlStateNormal];
        
        [self.button1 addTarget:self action:@selector(buttonActions:) forControlEvents:UIControlEventTouchUpInside];
        [button2 addTarget:self action:@selector(buttonActions:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.button1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.bottom.equalTo(self.showView);
            make.top.equalTo(self.line1.mas_bottom);
            make.right.equalTo(line2.mas_left);
            make.height.mas_equalTo(44 * SCALE);
        }];
        
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.equalTo(self.button1);
            make.width.mas_equalTo(0.5);
        }];
        
        [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(line2.mas_right);
            make.right.equalTo(self.showView);
            make.top.bottom.width.equalTo(self.button1);
        }];
    } else{
        
        
    }
}


#pragma mark - 点击事件
- (void)cancelClicked{
    
    [self removeFromSuperview];
}


- (void)buttonActions:(UIButton *)button{
    
    NSDictionary * dic = self.actionArray[button.tag - 1000];
    dispatch_block_t action = dic.allValues.firstObject;
    
    if (action) {
        action();
    }
    [self removeFromSuperview];
}


@end
