#import <Foundation/Foundation.h>

@interface FastZip: NSObject {
  const char* buffer;
}

- (id) initWithBuffer: (const char*) buff;

- (NSArray *) keys;

- (NSData *)  objectForKey: (NSString *) key;

@end
