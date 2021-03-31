//
//  CCAdInsertObj.m
//  moonma_tankcity
//
//  Created by chen Jaykie on 13-10-2.
//
//

#import "SqlObj.h"
#import "Common.h" 
 
@implementation SqlObj
@synthesize productName;
@synthesize unityObjName;
@synthesize unityObjMethod;
@synthesize arraySQL;

static SqlObj *s_sharedSqlObj = nil;
// Init
+ (SqlObj *) sharedSqlObj
{
    @synchronized(self)     {
        if (!s_sharedSqlObj)
            s_sharedSqlObj = [[SqlObj alloc] init];
        [s_sharedSqlObj initValue];
    }
    return s_sharedSqlObj;
}

-(void)initValue
{
    self.arraySQL = [[NSMutableArray alloc]init];
} 

-(void) Close:(sqlite3 *)database
{
    if(database!=nil)
    {
    sqlite3_close(database);
    }
}



-(sqlite3 *)Open:(NSString *)dbfile
{ 
    // NSString *docsDir;
    // NSArray *dirPaths;    
    // // Get the documents directory
    // dirPaths = NSSearchPathForDirectoriesInDomains
    // (NSDocumentDirectory, NSUserDomainMask, YES);    
    // docsDir = dirPaths[0];
    // Build the path to the database file
    // databasePath = [[NSString alloc] initWithString: 
    // [docsDir stringByAppendingPathComponent: @"student.db"]];
    sqlite3 * database=nullptr;
    NSString *homeDir = NSHomeDirectory();
    NSString *name =[NSString stringWithFormat:@"Idiom.db"];
    NSString * databasePath = [NSString stringWithFormat:@"%@/Data/Raw/GameRes/%@", homeDir,name];
    databasePath = dbfile;
    NSLog(@"databasePath=%@",databasePath);
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];    
    // if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        const char *dbpath = [databasePath UTF8String];        
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            // char *errMsg;
            // const char *sql_stmt =
            // "create table if not exists studentsDetail (regno integer 
            // primary key, name text, department text, year text)";            
            // if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) 
            //    != SQLITE_OK)
            // {
            //     isSuccess = NO;
            //     NSLog(@"Failed to create table");
            // }
            // sqlite3_close(database);
            // return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
//    else{
//         NSLog(@"dbfile is not exist");
//    }
 
     return database;
}


-(void)ExecSQL:(NSString *)sql db:(sqlite3 *) database
{
    char *errMsg;
    if(database==nil)
    {
        return;
    }
     if (sqlite3_exec(database, (char*) [sql UTF8String], NULL, NULL, &errMsg) 
               != SQLITE_OK)
            {
                // isSuccess = NO;
                NSLog(@"Failed to create table");
            }
}
 
-(sqlite3_stmt *)Query:(NSString *)sql db:(sqlite3 *) database
{ 
        NSString *querySQL = sql;
    if(database==nil)
      {
          return nil;
      }
      sqlite3_stmt *statement = nullptr;
        const char *query_stmt = [querySQL UTF8String];
        // sqlite3_stmt *statement = nil;
        // NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,
           query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            // if (sqlite3_step(statement) == SQLITE_ROW)
            // {                
            //     NSString *name = [[NSString alloc] initWithUTF8String:
            //      (const char *) sqlite3_column_text(statement, 0)];
            //     [resultArray addObject:name];
            //     NSString *department = [[NSString alloc] initWithUTF8String:
            //     (const char *) sqlite3_column_text(statement, 1)];
            //     [resultArray addObject:department];
            //     NSString *year = [[NSString alloc]initWithUTF8String:
            //     (const char *) sqlite3_column_text(statement, 2)];
            //     [resultArray addObject:year];
            //     return resultArray;
            // }
            // else{
            //     NSLog(@"Not found");
            //     return nil;
            // }
            // sqlite3_reset(statement);
        }

        return statement;
}

 
    -(int)GetCount:(sqlite3_stmt *)statement
    { 
        int count = 0;
        if(statement==nil)
          {
              return count;
          }
        if (sqlite3_step(statement) == SQLITE_ROW)
            {                
                count++;
            } 
        sqlite3_reset(statement);
        return  count;   
    } 
         -(NSString*)GetString:(NSString *)key st:(sqlite3_stmt *)statement
    {
        if(statement==nil)
                 {
                     return @"";
                 }
        NSString *strRet = [NSString stringWithUTF8String:""];
         // 3.1、获取所有列的个数
         int columnCount = sqlite3_column_count(statement);

         // 3.2、遍历所有的列
         for (int i=0; i<columnCount; i++) {
      
            // 3.2.1、获取所有列的名字，也就是表中字段的名字
            // C语言的字符串
            const char *columnNameC = sqlite3_column_name(statement, i);
            // 把 C 语言字符串转为 OC
            NSString *columnName = [NSString stringWithUTF8String:columnNameC];
            if([columnName isEqualToString: key]==NO)
            {
                continue;
            }
            // 3.2.2、获取列值
            // 不同列的类型，使用不同的函数，进行获取值
            // 3.2.2.1、获取列的类型
            int type = sqlite3_column_type(statement, i);
            /** 我们使用的是 SQLite3，所以是：SQLITE3_TEXT
              SQLite version 2 and SQLite version 3 should use SQLITE3_TEXT, not
       
              SQLITE_INTEGER  1
              SQLITE_FLOAT    2
              SQLITE3_TEXT    3
              SQLITE_BLOB     4
              SQLITE_NULL     5
       
             */
             // 3.2.2.2、根据列的类型，使用不同的函数，获取列的值
             id value = nil;
      
             switch (type) {
                  case SQLITE_INTEGER:
                      value = @(sqlite3_column_int(statement,i));
                      break;
                  case SQLITE_FLOAT:
                      value = @(sqlite3_column_double(statement, i));
                      break;
                  case SQLITE3_TEXT:
                      strRet = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, i)];
                      value = strRet;
                      break;
                  case SQLITE_BLOB:
                      value = CFBridgingRelease(sqlite3_column_blob(statement, i));
                      break;
                  case SQLITE_NULL:
                      value = @"";
                      break;
              
                  default:
                      break;
           }
      
            
         }

         return strRet;
    }
 
       -(bool)MoveToFirst :(sqlite3_stmt *)statement
    { 
        
        if(statement==nil)
                    {
                        return false;
                    }
         sqlite3_reset(statement);
          if (sqlite3_step(statement) == SQLITE_ROW)
          {
              return true;
          }
          return false;
         
    }
    
-(bool)MoveToNext :(sqlite3_stmt *)statement
{
    if(statement==nil)
             {
                 return NO;
             }
   if (sqlite3_step(statement) == SQLITE_ROW)
   {
       return true;
   }
   return false;
}

  

@end
