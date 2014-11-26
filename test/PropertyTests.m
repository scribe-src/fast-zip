#import "UnitTest.h"
#import "FastZip.h"

static char* empty = "PK\x05\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00";
static int emptyLen = 22;

TEST_SUITE(PropertyTests)

TEST(FastZipDotBuffer)
  FastZip *f = [FastZip withBuffer: empty size: emptyLen];
  AssertEqual(f.buffer, empty);
END_TEST

TEST(FastZipDotSize)
  FastZip *f = [FastZip withBuffer: empty size: emptyLen];
  AssertIntEqual(f.size, emptyLen);
END_TEST

TEST(FastZipDotKeys)
  FastZip *f = [FastZip withBuffer: empty size: emptyLen];
  AssertIntEqual(f.keys.count, 0);
END_TEST

END_TEST_SUITE
