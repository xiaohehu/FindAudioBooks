//
//  BookCell.m
//  FindAudioBooks
//
//  Created by Xiaohe Hu on 5/11/18.
//  Copyright © 2018 com.xiaohehu. All rights reserved.
//

#import "BookCell.h"

@implementation BookCell
@synthesize str_bookTitle = _str_bookTitle;
@synthesize str_imageURL = _str_imageURL;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _uiiv_bookCover = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height * 0.7)];
        [self addSubview: _uiiv_bookCover];
        
        _uil_bookTitle = [[UILabel alloc] initWithFrame:CGRectMake(0.0, _uiiv_bookCover.frame.size.height, frame.size.width, frame.size.height * 0.3)];
        [self addSubview: _uil_bookTitle];
        
        self.layer.borderColor = [UIColor orangeColor].CGColor;
        self.layer.borderWidth = 2.0;
    }
    return self;
}

- (void) setContent {
    
    NSURL *url = [NSURL URLWithString: _str_imageURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *uii_thumb = nil;
    if (data == nil) {
        uii_thumb = [UIImage imageNamed:@"thumb.jpg"];
    } else {
        uii_thumb = [[UIImage alloc] initWithData:data];
    }
    [_uiiv_bookCover setImage: uii_thumb];
    [_uiiv_bookCover setContentMode: UIViewContentModeScaleAspectFit];
    [self.contentView addSubview: _uiiv_bookCover];
    
    [_uil_bookTitle setText: _str_bookTitle];
    [_uil_bookTitle setTextAlignment: NSTextAlignmentCenter];
    _uil_bookTitle.numberOfLines = 0;
    _uil_bookTitle.font = [UIFont fontWithName:@"Helvetica Neue" size:11.0];
    [self.contentView addSubview: _uil_bookTitle];
}

- (void) setImageURL:(NSString *)url {
    _str_imageURL = url;
}

- (void) setTitle:(NSString *)title {
    _str_bookTitle = title;
}

@end
