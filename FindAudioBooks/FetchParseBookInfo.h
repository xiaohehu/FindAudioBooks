//
//  FetchParseBookInfo.h
//  FindAudioBooks
//
//  Created by Xiaohe Hu on 4/30/18.
//  Copyright © 2018 com.xiaohehu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchParseBookInfo : NSObject {
    NSString *str_bsnNum;
}


- (void) setBSN:(NSString *)str_bsn;
- (BOOL) getBookInfo;
- (NSString *) getCoverUrl;
- (NSString *) getBookTitle;
- (NSString *) getBookBSN;
@end
