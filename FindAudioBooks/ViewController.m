//
//  ViewController.m
//  FindAudioBooks
//
//  Created by Xiaohe Hu on 4/15/18.
//  Copyright © 2018 com.xiaohehu. All rights reserved.
//

#import "ViewController.h"
#import "LibraryCollectionViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITabBar *ui_tabBar;
@property (weak, nonatomic) IBOutlet UITabBarItem *ui_barLibrary;
@property (weak, nonatomic) IBOutlet UITabBarItem *ui_barSearch;

@property (nonatomic, strong) LibraryCollectionViewController *libraryVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.ui_tabBar setSelectedItem:_ui_barLibrary];
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setItemSize:CGSizeMake(100, 100)];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.libraryVC = [[LibraryCollectionViewController alloc] initWithCollectionViewLayout:aFlowLayout];
    [self.view insertSubview:self.libraryVC.view belowSubview:_ui_tabBar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
