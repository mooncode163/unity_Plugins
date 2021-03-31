//
//  CCAdApplistObj.h
//  moonma_tankcity
//
//  Created by chen Jaykie on 13-10-2.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import <sqlite3.h>

@interface SqlObj : NSObject 
{
     int buyType; 
//     sqlite3 *database;
//    sqlite3_stmt *statement;
}
+ (SqlObj *) sharedSqlObj;
  
-(sqlite3 *)Open:(NSString *)dbfile;
-(void) Close:(sqlite3 *)database;
-(void)ExecSQL:(NSString *)sql db:(sqlite3 *) database;
-(sqlite3_stmt *)Query:(NSString *)sql db:(sqlite3 *) database;
 -(int)GetCount:(sqlite3_stmt *)statement;
-(NSString*)GetString:(NSString *)key st:(sqlite3_stmt *)statement;
-(bool)MoveToFirst:(sqlite3_stmt *)statement;
-(bool)MoveToNext:(sqlite3_stmt *)statement;
@property (nonatomic,retain) NSMutableArray *arraySQL;
@property (nonatomic,retain) NSString *productName;
@property (nonatomic,retain) NSString *unityObjName;
@property (nonatomic,retain) NSString *unityObjMethod;
@end
