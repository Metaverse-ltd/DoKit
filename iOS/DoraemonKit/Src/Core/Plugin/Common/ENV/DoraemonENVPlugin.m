//
//  DoraemonAPIHostPlugin.m
//  DoraemonKit
//
//  Created by xingtian on 2023/5/15.
//   
    

#import "DoraemonENVPlugin.h"
#import "DoraemonHomeWindow.h"
#import "DoraemonENVViewController.h"

@implementation DoraemonENVPlugin

- (void)pluginDidLoad {
    DoraemonENVViewController *vc = [[DoraemonENVViewController alloc] init];
    [DoraemonHomeWindow openPlugin:vc];
}


@end
