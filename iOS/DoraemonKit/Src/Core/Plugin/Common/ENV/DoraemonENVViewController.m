//
//  DoraemonAPIHostViewController.m
//  DoraemonKit
//
//  Created by xingtian on 2023/5/15.
//   
    

#import "DoraemonENVViewController.h"
#import "DoraemonDefine.h"
#import "Doraemoni18NUtil.h"
#import "UIView+Doraemon.h"
#import "UIColor+Doraemon.h"
#import <objc/runtime.h>
#import "DoraemonCellButton.h"
#import "DoraemonCacheManager.h"

typedef NS_ENUM(NSUInteger, DoraemonAPIEnv) {
    DoraemonAPIEnvNone = 0,
    DoraemonAPIEnvDevelopment,
    DoraemonAPIEnvTest,
    DoraemonAPIEnvProduction,
};

@interface DoraemonENVViewController ()<DoraemonCellButtonDelegate>

@property (nonatomic, strong) DoraemonCellButton *developmentBtn;
@property (nonatomic, strong) DoraemonCellButton *testBtn;
@property (nonatomic, strong) DoraemonCellButton *productionBtn;

@end

@implementation DoraemonENVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (BOOL)needBigTitleView {
    return YES;
}

- (void)initUI {
    self.title = DoraemonLocalizedString(@"ENV");
    
    DoraemonAPIEnv env = [[DoraemonCacheManager sharedInstance] ENV];
    
    self.developmentBtn = [[DoraemonCellButton alloc] initWithFrame:CGRectMake(0, self.bigTitleView.doraemon_bottom, self.view.doraemon_width, kDoraemonSizeFrom750_Landscape(104))];
    [self.developmentBtn renderUIWithTitle:DoraemonLocalizedString(@"开发环境")];
    [self.developmentBtn needDownLine];
    self.developmentBtn.delegate = self;
    [self.view addSubview:self.developmentBtn];
    if (env == DoraemonAPIEnvDevelopment) {
        [self.developmentBtn renderUIWithRightContent:@"✅"];
    }
    
    self.testBtn = [[DoraemonCellButton alloc] initWithFrame:CGRectMake(0, self.developmentBtn.doraemon_bottom, self.view.doraemon_width, kDoraemonSizeFrom750_Landscape(104))];
    [self.testBtn renderUIWithTitle:DoraemonLocalizedString(@"测试环境")];
    self.testBtn.delegate = self;
    [self.testBtn needDownLine];
    [self.view addSubview:self.testBtn];
    if (env == DoraemonAPIEnvTest) {
        [self.testBtn renderUIWithRightContent:@"✅"];
    }
    
    self.productionBtn = [[DoraemonCellButton alloc] initWithFrame:CGRectMake(0, self.testBtn.doraemon_bottom, self.view.doraemon_width, kDoraemonSizeFrom750_Landscape(104))];
    [self.productionBtn renderUIWithTitle:DoraemonLocalizedString(@"正式环境")];
    self.productionBtn.delegate = self;
    [self.productionBtn needDownLine];
    [self.view addSubview:self.productionBtn];
    if (env == DoraemonAPIEnvProduction) {
        [self.productionBtn renderUIWithRightContent:@"✅"];
    }
}

#pragma mark DoraemonCellButtonDelegate

- (void)cellBtnClick:(id)sender {
    DoraemonAPIEnv oldEnv = [[DoraemonCacheManager sharedInstance] ENV];
    
    DoraemonAPIEnv newEnv = oldEnv;
    if (sender == self.developmentBtn) {
        newEnv = DoraemonAPIEnvDevelopment;
    } else if (sender == self.testBtn) {
        newEnv = DoraemonAPIEnvTest;
    } else {
        newEnv = DoraemonAPIEnvProduction;
    }
    
    if (oldEnv == newEnv) return;
    
    [DoraemonAlertUtil handleAlertActionWithVC:self okBlock:^{
        [[DoraemonCacheManager sharedInstance] saveENV:newEnv];
        exit(0);
    } cancleBlock:^{
    }];
}

@end
