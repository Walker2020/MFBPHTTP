//
//  KLCSJSONArray.m
//  AFNetworking
//
//  Created by Mr_Jesson on 2019/11/25.
//

#import "KLCSJSONArray.h"
#import "KLCSJSONObject.h"

@implementation KLCSJSONArray

-(void) dealloc
{
#if ! __has_feature(objc_arc)
    [super dealloc];
#endif
}

-(instancetype) init
{
    return [self initWithMutableArray:nil];
}

-(instancetype) initWithString:(NSString*)string
{
    NSError *error;
    id json;
    
    if (string && [string length] > 0) {
        json = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding]
                                               options:NSJSONReadingMutableContainers
                                                 error:&error];
    }
    else{
        json = [NSJSONSerialization JSONObjectWithData:[@"[]" dataUsingEncoding:NSUTF8StringEncoding]
                                               options:NSJSONReadingMutableContainers
                                                 error:&error];
    }
    
    if ([json isKindOfClass:[NSMutableArray class]])
        return [self initWithMutableArray:json];
    else
        return nil;
}

-(instancetype) initWithMutableArray:(NSMutableArray*)array
{
    self = [super init];
    
    if (self){
        if (array)
            _array = array;
        else
            _array = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(instancetype) initWithArray:(NSArray*)array
{
    self = [super init];
    
    if (self){
        if (array)
            _array = [[NSMutableArray alloc] initWithArray:array];
        else
            _array = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#pragma mark - 判断是否有这个index
-(BOOL)hasIndex:(int)index
{
    if (index < self.count)
    {
        return YES;
    }
    return NO;
}
#pragma mark - 获得bool值
-(BOOL)getBoolean:(int) index
{
    return [self optBoolean:index defaultValue:NO];
}

#pragma mark - 获得bool值，失败返回缺省
-(BOOL)optBoolean:(int) index defaultValue:(BOOL) defaultValue
{
    BOOL result = defaultValue;
    
    if ([self hasIndex:index])
    {
        id value = [_array objectAtIndex:index];
        result   = [[value description] boolValue];
    }
    
    return result;
}

#pragma mark - 获得整型值
-(int)getInteger:(int) index
{
    return [self optInteger:index defaultValue:0];
}

#pragma mark - 获得整型值，失败返回缺省
-(int)optInteger:(int) index defaultValue:(int) defaultValue
{
    int result = defaultValue;
    
    if ([self hasIndex:index])
    {
        id value = [_array objectAtIndex:index];
        result   = [[value description] intValue];
    }
    
    return result;
}

#pragma mark - 获取Long型值
- (long long)getLong:(int) index
{
    return [self optLong:index defaultValue:0];
}

#pragma mark - 获取Long型带默认值
- (long long)optLong:(int) index defaultValue:(long long)defaultValue
{
    long long result = defaultValue;
    
    if ([self hasIndex:index]) {
        id value = [_array objectAtIndex:index];
        
        if ([value isKindOfClass:[NSString class]]){
            NSString *valueStr = (NSString *)value;
            result = [valueStr longLongValue];
        }
        else if([value isKindOfClass:[NSNumber class]]){
            NSNumber *valueNum = (NSNumber *)value;
            result = [valueNum longLongValue];
        }
    }
    
    return result;
}

#pragma mark - 获得浮点型值
-(double)getDouble:(int) index
{
    return [self optDouble:index defaultValue:0.0f];
}

#pragma mark - 获得浮点型值，失败返回缺省
-(double)optDouble:(int) index defaultValue:(double) defaultValue
{
    double result = defaultValue;
    
    if ([self hasIndex:index])
    {
        id value = [_array objectAtIndex:index];
        result   = [[value description] doubleValue];
    }
    
    return result;
}

#pragma mark - 获得字符串值
-(NSString *)getString:(int) index
{
    return [self optString:index defaultValue:nil];
}

#pragma mark - 获得字符串，失败返回缺省
-(NSString*)optString:(int) index defaultValue:(NSString*) defaultValue
{
    
    if ([self hasIndex:index])
    {
        id obj = [_array objectAtIndex:index];
        if ([obj isKindOfClass:[NSString class]]){
            return obj;
        }
        else if ([obj isKindOfClass:[NSNumber class]]){
            return  [obj description];
        }
    }
    return defaultValue;
}

#pragma mark - 获得JSONArr，失败返回nil
-(KLCSJSONArray*) getJSONArray:(int)index
{
    if ([self hasIndex:index])
    {
        id obj = [_array objectAtIndex:index];
        if([obj isKindOfClass:[NSMutableArray class]]){
            return [[KLCSJSONArray alloc]initWithMutableArray:obj];
        }
    }
    return nil;
}

#pragma mark - 获得JSONObj，失败返回nil
-(KLCSJSONObject*)getJSONObject:(int)index
{
    if ([self hasIndex:index])
    {
        id obj = [_array objectAtIndex:index];
        if ([obj isKindOfClass:[NSDictionary class]]){
            return [[KLCSJSONObject alloc]initWithDictionary:obj];
        }
    }
    return nil;
}

#pragma mark - 往数组中添加bool值
-(void) putWithBoolean:(Boolean)value
{
    NSNumber * obj = [NSNumber numberWithBool:value];
    [_array addObject:obj];
}

#pragma mark - 往数组中添加int值
-(void) putWithInt:(int)value
{
    NSNumber * obj = [NSNumber numberWithInt:value];
    [_array addObject:obj];
}

#pragma mark - 往数组中添加double值
-(void) putWithDouble: (double)value
{
    NSNumber * obj = [NSNumber numberWithDouble:value];
    [_array addObject:obj];
}

#pragma mark - 往数组中添加NSString
-(void) putWithString: (NSString*)value
{
    if (!value) value = @"";
    [_array addObject:value];
}

-(void) putWithJSONArray:(KLCSJSONArray*) value
{
    [_array addObject:value.array];
}

-(void) putWithJSONObject:(KLCSJSONObject*) value
{
    [_array addObject:value.dictionary];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len
{
    return [_array countByEnumeratingWithState:state objects:buffer count:len];
}

-(NSUInteger)count
{
    return [_array count];
}

-(NSString *)description
{
    NSError *error;
    NSData  *data  = [NSJSONSerialization dataWithJSONObject: _array
                                                     options: NSJSONWritingPrettyPrinted
                                                       error: &error];
    if (!error){
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return @"{}";
}

@end
