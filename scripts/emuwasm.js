#!/usr/bin/env node

const instructions = [
  [
    "BRK",
    `
`,
  ],
  [
    "INC",
    `
(local.set $t (#T))
(#set 1 0)
(#T! (i32.add (local.get $t) (i32.const 1)))
`,
  ],
  [
    "POP",
    `
(#set 1 -1)
`,
  ],
  [
    "NIP",
    `
(local.set $t (#T))
(#set 2 -1)
(#T! (local.get $t))
`,
  ],
  [
    "SWP",
    `
(local.set $t (#T))
(local.set $n (#N))
(#set 2 0)
(#T! (local.get $n))
(#N! (local.get $t))
`,
  ],
  [
    "ROT",
    `
(local.set $t (#T))
(local.set $n (#N))
(local.set $l (#L))
(#set 3 0)
(#T! (local.get $l))
(#N! (local.get $t))
(#L! (local.get $n))
`,
  ],
  [
    "DUP",
    `
(local.set $t (#T))
(#set 1 1)
(#T! (local.get $t))
(#N! (local.get $t))
`,
  ],
  [
    "OVR",
    `
(local.set $t (#T))
(local.set $n (#N))
(#set 2 1)
(#T! (local.get $n))
(#N! (local.get $t))
(#L! (local.get $n))
`,
  ],
  [
    "EQU",
    `
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.eq (local.get $t) (local.get $n)))
`,
  ],
  [
    "NEQ",
    `
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.ne (local.get $t) (local.get $n)))
`,
  ],
  [
    "GTH",
    `
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.gt_u (local.get $n) (local.get $t)))
`,
  ],
  [
    "LTH",
    `
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.lt_u (local.get $n) (local.get $t)))
`,
  ],
  [
    "JMP",
    `
(local.set $t (#Ts))
(#set 1 -1)
(local.set $pc (i32.add (local.get $pc) (local.get $t)))
`,
  ],
  [
    "JCN",
    `
(local.set $t (#Ts))
(local.set $n (#N))
(#set 2 -2)
(local.set $pc (i32.add (local.get $pc) (select (local.get $t) (i32.const 0) (local.get $n))))
`,
  ],
  [
    "JSR",
    `
(local.set $t (#Ts))
(#set 1 -1)
(#~set 0 2)
(#~T2! (local.get $pc))
(local.set $pc (i32.add (local.get $pc) (local.get $t)))
`,
  ],
  [
    "STH",
    `
(local.set $t (#T))
(#set 1 -1)
(#~set 0 1)
(#~T! (local.get $t))
`,
  ],
  [
    "LDZ",
    `
(local.set $t (#T))
(#set 1 0)
(#T! (i32.load8_u (local.get $t)))
`,
  ],
  [
    "STZ",
    `
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -2)
(i32.store8 (local.get $t) (local.get $n))
`,
  ],
  [
    "LDR",
    `
(local.set $t (#Ts))
(#set 1 0)
(#T! (i32.load8_u (i32.add (local.get $pc) (local.get $t))))
`,
  ],
  [
    "STR",
    `
(local.set $t (#Ts))
(local.set $n (#N))
(#set 2 -2)
(i32.store8 (i32.add (local.get $pc) (local.get $t)) (local.get $n))
`,
  ],
  [
    "LDA",
    `
(local.set $t (#T2))
(#set 2 -1)
(#T! (i32.load8_u (local.get $t)))
`,
  ],
  [
    "STA",
    `
(local.set $t (#T2))
(local.set $n (#L))
(#set 3 -3)
(i32.store8 (local.get $t) (local.get $n))
`,
  ],
  [
    "DEI",
    `
(local.set $t (#T))
(#set 1 0)
(#T! (call $dei (local.get $t)))
`,
  ],
  [
    "DEO",
    `
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -2)
(i32.store8 offset=0x10200 (local.get $t) (local.get $n))
(call $deo (local.get $t) (local.get $n))
`,
  ],
  [
    "ADD",
    `
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.add (local.get $n) (local.get $t)))
`,
  ],
  [
    "SUB",
    `
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.sub (local.get $n) (local.get $t)))
`,
  ],
  [
    "MUL",
    `
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.mul (local.get $n) (local.get $t)))
`,
  ],
  [
    "DIV",
    `
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (if (result i32) (i32.eqz (local.get $t)) (then (i32.const 0)) (else (i32.div_u (local.get $n) (local.get $t)))))
`,
  ],
  [
    "AND",
    `
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.and (local.get $n) (local.get $t)))
`,
  ],
  [
    "ORA",
    `
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.or (local.get $n) (local.get $t)))
`,
  ],
  [
    "EOR",
    `
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.xor (local.get $n) (local.get $t)))
`,
  ],
  [
    "SFT",
    `
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4))))
`,
  ],
  [
    "JCI",
    `
(local.set $t (#T))
(#set 0 -1)
(if (local.get $t) (then (local.set $pc (i32.add (i32.const 2) (i32.add (local.get $pc) (#peek16s (local.get $pc)))))) (else (local.set $pc (i32.add (local.get $pc) (i32.const 2)))))
`,
  ],
  [
    "INC2",
    `
(local.set $t (#T2))
(#set 2 0)
(#T2! (i32.add (local.get $t) (i32.const 1)))
`,
  ],
  [
    "POP2",
    `
(#set 2 -2)
`,
  ],
  [
    "NIP2",
    `
(local.set $t (#T2))
(#set 4 -2)
(#T2! (local.get $t))
`,
  ],
  [
    "SWP2",
    `
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 0)
(#T2! (local.get $n))
(#N2! (local.get $t))
`,
  ],
  [
    "ROT2",
    `
(local.set $t (#T2))
(local.set $n (#N2))
(local.set $l (#L2))
(#set 6 0)
(#T2! (local.get $l))
(#N2! (local.get $t))
(#L2! (local.get $n))
`,
  ],
  [
    "DUP2",
    `
(local.set $t (#T2))
(#set 2 2)
(#T2! (local.get $t))
(#N2! (local.get $t))
`,
  ],
  [
    "OVR2",
    `
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 2)
(#T2! (local.get $n))
(#N2! (local.get $t))
(#L2! (local.get $n))
`,
  ],
  [
    "EQU2",
    `
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -3)
(#T! (i32.eq (local.get $t) (local.get $n)))
`,
  ],
  [
    "NEQ2",
    `
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -3)
(#T! (i32.ne (local.get $t) (local.get $n)))
`,
  ],
  [
    "GTH2",
    `
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -3)
(#T! (i32.gt_u (local.get $n) (local.get $t)))
`,
  ],
  [
    "LTH2",
    `
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -3)
(#T! (i32.lt_u (local.get $n) (local.get $t)))
`,
  ],
  [
    "JMP2",
    `
(local.set $t (#T2))
(#set 2 -2)
(local.set $pc (local.get $t))
`,
  ],
  [
    "JCN2",
    `
(local.set $t (#T2))
(local.set $n (#L))
(#set 3 -3)
(local.set $pc (select (local.get $t) (local.get $pc) (local.get $n)))
`,
  ],
  [
    "JSR2",
    `
(local.set $t (#T2))
(#set 2 -2)
(#~set 0 2)
(#~T2! (local.get $pc))
(local.set $pc (local.get $t))
`,
  ],
  [
    "STH2",
    `
(local.set $t (#T2))
(#set 2 -2)
(#~set 0 2)
(#~T2! (local.get $t))
`,
  ],
  [
    "LDZ2",
    // Used to be (#T2^! (i32.load16_u (local.get $t))).
    // Since LDZ2 does not wrap, this was ok, but performance is the same (and this is more consistent with LDZ)
    `
(local.set $t (#T))
(#set 1 1)
(#T2<zmem! (local.get $t))
`,
  ],
  [
    "STZ2",
    // Used to be (i32.store16 (local.get $t) (local.get $n))
    // Since STZ2 does not wrap, this was ok, but peformance is actually worse.
    `
(local.set $t (#T))
(local.set $n (#N))
(local.set $l (#L))
(#set 3 -3)
(#poke2z (local.get $t) (local.get $l) (local.get $n))
`,
  ],
  [
    "LDR2",
    `
(local.set $t (#Ts))
(#set 1 1)
(#T2<meme! (i32.add (local.get $pc) (local.get $t)))
`,
  ],
  [
    "STR2",
    `
(local.set $t (#Ts))
(local.set $n (#N))
(local.set $l (#L))
(#set 3 -3)
(#poke2e (i32.add (local.get $pc) (local.get $t)) (local.get $l) (local.get $n))
`,
  ],
  [
    "LDA2",
    `
(local.set $t (#T2))
(#set 2 0)
(#T2<mem! (local.get $t))
`,
  ],
  [
    "STA2",
    `
(local.set $t (#T2))
(local.set $n (#L))
(local.set $l (#X))
(#set 4 -4)
(#poke2 (local.get $t) (local.get $l) (local.get $n))
`,
  ],
  [
    "DEI2",
    `
(local.set $t (#T))
(#set 1 1)
(#T! (call $dei (i32.add (local.get $t) (i32.const 1))))
(#N! (call $dei (local.get $t)))
`,
  ],
  [
    "DEO2",
    `
(local.set $t (#T))
(local.set $n (#N))
(local.set $l (#L))
(#set 3 -3)
(i32.store8 offset=0x10200 (local.get $t) (local.get $l))
(call $deo (local.get $t) (local.get $l))
(i32.store8 offset=0x10200 (local.tee $t (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xff))) (local.get $n))
(call $deo (local.get $t) (local.get $n))
`,
  ],
  [
    "ADD2",
    `
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -2)
(#T2! (i32.add (local.get $n) (local.get $t)))
`,
  ],
  [
    "SUB2",
    `
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -2)
(#T2! (i32.sub (local.get $n) (local.get $t)))
`,
  ],
  [
    "MUL2",
    `
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -2)
(#T2! (i32.mul (local.get $n) (local.get $t)))
`,
  ],
  [
    "DIV2",
    `
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -2)
(#T2! (if (result i32) (i32.eqz (local.get $t)) (then (i32.const 0)) (else (i32.div_u (local.get $n) (local.get $t)))))
`,
  ],
  [
    "AND2",
    `
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -2)
(#T2! (i32.and (local.get $n) (local.get $t)))
`,
  ],
  [
    "ORA2",
    `
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -2)
(#T2! (i32.or (local.get $n) (local.get $t)))
`,
  ],
  [
    "EOR2",
    `
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -2)
(#T2! (i32.xor (local.get $n) (local.get $t)))
`,
  ],
  [
    "SFT2",
    `
(local.set $t (#T))
(local.set $n (#H2))
(#set 3 -1)
(#T2! (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4))))
`,
  ],
  [
    "JMI",
    `
(local.set $pc (i32.add (i32.const 2) (i32.add (local.get $pc) (#peek16s (local.get $pc)))))
`,
  ],
  ["INCr", null],
  ["POPr", null],
  ["NIPr", null],
  ["SWPr", null],
  ["ROTr", null],
  ["DUPr", null],
  ["OVRr", null],
  ["EQUr", null],
  ["NEQr", null],
  ["GTHr", null],
  ["LTHr", null],
  ["JMPr", null],
  ["JCNr", null],
  ["JSRr", null],
  ["STHr", null],
  ["LDZr", null],
  ["STZr", null],
  ["LDRr", null],
  ["STRr", null],
  ["LDAr", null],
  ["STAr", null],
  ["DEIr", null],
  ["DEOr", null],
  ["ADDr", null],
  ["SUBr", null],
  ["MULr", null],
  ["DIVr", null],
  ["ANDr", null],
  ["ORAr", null],
  ["EORr", null],
  ["SFTr", null],
  [
    "JSI",
    `
(#set 0 2)
(#T2! (local.tee $n (i32.add (local.get $pc) (i32.const 2))))
(local.set $pc (i32.add (local.get $n) (#peek16s (local.get $pc))))
`,
  ],
  ["INC2r", null],
  ["POP2r", null],
  ["NIP2r", null],
  ["SWP2r", null],
  ["ROT2r", null],
  ["DUP2r", null],
  ["OVR2r", null],
  ["EQU2r", null],
  ["NEQ2r", null],
  ["GTH2r", null],
  ["LTH2r", null],
  ["JMP2r", null],
  ["JCN2r", null],
  ["JSR2r", null],
  ["STH2r", null],
  ["LDZ2r", null],
  ["STZ2r", null],
  ["LDR2r", null],
  ["STR2r", null],
  ["LDA2r", null],
  ["STA2r", null],
  ["DEI2r", null],
  ["DEO2r", null],
  ["ADD2r", null],
  ["SUB2r", null],
  ["MUL2r", null],
  ["DIV2r", null],
  ["AND2r", null],
  ["ORA2r", null],
  ["EOR2r", null],
  ["SFT2r", null],
  [
    "LIT",
    `
(#set 0 1)
(#T! (i32.load8_u (local.get $pc)))
(local.set $pc (i32.add (local.get $pc) (i32.const 1)))
`,
  ],
  ["INCk", null],
  ["POPk", null],
  ["NIPk", null],
  ["SWPk", null],
  ["ROTk", null],
  ["DUPk", null],
  ["OVRk", null],
  ["EQUk", null],
  ["NEQk", null],
  ["GTHk", null],
  ["LTHk", null],
  ["JMPk", null],
  ["JCNk", null],
  ["JSRk", null],
  ["STHk", null],
  ["LDZk", null],
  ["STZk", null],
  ["LDRk", null],
  ["STRk", null],
  ["LDAk", null],
  ["STAk", null],
  ["DEIk", null],
  ["DEOk", null],
  ["ADDk", null],
  ["SUBk", null],
  ["MULk", null],
  ["DIVk", null],
  ["ANDk", null],
  ["ORAk", null],
  ["EORk", null],
  ["SFTk", null],
  [
    "LIT2",
    `
(#set 0 2)
(#T2<mem! (local.get $pc))
(local.set $pc (i32.add (local.get $pc) (i32.const 2)))
`,
  ],
  ["INC2k", null],
  ["POP2k", null],
  ["NIP2k", null],
  ["SWP2k", null],
  ["ROT2k", null],
  ["DUP2k", null],
  ["OVR2k", null],
  ["EQU2k", null],
  ["NEQ2k", null],
  ["GTH2k", null],
  ["LTH2k", null],
  ["JMP2k", null],
  ["JCN2k", null],
  ["JSR2k", null],
  ["STH2k", null],
  ["LDZ2k", null],
  ["STZ2k", null],
  ["LDR2k", null],
  ["STR2k", null],
  ["LDA2k", null],
  ["STA2k", null],
  ["DEI2k", null],
  ["DEO2k", null],
  ["ADD2k", null],
  ["SUB2k", null],
  ["MUL2k", null],
  ["DIV2k", null],
  ["AND2k", null],
  ["ORA2k", null],
  ["EOR2k", null],
  ["SFT2k", null],
  ["LITr", null],
  ["INCkr", null],
  ["POPkr", null],
  ["NIPkr", null],
  ["SWPkr", null],
  ["ROTkr", null],
  ["DUPkr", null],
  ["OVRkr", null],
  ["EQUkr", null],
  ["NEQkr", null],
  ["GTHkr", null],
  ["LTHkr", null],
  ["JMPkr", null],
  ["JCNkr", null],
  ["JSRkr", null],
  ["STHkr", null],
  ["LDZkr", null],
  ["STZkr", null],
  ["LDRkr", null],
  ["STRkr", null],
  ["LDAkr", null],
  ["STAkr", null],
  ["DEIkr", null],
  ["DEOkr", null],
  ["ADDkr", null],
  ["SUBkr", null],
  ["MULkr", null],
  ["DIVkr", null],
  ["ANDkr", null],
  ["ORAkr", null],
  ["EORkr", null],
  ["SFTkr", null],
  ["LIT2r", null],
  ["INC2kr", null],
  ["POP2kr", null],
  ["NIP2kr", null],
  ["SWP2kr", null],
  ["ROT2kr", null],
  ["DUP2kr", null],
  ["OVR2kr", null],
  ["EQU2kr", null],
  ["NEQ2kr", null],
  ["GTH2kr", null],
  ["LTH2kr", null],
  ["JMP2kr", null],
  ["JCN2kr", null],
  ["JSR2kr", null],
  ["STH2kr", null],
  ["LDZ2kr", null],
  ["STZ2kr", null],
  ["LDR2kr", null],
  ["STR2kr", null],
  ["LDA2kr", null],
  ["STA2kr", null],
  ["DEI2kr", null],
  ["DEO2kr", null],
  ["ADD2kr", null],
  ["SUB2kr", null],
  ["MUL2kr", null],
  ["DIV2kr", null],
  ["AND2kr", null],
  ["ORA2kr", null],
  ["EOR2kr", null],
  ["SFT2kr", null],
];

