//
//  FetchParseBookInfo.m
//  FindAudioBooks
//
//  Created by Xiaohe Hu on 4/30/18.
//  Copyright © 2018 com.xiaohehu. All rights reserved.
//

#import "FetchParseBookInfo.h"

@implementation FetchParseBookInfo {
    NSString        *str_coverUrl;
    NSString        *str_bookTitle;
    NSDictionary    *rawJson;
    BOOL            getTheBookInfo;
}

- (void) setBSN:(NSString *)str_bsn {
    str_bsnNum = str_bsn;
    [self fetchData];
}

- (void) fetchData {
    NSString *url_body = @"https://www.googleapis.com/books/v1/volumes?q=isbn:";
    NSString *url_request = [NSString stringWithFormat:@"%@%@", url_body, str_bsnNum];
    NSError *error;
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_request]];
    rawJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    [self parseData: rawJson];
}

- (void) parseData:(NSDictionary *)raw {
    NSArray *rawItem = [[NSArray alloc] initWithArray:raw[@"items"]];
    if ([rawItem count] == 0) {
        getTheBookInfo = false;
    } else {
        getTheBookInfo = true;
        NSDictionary *item = [[NSDictionary alloc] initWithDictionary:rawItem[0]];
        NSDictionary *volumeInfo = [[NSDictionary alloc] initWithDictionary:item[@"volumeInfo"]];
        NSDictionary *thumbnails = [[NSDictionary alloc] initWithDictionary:volumeInfo[@"imageLinks"]];
        str_bookTitle = volumeInfo[@"title"];
        str_coverUrl = thumbnails[@"thumbnail"];
    }
}

- (BOOL) getBookInfo {
    return getTheBookInfo;
}

- (NSString *) getCoverUrl {
    return str_coverUrl;
}

- (NSString *) getBookTitle {
    return str_bookTitle;
}

- (NSString *) getBookBSN {
    return str_bsnNum;
}
@end
