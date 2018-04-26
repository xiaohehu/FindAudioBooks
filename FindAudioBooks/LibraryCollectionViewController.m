//
//  LibraryCollectionViewController.m
//  FindAudioBooks
//
//  Created by Xiaohe Hu on 4/15/18.
//  Copyright © 2018 com.xiaohehu. All rights reserved.
//

#import "LibraryCollectionViewController.h"

@interface LibraryCollectionViewController () {
    NSArray *array_imageArray;
}

@end

@implementation LibraryCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)prepareData {
    array_imageArray = @[@"thumb1.jpg", @"thumb2.jpg", @"thumb3.jpg", @"thumb4.jpg"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Library";
    [self prepareData];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
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

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(50, 5, 50, 5);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    int num_cellsCount = (int) array_imageArray.count;
    return 20;
//    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    if (indexPath.item <= 3) {
        NSString *str_imageName = [array_imageArray objectAtIndex:(int)indexPath.item];
        UIImage *uii_thumb = [UIImage imageNamed:str_imageName];
        UIImageView *uiiv_cellThumb = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
        [uiiv_cellThumb setImage:uii_thumb];
        [cell.contentView addSubview:uiiv_cellThumb];
        [cell.contentView setBackgroundColor:[UIColor greenColor]];
    } else {
        [cell.contentView setBackgroundColor:[UIColor redColor]];
    }
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
