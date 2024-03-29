//
//  TCMemoTool.h
//  SecurityNote
//


#import <Foundation/Foundation.h>
@class TCMemo;

@interface TCMemoTool : NSObject

+(NSMutableArray *)queryWithNote;

+(void)deleteNote:(int)ids;

+(void)insertNote:(TCMemo *)memoNote;

+(TCMemo *)queryOneNote:(int)ids;

+(void)updataNote:(TCMemo *)updataNote;


@end
