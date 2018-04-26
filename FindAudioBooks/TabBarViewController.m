//
//  TabBarViewController.m
//  FindAudioBooks
//
//  Created by Xiaohe Hu on 4/25/18.
//  Copyright © 2018 com.xiaohehu. All rights reserved.
//

#import "TabBarViewController.h"
#import "LibraryCollectionViewController.h"
#import "ScanViewController.h"
@interface TabBarViewController ()
{
    NSMutableArray *vcArray;
}
@property (nonatomic, strong) UITabBarItem *uitbi_library;
@property (nonatomic, strong) UITabBarItem *uitbi_scanner;

@property (nonatomic, strong) LibraryCollectionViewController *libraryVC;
@property (nonatomic, strong) ScanViewController *scannerVC;
@end

@implementation TabBarViewController

- (void)viewWillAppear:(BOOL)animated{
    animated = YES;
//    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
//    [aFlowLayout setItemSize:CGSizeMake(100, 100)];
//    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    self.libraryVC = [[LibraryCollectionViewController alloc] initWithCollectionViewLayout:aFlowLayout];
//    self.scannerVC = [[ScanViewController alloc] init];
//    _scannerVC.view.backgroundColor = [UIColor greenColor];
//    
//    vcArray = [NSMutableArray arrayWithObjects:_libraryVC, _scannerVC, nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
//    [self setViewControllers:vcArray];
//    _libraryVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemRecents tag:0];
//    _scannerVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
