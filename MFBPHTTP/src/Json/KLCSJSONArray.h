//
//  KLCSJSONArray.h
//  AFNetworking
//
//  Created by Mr_Jesson on 2019/11/25.
//

#import <Foundation/Foundation.h>
@class KLCSJSONObject;
NS_ASSUME_NONNULL_BEGIN

@interface KLCSJSONArray : NSObject<NSFastEnumeration>

@property (strong,nonatomic,readonly) NSMutableArray* array;

/**
 *  使用Array 对象实例化 KLCSJSONArray。
 *
 *  @param array JSONArray 字符串
 *
 *  @return return KLCSJSONArray 对象
 */
-(instancetype) initWithMutableArray:(NSMutableArray*)array;

/**
 *  使用Array 对象实例化 KLCSJSONArray。
 *
 *  @param array JSONArray 字符串
 *
 *  @return return KLCSJSONArray 对象
 */
-(instancetype) initWithArray:(NSArray*)array;

/**
 *  解析JSON字符串，并实例化 KLCSJSONArray。
 *
 *  @param string JSONArray 字符串
 *
 *  @return return KLCSJSONArray 对象，如果字符串不是一个 JSONArray 则实例化失败，返回nil。
 */
-(instancetype) initWithString:(NSString*)string;


/**
 *  获取布尔值
 *
 *  @param index 索引
 *
 *  @return 如果值不存在或类型不正确返回 false，如果存在返回值内容。
 */
-(BOOL)getBoolean:(int) index;
-(BOOL)optBoolean:(int) index defaultValue:(BOOL) defaultValue;

-(int)getInteger:(int) index;
-(int)optInteger:(int) index defaultValue:(int) defaultValue;

-(double)getDouble:(int) index;
-(double)optDouble:(int) index defaultValue:(double) defaultValue;

-(NSString*)getString:(int) index;
-(NSString*)optString:(int) index defaultValue:(NSString*) defaultValue;

-(KLCSJSONArray*)getJSONArray: (int) index;

-(KLCSJSONObject*)getJSONObject:(int) index;

-(void) putWithBoolean:(Boolean)  value;
-(void) putWithInt:    (int)      value;
-(void) putWithDouble: (double)   value;
-(void) putWithString: (NSString*)value;
-(void) putWithJSONArray:(KLCSJSONArray*) value;
-(void) putWithJSONObject:(KLCSJSONObject*) value;

-(BOOL)hasIndex:(int)index;
-(NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len;
-(NSUInteger)count;
-(NSString *)description;

@end

NS_ASSUME_NONNULL_END
