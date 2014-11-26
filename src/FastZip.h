#import <Foundation/Foundation.h>
#import "unzip.h"

@interface FastZip: NSObject {
  char* curr;
  char* buffer;
  int size;
  NSMutableArray* keys;
  unzFile file;
}

+ (id) withBuffer: (char*) buff size: (int) sz;

- (id) initWithBuffer: (char*) buffer size: (int) size;

- (NSArray *) keys;

- (NSData *)  objectForKey: (NSString *) key;

@property (readonly) char* buffer;
@property (readonly) char* curr;
@property (readonly) int size;
@property (readonly, retain) NSArray *keys;

@end