function generate() {
  let out = `(module $uxn
  (import "system" "deo" (func $deo (param i32) (param i32)))
  (import "system" "dei" (func $dei (param i32) (result i32)))

  (func (export "eval") (param $pc i32)
    (local $wstp i32)
    (local $rstp i32)
    (local $t i32)
    (local $n i32)
    (local $l i32)
    (local $val i32)
    (local $mval i32)

    (if (i32.eqz (local.get $pc)) (then (return)))
    (if (i32.load8_u (i32.const 0x1020f)) (then (return)))

    (local.set $wstp (global.get $wstp))
    (local.set $rstp (global.get $rstp))
    (block $endLoop
      (loop $loop
        (local.set $val (i32.load8_u (local.get $pc)))
        (local.set $pc (i32.add (local.get $pc) (i32.const 1)))

        ;; Uxntal Opcodes
        ;; https://wiki.xxiivv.com/site/uxntal_opcodes.html
`;

  instructions
    .slice()
    .reverse()
    .forEach((ins, i) => {
      if (i % 16 === 0) {
        out += "\n        ";
      }
      out += `(block $${ins[0]} `.padEnd(15);
    });
  out += "\n";
  out += "        (br_table";
  instructions.forEach((ins, i) => {
    if (i % 16 === 0) {
      out += "\n          ";
    }
    out += `$${ins[0].padEnd(6, " ")} `;
  });
  out += "\n";
  out += "          $BRK\n";
  out += "          (local.get $val))\n\n";

  instructions.forEach((inss, ins) => {
    const insn = inss[0];
    const mode_keep = !!(ins & 0x80);
    const mode_rst = !!(ins & 0x40);
    out += `        );; ${insn}\n`;
    let code;
    if (inss[1] != null) {
      code = inss[1].slice(1);
    } else {
      code = instructions[ins & 0x1f ? ins & 0x3f : ins & 0xa0][1].slice(1);
    }

    const macros = [
      [
        "peek16s",
        `(i32.or (i32.shr_s (i32.shl (i32.load8_u #1) (i32.const 24)) (i32.const 16)) (i32.load8_u (i32.and (i32.add #1 (i32.const 1)) (i32.const 0xffff))))`,
      ],
      [
        "poke2",
        `(i32.store8 #1 #2) (i32.store8 (i32.and (i32.add #1 (i32.const 1)) (i32.const 0xffff)) #3)`,
      ],
      // with an expression address
      [
        "poke2e",
        `(i32.store8 (local.tee $mval (i32.and #1 (i32.const 0xffff))) #2) (i32.store8 (i32.and (i32.add (local.get $mval) (i32.const 1)) (i32.const 0xffff)) #3)`,
      ],
      // zero-page (not wrapping)
      [
        "poke2z",
        `(i32.store8 #1 #2) (i32.store8 (i32.add #1 (i32.const 1)) #3)`,
      ],
    ];
    for (const [regname, regidx] of [
      ["T", 0],
      ["N", 2],
      ["L", 4],
      ["X", 6],
      ["H", 1],
    ]) {
      let reg = regname;
      for (const flip of [false, true]) {
        const stack = mode_rst ^ flip ? "rst" : "wst";
        const offset = mode_rst ^ flip ? "0x10100" : "0x10000";
        reg = (flip ? "~" : "") + reg;
        macros.push(
          ...[
            [
              reg + "2!",
              `(i32.store8 offset=${offset} (i32.and (i32.add (local.get $${stack}p) (i32.const ${regidx})) (i32.const 0xff)) (i32.and (local.tee $val #1) (i32.const 0xff))) (i32.store8 offset=${offset} (i32.and (i32.add (local.get $${stack}p) (i32.const ${
                regidx + 1
              })) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))`,
            ],
            [
              // Copy from memory
              reg + "2<mem!",
              `(i32.store8 offset=${offset} (i32.and (i32.add (local.get $${stack}p) (i32.const ${
                regidx + 1
              })) (i32.const 0xff)) (i32.load8_u #1)) (i32.store8 offset=${offset} (i32.and (i32.add (local.get $${stack}p) (i32.const ${regidx})) (i32.const 0xff)) (i32.load8_u (i32.and (i32.add #1 (i32.const 1)) (i32.const 0xffff))))`,
            ],
            [
              // Copy from zero-page memory
              reg + "2<zmem!",
              `(i32.store8 offset=${offset} (i32.and (i32.add (local.get $${stack}p) (i32.const ${
                regidx + 1
              })) (i32.const 0xff)) (i32.load8_u #1)) (i32.store8 offset=${offset} (i32.and (i32.add (local.get $${stack}p) (i32.const ${regidx})) (i32.const 0xff)) (i32.load8_u (i32.add #1 (i32.const 1))))`,
            ],
            [
              // Copy from memory (with expression)
              reg + "2<meme!",
              `(i32.store8 offset=${offset} (i32.and (i32.add (local.get $${stack}p) (i32.const ${
                regidx + 1
              })) (i32.const 0xff)) (i32.load8_u (local.tee $mval #1))) (i32.store8 offset=${offset} (i32.and (i32.add (local.get $${stack}p) (i32.const ${regidx})) (i32.const 0xff)) (i32.load8_u (i32.and (i32.add (local.get $mval) (i32.const 1)) (i32.const 0xffff))))`,
            ],
            [
              reg + "2",
              `(i32.or (i32.load8_u offset=${offset} (i32.and (i32.add (local.get $${stack}p) (i32.const ${regidx})) (i32.const 0xff))) (i32.shl (i32.load8_u offset=${offset} (i32.and (i32.add (local.get $${stack}p) (i32.const ${
                regidx + 1
              })) (i32.const 0xff))) (i32.const 8)))`,
            ],
            ...(regidx % 2 === 0
              ? [
                  [
                    reg + "!",
                    `(i32.store8 offset=${offset} (i32.and (i32.add (local.get $${stack}p) (i32.const ${
                      regidx / 2
                    })) (i32.const 0xff)) #1)`,
                  ],
                  [
                    reg,
                    `(i32.load8_u offset=${offset} (i32.and (i32.add (local.get $${stack}p) (i32.const ${
                      regidx / 2
                    })) (i32.const 0xff)))`,
                  ],
                  [
                    reg + "s",
                    `(i32.load8_s offset=${offset} (i32.and (i32.add (local.get $${stack}p) (i32.const ${
                      regidx / 2
                    })) (i32.const 0xff)))`,
                  ],
                ]
              : []),
          ]
        );
      }
    }

    let ncode = "";
    for (let c of code.split("\n")) {
      let exprs = parseSExpressions(c);
      for (const [macro, macrodef] of macros) {
        exprs = exprs
          .map((expr) =>
            replaceMacro(expr, macro, (args) =>
              parseSExpressions(macrodef).map((expr) =>
                replaceMacroArgs(expr, args)
              )
            )
          )
          .flat();
      }
      exprs = exprs.map(simplifyExpression);
      c = dumpSExpressions(exprs);

      // TODO: Move to sexprs above
      c = c.replace(/\(#set (-?\d+) (-?\d+)\)/g, (m, m1, m2) =>
        replaceSet(m1, m2, mode_rst, mode_keep, false)
      );
      c = c.replace(/\(#~set (-?\d+) (-?\d+)\)/, (m, m1, m2) =>
        replaceSet(m1, m2, mode_rst, mode_keep, true)
      );
      ncode += c + "\n";
    }
    code = indent(ncode.trim(), 8); // fixme: rtrim
    if (code.length > 0) {
      out += code + "\n";
    }
    if (insn === "BRK") {
      out += "        (br $endLoop)\n\n";
    } else {
      out += "        (br $loop)\n\n";
    }
  });

  out =
    out.trim() +
    `))

    (global.set $wstp (local.get $wstp))
    (global.set $rstp (local.get $rstp)))

  (func $reset (export "reset")
    (global.set $wstp (i32.const 0x00))
    (global.set $rstp (i32.const 0x00))
    (memory.fill (i32.const 0x0) (i32.const 0x0) (i32.const 0x10300)))

  (func (export "wstp") (result i32) (global.get $wstp))
  (func (export "rstp") (result i32) (global.get $rstp))

  (memory (export "memory") 2)

  (global $wstp (mut i32) (i32.const 0))
  (global $rstp (mut i32) (i32.const 0)))
`;
  console.log(out.trim());
}

function indent(code, n) {
  return code
    .trim()
    .split("\n")
    .filter((l) => l)
    .map((l) => " ".repeat(n) + l)
    .join("\n");
}

function replaceSet(m1, m2, is_rst, is_keep, flip) {
  const stack = is_rst ^ flip ? "rst" : "wst";
  let delta = is_keep ? parseInt(m1) + parseInt(m2) : parseInt(m2);
  if (delta !== 0) {
    delta = -delta;
    if (delta < 0) {
      delta = 256 + delta;
    }
    return `(local.set $${stack}p (i32.and (i32.add (local.get $${stack}p) (i32.const ${delta})) (i32.const 0xff)))`;
  } else {
    return "";
  }
}

////////////////////////////////////////////////////////////////////////////////
// S-Exprs
////////////////////////////////////////////////////////////////////////////////

function parseSExpressions(input) {
  let index = 0;

  function parseAtom() {
    const start = index;
    while (index < input.length && !/\s|\)|\(/.test(input[index])) {
      index++;
    }
    return input.slice(start, index);
  }

  function parseSExpr() {
    if (input[index] === "(") {
      index++;
      const result = [];
      while (index < input.length && input[index] !== ")") {
        if (/\s/.test(input[index])) {
          index++;
        } else {
          result.push(parseSExpr());
        }
      }
      if (input >= input.length || input[index] != ")") {
        throw Error("incomplete s-expr");
      }
      index++;
      return result;
    } else {
      return parseAtom();
    }
  }

  const result = [];
  while (index < input.length) {
    if (/\s/.test(input[index])) {
      index++;
      continue;
    }
    result.push(parseSExpr());
  }
  return result;
}

function dumpSExpression(expr) {
  if (Array.isArray(expr)) {
    return "(" + expr.map(dumpSExpression).join(" ") + ")";
  } else {
    return expr;
  }
}

function dumpSExpressions(exprs) {
  return exprs.map(dumpSExpression).join("\n");
}

function replaceMacroArgs(expr, args) {
  if (Array.isArray(expr)) {
    return expr.map((e) => replaceMacroArgs(e, args));
  }
  const m = expr.match(/^#(\d+)$/);
  if (m != null) {
    return args[parseInt(m[1] - 1)];
  }
  return expr;
}

function replaceMacro(expr, macro, repl) {
  if (Array.isArray(expr)) {
    expr = expr.map((e) => replaceMacro(e, macro, repl)).flat();
    if (expr.length > 0 && expr[0] === "#" + macro) {
      return repl(expr.slice(1));
    }
    return [expr];
  }
  return [expr];
}

function isConst(expr, n) {
  return expr[0] === "i32.const" && parseInt(expr[1]) === n;
}

function isGet(expr) {
  return expr[0] === "global.get" || expr[0] === "local.get";
}

function simplifyExpression(expr) {
  if (Array.isArray(expr)) {
    expr = expr.map(simplifyExpression);
    if (expr.length > 0) {
      if (expr[0] === "i32.add" || expr[0] === "i32.sub") {
        if (isConst(expr[1], 0)) {
          return expr[2];
        } else if (isConst(expr[2], 0)) {
          return expr[1];
        }
      } else if (
        expr[0] === "i32.and" &&
        isGet(expr[1]) &&
        isConst(expr[2], 0xff)
      ) {
        return expr[1];
      }
    }
  }
  return expr;
}

////////////////////////////////////////////////////////////////////////////////

generate();
