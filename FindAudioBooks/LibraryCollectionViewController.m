//
//  LibraryCollectionViewController.m
//  FindAudioBooks
//
//  Created by Xiaohe Hu on 4/15/18.
//  Copyright © 2018 com.xiaohehu. All rights reserved.
//

#import "LibraryCollectionViewController.h"
#import "DBManager.h"

@interface LibraryCollectionViewController () {
    NSInteger indexImage;
    NSInteger indexTitle;
}

@property (nonatomic, strong) DBManager         *dbManager;
@property (nonatomic, strong) NSArray           *arr_bookInfo;

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
    return _arr_bookInfo.count;
//    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    NSURL *url = [NSURL URLWithString:[[_arr_bookInfo objectAtIndex: indexPath.row] objectAtIndex: indexImage]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *uii_thumb = nil;
    if (data == nil) {
        uii_thumb = [UIImage imageNamed:@"thumb.jpg"];
    } else {
        uii_thumb = [[UIImage alloc] initWithData:data];
    }
    UIImageView *uiiv_cellThumb = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height * 0.7)];
    [uiiv_cellThumb setImage:uii_thumb];
    [uiiv_cellThumb setContentMode: UIViewContentModeScaleAspectFit];
    UILabel *uil_title = [[UILabel alloc] initWithFrame:CGRectMake(0.0, cell.bounds.size.height * 0.7, cell.bounds.size.width, cell.bounds.size.height * 0.3)];
    [uil_title setText:[[_arr_bookInfo objectAtIndex: indexPath.row] objectAtIndex: indexTitle]];
    [uil_title setTextAlignment: NSTextAlignmentCenter];
    uil_title.numberOfLines = 0;
    uil_title.font = [UIFont fontWithName:@"Helvetica Neue" size:11.0];
    [cell.contentView addSubview: uil_title];
    [cell.contentView addSubview:uiiv_cellThumb];
    cell.layer.borderColor = [UIColor orangeColor].CGColor;
    cell.layer.borderWidth = 2.0;
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
