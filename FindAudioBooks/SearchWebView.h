//
//  SearchWebView.h
//  FindAudioBooks
//
//  Created by Xiaohe Hu on 5/22/18.
//  Copyright © 2018 com.xiaohehu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchWebView;
@protocol SearchWebViewDelegate <NSObject>
- (void)didSearchWebViewRemoved:(SearchWebView *) searchView;
@end
@interface SearchWebView : UIView{
}

@property (nonatomic, weak) id <SearchWebViewDelegate> delegate;
@property (nonatomic, weak) NSString                *str_rawTitle;
@property (nonatomic, strong) UIView                *uiv_searchContainer;
@property (nonatomic, strong) UIWebView             *uiw_searchView;
@property (nonatomic, strong) UIView                *uiv_searchTopBar;
@property (nonatomic, strong) UIButton              *uib_searchClose;

- (id)initWithFrame:(CGRect) frame andTitle:(NSString *) bookTitle;

@end
