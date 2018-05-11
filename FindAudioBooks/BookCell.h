//
//  BookCell.h
//  FindAudioBooks
//
//  Created by Xiaohe Hu on 5/11/18.
//  Copyright © 2018 com.xiaohehu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookCell : UICollectionViewCell

@property (nonatomic, strong) NSString      *str_imageURL;
@property (nonatomic, strong) NSString      *str_bookTitle;
@property (nonatomic, strong) IBOutlet UIImageView   *uiiv_bookCover;
@property (nonatomic, strong) IBOutlet UILabel       *uil_bookTitle;

- (void) setContent;
- (void)setImageURL:(NSString *) url;
- (void)setTitle:(NSString *) title;

@end
