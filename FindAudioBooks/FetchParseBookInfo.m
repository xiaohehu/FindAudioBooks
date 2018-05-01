//
//  FetchParseBookInfo.m
//  FindAudioBooks
//
//  Created by Xiaohe Hu on 4/30/18.
//  Copyright © 2018 com.xiaohehu. All rights reserved.
//

#import "FetchParseBookInfo.h"

@implementation FetchParseBookInfo {
    NSString *str_coverUrl;
    NSString *str_bookTitle;
}

- (void) setBSN:(NSString *)str_bsn {
    str_bsnNum = str_bsn;
    [self fetchAndParseData];
}

- (void) fetchAndParseData {
    NSString *url_body = @"https://www.googleapis.com/books/v1/volumes?q=isbn:";
    NSString *url_request = [NSString stringWithFormat:@"%@%@", url_body, str_bsnNum];
    NSError *error;
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_request]];
    NSDictionary *rawJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSArray *rawItem = [[NSArray alloc] initWithArray:rawJson[@"items"]];
    NSDictionary *item = [[NSDictionary alloc] initWithDictionary:rawItem[0]];
    NSDictionary *volumeInfo = [[NSDictionary alloc] initWithDictionary:item[@"volumeInfo"]];
    NSDictionary *thumbnails = [[NSDictionary alloc] initWithDictionary:volumeInfo[@"imageLinks"]];
    str_bookTitle = volumeInfo[@"title"];
    str_coverUrl = thumbnails[@"thumbnail"];
}

#pragma ERROR HANDLING!!!

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
