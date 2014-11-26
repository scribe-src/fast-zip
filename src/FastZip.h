#import <Foundation/Foundation.h>
#import "unzip.h"

@interface FastZip: NSObject {
  char* buffer;
  unsigned long offset;
  unsigned long size;
  NSMutableArray* keys;
  unzFile file;
}

+ (id) withBuffer: (char*) buff size: (unsigned long) sz;

- (id) initWithBuffer: (char*) buffer size: (unsigned long) size;

- (NSArray *) keys;

- (NSData *)  objectForKey: (NSString *) key;

@property (readonly) char* buffer;
@property (readonly) unsigned long offset;
@property (readonly) unsigned long size;
@property (readonly, retain) NSArray *keys;

@end
