#import <Foundation/Foundation.h>

@interface FastZip: NSObject {
  const char* curr;
  const char* buffer;
  long long int size;
  NSMutableArray* keys;
}

- (id) initWithBuffer: (const char*) buff;

- (NSArray *) keys;

- (NSData *)  objectForKey: (NSString *) key;

@end
