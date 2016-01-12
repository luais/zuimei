//
//  AppDelegate.m
//  zuimei
//
//  Created by Aries on 15/10/30.
//  Copyright © 2015年 youke. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (strong, nonatomic) CYLTabBarController *tabBarController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    [self setupViewControllers];
    [self.window setRootViewController:self.tabBarController];
    [self.window makeKeyAndVisible];
//    [self customizeInterface];

    
    return YES;
}

- (void)setupViewControllers {
    CYLHomeViewController *firstViewController = [[CYLHomeViewController alloc] init];
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    CYLSameFityViewController *secondViewController = [[CYLSameFityViewController alloc] init];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    ClassViewController *thirdViewController = [[ClassViewController alloc] init];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    CYLMineViewController *fourthViewController = [[CYLMineViewController alloc] init];
    UIViewController *fourthNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:fourthViewController];
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    [self customizeTabBarForController:tabBarController];
    
    [tabBarController setViewControllers:@[
                                           firstNavigationController,
                                           secondNavigationController,
                                           thirdNavigationController,
                                           fourthNavigationController
                                           ]];
    self.tabBarController = tabBarController;
}

/*
 *
 在`-setViewControllers:`之前设置TabBar的属性，
 *
 */
- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
//                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage:@"xzzm_Tabbar_tabbarHome",
                            CYLTabBarItemSelectedImage :@"xzzm_Tabbar_tabbarHomeSel",
                            };
    NSDictionary *dict2 = @{
//                            CYLTabBarItemTitle : @"同城",
                            CYLTabBarItemImage : @"xzzm_Tabbar_tabbarShop",
                            CYLTabBarItemSelectedImage : @"xzzm_Tabbar_tabbarShopSel",
                            };
    NSDictionary *dict3 = @{
//                            CYLTabBarItemTitle : @"消息",
                            CYLTabBarItemImage : @"xzzm_Tabbar_tabbarGrid",
                            CYLTabBarItemSelectedImage : @"xzzm_Tabbar_tabbarGridSel"
                            };
    NSDictionary *dict4 = @{
//                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"xzzm_Tabbar_tabbarAccount",
                            CYLTabBarItemSelectedImage :@"xzzm_Tabbar_tabbarAccountSel"
                            };
    NSArray *tabBarItemsAttributes = @[ dict1,
                                        dict2,
                                        dict3,
                                        dict4
                                        ];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}

//- (void)customizeInterface {
//////    [self setUpNavigationBarAppearance];
//    [self setUpTabBarItemTextAttributes];
//}
/**
 *  设置navigationBar样式
 */
//- (void)setUpNavigationBarAppearance {
//    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
//    
//    UIImage *backgroundImage = nil;
//    NSDictionary *textAttributes = nil;
//    
//    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
//        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
//        
//        textAttributes = @{
//                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
//                           NSForegroundColorAttributeName: [UIColor blackColor],
//                           };
//    } else {
//#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
//        
//        textAttributes = @{
//                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
//                           UITextAttributeTextColor: [UIColor blackColor],
//                           UITextAttributeTextShadowColor: [UIColor clearColor],
//                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
//                           };
//#endif
//    }
//    
//    [navigationBarAppearance setBackgroundImage:backgroundImage
//                                  forBarMetrics:UIBarMetricsDefault];
//    [navigationBarAppearance setTitleTextAttributes:textAttributes];
//}

/**
 *  tabBarItem 的选中和不选中文字属性
 */
//- (void)setUpTabBarItemTextAttributes {
//    
//    // 普通状态下的文字属性
//    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
//    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    
//    // 选中状态下的文字属性
//    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
//    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
//    
//    // 设置文字属性
//    UITabBarItem *tabBar = [UITabBarItem appearance];
//    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
//    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateHighlighted];
//    
//    // 设置背景图片
//    //    UITabBar *tabBarAppearance = [UITabBar appearance];
//    //    [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background_os7"]];
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
