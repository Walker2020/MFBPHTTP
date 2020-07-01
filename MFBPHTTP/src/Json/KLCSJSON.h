//
//  KLCSJSON.h
//  AFNetworking
//
//  Created by Mr_Jesson on 2019/11/25.
//

#import <Foundation/Foundation.h>

@interface NSArray (KLCSJSONSerializing)
- (NSString*)JSONRepresentation;
@end

@interface NSDictionary (KLCSJSONSerializing)
- (NSString*)JSONRepresentation;
@end

@interface NSString (KLCSJSONSerializing)
- (id)JSONSerialization;
@end
