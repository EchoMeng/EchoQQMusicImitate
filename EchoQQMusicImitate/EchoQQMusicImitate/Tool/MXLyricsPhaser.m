//
//  MXLyricsPhaser.m
//  EchoQQMusicImitate
//
//  Created by mac on 2018/5/1.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MXLyricsPhaser.h"
#import "MXLyrics.h"

@implementation MXLyricsPhaser

+ (NSArray *)lyricsWithFileName:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSString *lyricsStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    //用\n换行符将歌词文本区分为每句歌词，放入数组中
    NSArray *lyricsArray = [lyricsStr componentsSeparatedByString:@"\n"];
    //正则表达式
    NSString *pattern = @"\\[[0-9]{2}:[0-9]{2}.[0-9]{2}\\]";
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    //这个数组用来装结果，数组中是歌词模型，包括每一行歌词文本和对应的时间
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSString *lineStr in lyricsArray) {
        //到这里都是在匹配每一句歌词前的时间点
        NSArray *results = [regular matchesInString:lineStr options:0 range:NSMakeRange(0, lineStr.length)];
        NSTextCheckingResult *lastResult = results.lastObject;
        //这里的contents才真正匹配到每一句歌词的内容
        NSString *contentStr = [lineStr substringFromIndex:lastResult.range.location + lastResult.range.length];
        //这里处理时间数据
        for (NSTextCheckingResult *res in results) {
            NSString *timeStr = [lineStr substringWithRange:res.range];
            NSDateFormatter *dataFormat = [[NSDateFormatter alloc] init];
            dataFormat.dateFormat = @"[mm:ss.SS]";
            NSDate *date = [dataFormat dateFromString:timeStr];
            NSDate *initDate = [dataFormat dateFromString:@"[00:00.00]"];
            NSTimeInterval time = [date timeIntervalSinceDate:initDate];
            // 给歌词模型赋值
            MXLyrics *lyricsModel = [[MXLyrics alloc] init];
            lyricsModel.content = contentStr;
            lyricsModel.initTime = time;
            
            [array addObject:lyricsModel];
        }
        
    }
    //这里不可以直接返回数据，要对数据进行排序，部分重复的歌词的格式需要做调整，因此一定要排序
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"initTime" ascending:YES];
    [array sortUsingDescriptors:@[descriptor]];
    
    return array;
}

@end
