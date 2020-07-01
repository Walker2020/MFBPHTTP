//
//  KLCSJSONObject.m
//  AFNetworking
//
//  Created by Mr_Jesson on 2019/11/25.
//

#import "KLCSJSONObject.h"
#import "KLCSJSONArray.h"

@implementation KLCSJSONObject

-(void) dealloc
{
#if ! __has_feature(objc_arc)
    [super dealloc];
#endif
}

-(instancetype) init
{
    return [self initWithMutableDictionary:nil];
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
        json = [NSJSONSerialization JSONObjectWithData:[@"{}" dataUsingEncoding:NSUTF8StringEncoding]
                                               options:NSJSONReadingMutableContainers
                                                 error:&error];
    }
    
    if ([json isKindOfClass:[NSMutableDictionary class]])
        return [self initWithMutableDictionary:json];
    else
        return nil;
    
}

-(instancetype) initWithMutableDictionary:(NSMutableDictionary*)dict
{
    self = [super init];
    
    if (self) {
        if (dict)
            _dictionary = dict;
        else
            _dictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}
- (NSMutableDictionary *)getDictionaryObj
{
    return [NSMutableDictionary dictionaryWithDictionary:_dictionary];
}
-(instancetype) initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    if (self) {
        if (dict)
            _dictionary = [[NSMutableDictionary alloc] initWithDictionary:dict];
        else
            _dictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

#pragma mark - 判断有没有要抽取的关键字
-(BOOL)hasKey:(NSString *)key
{
    return [_dictionary objectForKey:key] != nil;
}

#pragma mark - 获取布尔型值
-(BOOL)getBoolean:(NSString*) key
{
    return [self optBoolean:key defaultValue:NO];
}

#pragma mark 获取布尔型值，失败返回缺省
-(BOOL)optBoolean:(NSString *)key defaultValue:(BOOL)defaultValue
{
    BOOL result = defaultValue;
    
    if ([self hasKey:key])
    {
        id value = [_dictionary objectForKey:key];
        result   = [[value description] boolValue];
    }
    
    return result;
}

#pragma mark - 获取整型值
-(NSInteger)getInteger:(NSString *)key
{
    return [self optInteger:key defaultValue:0];
}
#pragma mark - 获取整型值,失败返回缺省
-(NSInteger)optInteger:(NSString *)key defaultValue:(NSInteger)defaultValue
{
    NSInteger result = defaultValue;
    
    if ([self hasKey:key])
    {
        id value = [_dictionary objectForKey:key];
        result   = [[value description] intValue];
    }
    
    return result;
}

#pragma mark - 获取浮点型值
-(double)getDouble:(NSString *)key
{
    return [self optDouble:key defaultValue:0.0];
}

#pragma mark - 获取浮点型值,失败返回缺省
-(double)optDouble:(NSString *)key defaultValue:(double)defaultValue
{
    double result = defaultValue;
    
    if ([self hasKey:key])
    {
        id value = [_dictionary objectForKey:key];
        result   = [value doubleValue];
    }
    
    return result;
}

#pragma mark - 获取Long型值
- (long long)getLong:(NSString *)key
{
    return [self optLong:key defaultValue:0];
}

#pragma mark - 获取Long型带默认值
- (long long)optLong:(NSString *)key defaultValue:(long long)defaultValue
{
    long long result = defaultValue;
    
    if ([self hasKey:key]) {
        id value = [_dictionary objectForKey:key];
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

#pragma mark - 获取字符串对象
-(NSString *)getString:(NSString *)key
{
    return [self optString:key defaultValue:nil];
}

#pragma mark - 获取字符串对象,失败返回确定
-(NSString *)optString:(NSString *)key defaultValue:(NSString *)defaultValue
{
    NSString *result = defaultValue;
    
    if([self hasKey:key])
    {
        id value = [_dictionary objectForKey:key];
        if ([value isKindOfClass:[NSString class]]){
            result = value;
        }
        else if ([value isKindOfClass:[NSNumber class]]){
            result = [value description];
        }
    }
    
    return result;
}

#pragma mark - 获取KLCSJSONArray对象
-(KLCSJSONArray *)getJSONArray:(NSString *)key
{
    if ([self hasKey:key])
    {
        id obj = [_dictionary objectForKey:key];
        if([obj isKindOfClass:[NSArray class]]){
            return [[KLCSJSONArray alloc]initWithArray:obj];
        }
    }
    return nil;
}
#pragma mark - 获取_dictionary对象
-(KLCSJSONObject *)getJSONObject:(NSString *)key
{
    if ([self hasKey:key])
    {
        id obj = [_dictionary objectForKey:key];
        if ([obj isKindOfClass:[NSDictionary class]]){
            return [[KLCSJSONObject alloc]initWithMutableDictionary:obj];
        }
    }
    return nil;
}

#pragma mark - 往对象中添加元素
-(void) putWithBoolean:(Boolean) value key:(NSString*)key
{
    NSNumber * obj = [NSNumber numberWithBool:value];
    [_dictionary setObject:obj forKey:key];
}

-(void)putWithDouble:(double)value key:(NSString*)key;
{
    NSNumber * obj = [NSNumber numberWithDouble:value];
    [_dictionary setObject:obj forKey:key];
}

-(void)putWithInt:(int)value key:(NSString*)key
{
    NSNumber * obj = [NSNumber numberWithInt:value];
    [_dictionary setObject:obj forKey:key];
}

-(void)putWithString:(NSString*)value key:(NSString*)key
{
    if (!value) value =@"";
    
    [_dictionary setObject:value forKey:key];
}

-(void) putWithJSONArray:(KLCSJSONArray*) value key:(NSString*)key
{
    [_dictionary setObject:value.array forKey:key];
}

-(void) putWithJSONObject:(KLCSJSONObject*) value key:(NSString*)key
{
    [_dictionary setObject:value.dictionary forKey:key];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len
{
    return [_dictionary countByEnumeratingWithState:state objects:buffer count:len];
}

-(NSArray*) allKeys
{
    return [_dictionary allKeys];
}

-(NSArray *) allValues
{
    return [_dictionary allValues];
}

-(NSString *)description
{
    NSError *error;
    NSData  *data  = [NSJSONSerialization dataWithJSONObject: _dictionary
                                                     options: NSJSONWritingPrettyPrinted
                                                       error: &error];
    if (!error){
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return @"{}";
}

-(NSUInteger)count
{
    return [_dictionary count];
}
@end
