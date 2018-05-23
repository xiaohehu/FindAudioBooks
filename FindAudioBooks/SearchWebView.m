//
//  SearchWebView.m
//  FindAudioBooks
//
//  Created by Xiaohe Hu on 5/22/18.
//  Copyright © 2018 com.xiaohehu. All rights reserved.
//

#import "SearchWebView.h"

@implementation SearchWebView
@synthesize delegate;
@synthesize str_rawTitle;
@synthesize uiw_searchView, uib_searchClose, uiv_searchTopBar, uiv_searchContainer;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect) frame andTitle:(NSString *) bookTitle{
    self = [super initWithFrame:frame];
    self.str_rawTitle = bookTitle;
    [self initWebView];
    return self;
}

- (void)initWebView {
    uiv_searchContainer = [[UIView alloc] initWithFrame:self.frame];
    [uiv_searchContainer setBackgroundColor:[UIColor whiteColor]];
    
    uiv_searchTopBar = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, uiv_searchContainer.frame.size.width, uiv_searchContainer.frame.size.height * 0.1)];
    [uiv_searchTopBar setBackgroundColor:[UIColor whiteColor]];
    
    UIView *uiv_bottomBorder = [[UIView alloc] initWithFrame: CGRectMake(0.0, uiv_searchTopBar.frame.size.height, uiv_searchContainer.frame.size.width, 2.0)];
    [uiv_bottomBorder setBackgroundColor:[UIColor orangeColor]];
    
    uib_searchClose = [[UIButton alloc] initWithFrame:CGRectMake(uiv_searchTopBar.frame.size.width * 0.75, 0.0, uiv_searchTopBar.frame.size.width * 0.25, uiv_searchTopBar.frame.size.height)];
    [uib_searchClose setTitle:@"CLOSE" forState:UIControlStateNormal];
    [uib_searchClose setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
    [uib_searchClose setBackgroundColor:[UIColor whiteColor]];
    [uib_searchClose addTarget:self action:@selector(closeSearchWeb) forControlEvents:UIControlEventTouchUpInside];
    
    
    uiw_searchView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, uiv_searchTopBar.frame.size.height, uiv_searchContainer.frame.size.width, uiv_searchContainer.frame.size.height - uiv_searchTopBar.frame.size.height)];
    [uiw_searchView setBackgroundColor:[UIColor whiteColor]];
    
    // Pars raw title
    NSString *title = [str_rawTitle stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *rawUrl = @"https://mobile.audible.com/search?keywords=";
    NSURL *searchURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", rawUrl, title]];
    NSLog(@"%@", searchURL);
    NSURLRequest *searchRequest = [NSURLRequest requestWithURL: searchURL];
    [uiw_searchView loadRequest: searchRequest];
    
    [uiv_searchContainer addSubview: uiw_searchView];
    [uiv_searchTopBar addSubview: uib_searchClose];
    [uiv_searchContainer addSubview: uiv_searchTopBar];
    [uiv_searchContainer addSubview: uiv_bottomBorder];
    [self addSubview: uiv_searchContainer];
}

- (void)closeSearchWeb {
    [self.delegate didSearchWebViewRemoved:self];
}

@end
