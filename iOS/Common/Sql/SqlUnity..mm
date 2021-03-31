//
//  UnityEngineCloudiOS.mm
//
//  Created by Viraf Zack on 7/2/14
//  Copyright (c) 2014 Unity. All rights reserved.
//

#if __has_feature(objc_arc)
#define RETAIN self
#define AUTORELEASE self
#define RELEASE self
#define DEALLOC self
#else
#define RETAIN retain
#define AUTORELEASE autorelease
#define RELEASE release
#define DEALLOC dealloc
#endif

#import <Foundation/Foundation.h>
#import "Common.h"
#import "SqlObj.h"
 

/////
extern "C" {  
      sqlite3 *Sql_Open(const char*source)
    { 
//         SqlObj *sql =  [[SqlObj alloc] init];
          SqlObj *sql =[SqlObj sharedSqlObj];
//        [[SqlObj sharedSqlObj].arraySQL addObject:sql];
//        [sql retain];
      return  [sql Open:[NSString stringWithUTF8String:source]];
        
    }
    void Sql_Close(sqlite3 *db)
    { 
         SqlObj *sql = [SqlObj sharedSqlObj];
        [sql Close:db];
    }

   void Sql_ExecSQL(sqlite3 *database,const char*sql)
    { 
          SqlObj *p = [SqlObj sharedSqlObj];
        [p ExecSQL:[NSString stringWithUTF8String:sql] db:database];
    }
   sqlite3_stmt * Sql_Query(sqlite3 *database,const char*sql)
    { 
        SqlObj *p = [SqlObj sharedSqlObj];
       sqlite3_stmt *statement = [p Query:[NSString stringWithUTF8String:sql] db:database];
        return statement;
    }
      bool Sql_MoveToFirst(sqlite3_stmt *statement)
    { 
         SqlObj *p = [SqlObj sharedSqlObj];
        return [p MoveToFirst:statement];
    }

          bool Sql_MoveToNext(sqlite3_stmt *statement)
    { 
        SqlObj *p = [SqlObj sharedSqlObj];
        return [p MoveToNext:statement];
    }

             int Sql_GetCount(sqlite3_stmt *statement)
    { 
         SqlObj *p = [SqlObj sharedSqlObj];
        return [p GetCount:statement];
    }
             const char* Sql_GetString(sqlite3_stmt *statement,const char* key)
    { 
          SqlObj *p = [SqlObj sharedSqlObj];
          NSString *strRet = [p GetString:[NSString stringWithUTF8String:key ] st:statement];
         return makeStringCopy(strRet); 
    }
     
}

