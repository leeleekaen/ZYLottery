//
//  ZYTabBarVC.m
//  ZYLottery
//
//  Created by 朝阳 on 2017/10/25.
//  Copyright © 2017年 sunny. All rights reserved.
//

#import "ZYTabBarVC.h"

#import "ZYHallTableViewController.h"
#import "ZYArenaViewController.h"
#import "ZYDiscoverTableTableViewController.h"
#import "ZYHistoryTableViewController.h"
#import "ZYMyLotteryViewController.h"

#import "ZYTabBar.h"

#import "ZYNavigationViewController.h"

@interface ZYTabBarVC ()<ZYTabBarDelegate>

/** tabBar的item 模型数组 */
@property (nonatomic, strong) NSMutableArray *itemArray;

@end

@implementation ZYTabBarVC

// 懒加载
- (NSMutableArray *)itemArray
{
    if (!_itemArray) {
        
        _itemArray = [NSMutableArray array];
        
    }
    return _itemArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化所有子控制器
    [self setupAllChildViewController];
//    self.selectedIndex = 2;
    
    // 自定义tabBar
    [self setupTabBar];

    
}

// 自定义tabBar
- (void)setupTabBar
{
//    1. 系统的tabBar的缺陷,需要自定义
//    1.移除整个tabBar简单粗暴(暂用第一种方法)
//    1.移除系统的tabBar,添加自己的tabBar
//    1.1 TabBar用UIView代替(因为系统的TabBar不好用)
//    1.2 子控键用UIButton代替
//    1.3 切换子控制器 selectedIndex
    
    //1. 移除系统的TabBar
    [self.tabBar removeFromSuperview];
    //2. 创建ZYTabBar
    ZYTabBar *tabBar = [[ZYTabBar alloc] init];
    // tabBar.count = self.childViewControllers.count;
    
    /*
     // 1.子控制器的个数
     // 2.UIButton 内容
     */
    tabBar.itemArray = self.itemArray;
    
    // 此时系统的tabBar还未移除
    tabBar.frame = self.tabBar.frame;
    tabBar.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:tabBar];

    // 设置代理
    tabBar.delegate = self;
    
}

#pragma -mark ZYTabBarDelegate
- (void)tabBar:(ZYTabBar *)tabBar index:(NSInteger)index
{
//    NSLog(@"%ld",index);
    self.selectedIndex = index;
}

// 添加所有的子控制器
- (void)setupAllChildViewController
{
    /*
         因为系统的tabBar的尺寸 和 图片大小不同,因此要采用自定义控件
     */
    
    //1. 购彩大厅
    ZYHallTableViewController *hallVC = [[ZYHallTableViewController alloc] init];
    hallVC.view.backgroundColor = [UIColor grayColor];
    [self setupOneChildViewController:hallVC image:[UIImage imageNamed:@"TabBar_Hall_new"] selectImage:[UIImage imageNamed:@"TabBar_Hall_selected_new"] title:@"购彩大厅"];
    
    
    //2. 竞技场
    ZYArenaViewController *arenaVC = [[ZYArenaViewController alloc] init];
    arenaVC.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:arenaVC];
    [self setupOneChildViewController:arenaVC image:[UIImage imageNamed:@"TabBar_Arena_new"] selectImage:[UIImage imageNamed:@"TabBar_Arena_selected_new"] title:nil];
    
    //3. 发现
    ZYDiscoverTableTableViewController *discoveryVC = [[ZYDiscoverTableTableViewController alloc] init];
    discoveryVC.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:discoveryVC];
    [self setupOneChildViewController:discoveryVC image:[UIImage imageNamed:@"TabBar_Discovery_new"] selectImage:[UIImage imageNamed:@"TabBar_Discovery_selected_new"] title:@"发现"];
    
    //4. 开奖信息
    ZYHistoryTableViewController *historyVC = [[ZYHistoryTableViewController alloc] init];
    historyVC.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:historyVC];
    [self setupOneChildViewController:historyVC image:[UIImage imageNamed:@"TabBar_History_new"] selectImage:[UIImage imageNamed:@"TabBar_History_selected_new"] title:@"开奖信息"];
    
    //5. 我的彩票
    ZYMyLotteryViewController *myLotteryVC = [[ZYMyLotteryViewController alloc] init];
    myLotteryVC.view.backgroundColor = [UIColor purpleColor];
    [self addChildViewController:myLotteryVC];
    [self setupOneChildViewController:myLotteryVC image:[UIImage imageNamed:@"TabBar_MyLottery_new"] selectImage:[UIImage imageNamed:@"TabBar_MyLottery_selected_new"] title:@"我的彩票"];
    
}

// 添加一个子控制器
- (void)setupOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectImage:(UIImage *)selectImage title:(NSString *)title
{
    // 给tabBar每个子控制器都设置导航控制器
    // 创建导航控制器
    UINavigationController *nav = [[ZYNavigationViewController alloc] initWithRootViewController:vc];

    // 设置导航条内容需要使用栈顶控制器的navigationItem模型
    vc.navigationItem.title = title;
    
    // 如果控制器是 Arena 类型
    if ([vc isKindOfClass:[ZYArenaViewController class]]) {
        // 竞技场
        // 导航条为系统默认的样式
        nav = [[UINavigationController alloc] initWithRootViewController:vc];
    }

    [self addChildViewController:nav];
    
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectImage;
    
    // 取消图片的渲染
//    vc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 将模型都添加到 模型数组中
    [self.itemArray addObject:vc.tabBarItem];
    
}

@end
