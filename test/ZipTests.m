#import "UnitTest.h"
#import "FastZip.h"

TEST_SUITE(ZipTests)

TEST(ATxtZipFileExists)

  NSData *data = [NSData dataWithContentsOfFile: @"./test/data/a.txt.zip"];
  Assert(data && [data length] > 0);

END_TEST

TEST(ATxtZipFileValid)

  NSData *data = [NSData dataWithContentsOfFile: @"./test/data/a.txt.zip"];
  FastZip *f = [[FastZip alloc] initWithBuffer: (char*)[data bytes] size: [data length]];
  // AssertEqual(f.buffer, [zip bytes]);
  [f release];

END_TEST

END_TEST_SUITE
