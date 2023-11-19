import { Uxn } from "uxn.wasm";
import { asm, mux, LogConsole } from "uxn.wasm/util";

(async () => {
  const uxn = new Uxn();
  await uxn.init(mux(uxn, { 0x10: new LogConsole() }));
  uxn.load(
    asm(`
( Source: https://git.sr.ht/~rabbits/uxn/tree/main/item/projects/examples/exercises )

|0100 ( -> ) @reset
  #0000 INC2k
  &loop
    DUP2 not-prime ?&skip
      DUP2 print/short #2018 DEO
      &skip
    INC2 NEQ2k ?&loop
  POP2 POP2
  #0a18 DEO
  ( halt ) #010f DEO
BRK

@not-prime ( number* -- flag )
  DUP2 ,&t STR2
  ( range ) #01 SFT2 #0002 LTH2k ?&fail
  &loop
    [ LIT2 &t $2 ] OVR2 ( mod2 ) DIV2k MUL2 SUB2 ORA ?&continue
      &fail POP2 POP2 #01 JMP2r &continue
    INC2 GTH2k ?&loop
  POP2 POP2 #00
JMP2r

@print ( short* -- )
  &short ( short* -- ) SWP print/byte
  &byte ( byte -- ) DUP #04 SFT print/char
  &char ( char -- ) #0f AND DUP #09 GTH #27 MUL ADD #30 ADD #18 DEO
JMP2r
`)
  );
  uxn.eval();
})();
