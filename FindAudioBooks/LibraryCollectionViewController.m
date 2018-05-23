//
//  LibraryCollectionViewController.m
//  FindAudioBooks
//
//  Created by Xiaohe Hu on 4/15/18.
//  Copyright © 2018 com.xiaohehu. All rights reserved.
//

#import "LibraryCollectionViewController.h"
#import "DBManager.h"
#import "BookCell.h"
#import "SearchWebView.h"

@interface LibraryCollectionViewController () <SearchWebViewDelegate> {
    NSInteger indexImage;
    NSInteger indexTitle;
}

@property (nonatomic, strong) DBManager         *dbManager;
@property (nonatomic, strong) NSArray           *arr_bookInfo;
@property (nonatomic, strong) SearchWebView     *searchWeb;

@end

@implementation LibraryCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)prepareData {
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"bookdb.sql"];
    NSString *query = @"select * from bookInfo";
    // Get the results.
    if (self.arr_bookInfo != nil) {
        self.arr_bookInfo = nil;
    }
    self.arr_bookInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    indexTitle = [self.dbManager.arrColumnNames indexOfObject:@"title"];
    indexImage = [self.dbManager.arrColumnNames indexOfObject:@"imageLink"];
    
    // Reload the table view.
    [self.collectionView reloadData];
}

- (void) viewDidAppear:(BOOL)animated {
    [self prepareData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Library";
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self prepareData];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[BookCell class] forCellWithReuseIdentifier:reuseIdentifier];
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
    return _arr_bookInfo.count;
//    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    // Configure the cell
    cell.str_bookTitle = [[_arr_bookInfo objectAtIndex: indexPath.row] objectAtIndex: indexTitle];
    cell.str_imageURL = [[_arr_bookInfo objectAtIndex: indexPath.row] objectAtIndex: indexImage];
    [cell setContent];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *bookTitle = [[_arr_bookInfo objectAtIndex: indexPath.row] objectAtIndex:indexTitle];
    self.searchWeb = [[SearchWebView alloc] initWithFrame:self.view.frame andTitle: bookTitle];
    self.searchWeb.delegate = self;
    [self.view addSubview: self.searchWeb];
    bookTitle = nil;
}

- (void)didSearchWebViewRemoved:(SearchWebView *)searchView {
    [self.searchWeb removeFromSuperview];
    self.searchWeb = nil;
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
