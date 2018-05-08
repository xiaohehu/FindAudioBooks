//
//  DBManager.h
//  FindAudioBooks
//
//  Created by Xiaohe Hu on 5/6/18.
//  Copyright © 2018 com.xiaohehu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
//CREATE TABLE bookInfo(bookINFOID integer primary key, title text, imageLink text, isbn text);
@interface DBManager : NSObject

@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;
@property (nonatomic, strong) NSMutableArray *arrResults;
@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;

- (void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable;
- (instancetype)initWithDatabaseFilename:(NSString *)dbFilename;
- (void)copyDatabaseIntoDocumentsDirectory;
-(NSArray *)loadDataFromDB:(NSString *)query;
-(void)executeQuery:(NSString *)query;

@end
