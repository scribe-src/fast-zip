#import "UnitTest.h"
#import "FastZip.h"

static char* empty = "PK\x05\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00";
static int emptyLen = 22;

TEST_SUITE(InstantiationTests)

TEST(FastZipFromBufferAlloc)
  FastZip *f = [[FastZip alloc] initWithBuffer: empty size: emptyLen];
  AssertIntEqual(f.size, emptyLen);
  [f release];
END_TEST

TEST(FastZipFromBufferStaticConstructor)
  FastZip *f = [FastZip withBuffer: empty size: emptyLen];
  AssertIntEqual(f.size, emptyLen);
END_TEST

TEST(FastZipFromNSDataAlloc)
  NSData *data = [NSData dataWithBytes: empty length: emptyLen];
  FastZip *f = [[FastZip alloc] initWithData: data];
  AssertIntEqual(f.size, emptyLen);
  [f release];
END_TEST

TEST(FastZipFromNSDataStaticConstructor)
  NSData *data = [NSData dataWithBytes: empty length: emptyLen];
  FastZip *f = [FastZip withData: data];
  AssertIntEqual(f.size, emptyLen);
END_TEST

END_TEST_SUITE
