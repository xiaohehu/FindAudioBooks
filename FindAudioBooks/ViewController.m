//
//  ViewController.m
//  FindAudioBooks
//
//  Created by Xiaohe Hu on 4/15/18.
//  Copyright © 2018 com.xiaohehu. All rights reserved.
//

#import "ViewController.h"
#import "LibraryCollectionViewController.h"
#import "ScanViewController.h"
#import "TabBarViewController.h"

@interface ViewController () {
    NSMutableArray *vcArray;

}


@property (nonatomic, strong) TabBarViewController *tabBarVC;
@property (nonatomic, strong) LibraryCollectionViewController *libraryVC;
@property (nonatomic, strong) ScanViewController *scannerVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view.window setBackgroundColor:[UIColor clearColor]];
    self.tabBarVC = [[TabBarViewController alloc] init];
    [self addChildViewController:self.tabBarVC];
    [self.view addSubview:self.tabBarVC.view];
    // Do any additional setup after loading the view, typically from a nib.

    // Init all ViewControllers
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setItemSize:CGSizeMake(100, 100)];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.libraryVC = [[LibraryCollectionViewController alloc] initWithCollectionViewLayout:aFlowLayout];
    self.scannerVC = [[ScanViewController alloc] init];
    _scannerVC.view.backgroundColor = [UIColor greenColor];
    
    vcArray = [NSMutableArray arrayWithObjects:_libraryVC, _scannerVC, nil];
    [self.tabBarVC setViewControllers:vcArray];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
