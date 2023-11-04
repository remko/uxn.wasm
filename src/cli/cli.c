#include <stdio.h>
#include <stdlib.h>

#include "cli_core.h"

typedef struct w2c_system {
  wasm_rt_memory_t *mem;
} w2c_system;

void w2c_system_deo(struct w2c_system *sys, u32 port, u32 value) {
  // Console
  if (port == 0x18) {
    fputc(value, stdout);
  } else if (port == 0x18) {
    fputc(value, stderr);
  }
}

u32 w2c_system_dei(struct w2c_system *sys, u32 port) {
  return (u32)sys->mem->data[0x10200 + port];
}

int main(int argc, char **argv) {
  if (argc < 2) {
    printf("missing rom\n");
    return 1;
  }
  FILE *file = fopen(argv[1], "rb");
  if (file == NULL) {
    printf("error opening file\n");
    return 1;
  }
  fseek(file, 0, SEEK_END);
  long filesize = ftell(file);
  fseek(file, 0, SEEK_SET);

  wasm_rt_init();
  w2c_uxn uxn;
  w2c_system sys;
  wasm2c_uxn_instantiate(&uxn, &sys);
  sys.mem = w2c_uxn_memory(&uxn);

  // Read ROM
  (void)!fread(sys.mem->data + 0x100, filesize, 1, file);
  if (ferror(file)) {
    printf("error reading file\n");
    return 1;
  }

  // Run
  w2c_uxn_eval(&uxn, 0x100);

  // Cleanup
  wasm2c_uxn_free(&uxn);
  wasm_rt_free();
  fclose(file);
  return 0;
}
