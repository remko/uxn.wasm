#include <stdio.h>
#include <stdlib.h>

#include "uxnwasm_core.h"

typedef struct w2c_system {
} w2c_system;

void w2c_system_deo(struct w2c_system* sys, u32 port, u32 value) {
  if (port == 0x18) {
    printf("%c", value);
  } else {
  }
}

u32 w2c_system_dei(struct w2c_system* sys, u32 port) {
  return 0;
}

int main(int argc, char** argv) {
  if (argc < 2) {
    printf("missing rom\n");
    return 1;
  }
  FILE* file = fopen(argv[1], "rb");
  if (file == NULL) {
      printf("error opening file\n");
      return 1;
  }

  wasm_rt_init();
  w2c_uxn uxn;
  w2c_system sys;
  wasm2c_uxn_instantiate(&uxn, &sys);
  wasm_rt_memory_t* mem = w2c_uxn_memory(&uxn);

  // FIXME: USe buffers
  char byte;
  int i = 0x100;
  while (fread(&byte, 1, 1, file) == 1) {
    mem->data[i++] = byte;
  }

  w2c_uxn_eval(&uxn, 0x100);

  wasm2c_uxn_free(&uxn);
  wasm_rt_free();
  fclose(file);
  return 0;
}