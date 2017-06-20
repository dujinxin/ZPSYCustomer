
#import <Foundation/Foundation.h>

#define GMY_REQUESTING_SERVER_DATA 0
#define GMY_REQUEST_SERVER_DATA_SUCCESS 1
#define GMY_REQUEST_SERVER_DATA_FAIL 2
#define GMY_DECODE_FAIL 3

@protocol DecodeMessageDelegate  <NSObject>

@required
-(bool) messageHandling:(int)msg_id Data:(NSString *)data;

@end


@interface gmyDecoder : NSObject


-(id) init:(id <DecodeMessageDelegate>) delegate;
-(int) gray_image_decode:(unsigned char *)img width:(int)w height:(int)h left:(int)l top:(int)t right:(int)r bottom:(int)b;


@end

