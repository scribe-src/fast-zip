// Stubbed File I/O methods for performing zip operations in-memory

// this doesn't actually do anything, since the buffer is already in memory
static void* fopen_file_func(void* opaque, const char* filename, int mode) {
  return NULL;
}

// this doesn't actually do anything, since the buffer is already in memory
static void* fopendisk_file_func(void* opaque, void* stream, int number_disk, int mode) {
  return NULL;
}

static unsigned long fread_file_func(
  void* opaque,
  void* stream,
  void* buf,
  unsigned long size) {

  FastZip *instance = (FastZip *)opaque;
  unsigned long rest = instance.size - instance.offset;
  size = (rest > size) ? size : rest;
  memcpy(stream, &(instance.buffer[instance.offset]), size);
  instance.offset += size;
  return size;
}

static long ftell_file_func(void* opaque, void* stream) {
  FastZip *instance = (FastZip *)opaque;
  return instance.offset;
}

static long fseek_file_func(
  void* opaque,
  void* stream,
  unsigned long offset,
  int origin) {

  FastZip *instance = (FastZip *)opaque;
  instance.offset = offset;
  return offset;
}

static int fclose_file_func(void* opaque, void* stream) {
  return 0;
}

static int ferror_file_func(void* opaque, void* stream) {
  return 0;
}
