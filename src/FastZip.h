#import <Foundation/Foundation.h>

@interface FastZip: NSObject {
  char* curr;
  char* buffer;
  int size;
  NSMutableArray* keys;
}

- (id) initWithBuffer: (char*) buffer size: (int) size;

- (NSArray *) keys;

- (NSData *)  objectForKey: (NSString *) key;

@property (readonly) char* buffer;
@property (readonly) char* curr;
@property (readonly) int size;

@end
