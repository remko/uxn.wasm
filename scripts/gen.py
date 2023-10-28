#!/usr/bin/env python3

# Helper script to generate code.

import re

instructions = [
    ["BRK", """
"""],
    [
        "INC", """
(local.set $t (#T))
(#set 1 0)
(#T! (i32.add (local.get $t) (i32.const 1)))
"""
    ],
    ["POP", """
(#set 1 -1)
"""],
    ["NIP", """
(local.set $t (#T))
(#set 2 -1)
(#T! (local.get $t))
"""],
    [
        "SWP", """
(local.set $t (#T))
(local.set $n (#N))
(#set 2 0)
(#T! (local.get $n))
(#N! (local.get $t))
"""
    ],
    [
        "ROT", """
(local.set $t (#T))
(local.set $n (#N))
(local.set $l (#L))
(#set 3 0)
(#T! (local.get $l))
(#N! (local.get $t))
(#L! (local.get $n))
"""
    ],
    [
        "DUP", """
(local.set $t (#T))
(#set 1 1)
(#T! (local.get $t))
(#N! (local.get $t))
"""
    ],
    [
        "OVR", """
(local.set $t (#T))
(local.set $n (#N))
(#set 2 1)
(#T! (local.get $n))
(#N! (local.get $t))
(#L! (local.get $n))
"""
    ],
    [
        "EQU", """
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.eq (local.get $t) (local.get $n)))
"""
    ],
    [
        "NEQ", """
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.ne (local.get $t) (local.get $n)))
"""
    ],
    [
        "GTH", """
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.gt_u (local.get $n) (local.get $t)))
"""
    ],
    [
        "LTH", """
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.lt_u (local.get $n) (local.get $t)))
"""
    ],
    [
        "JMP", """
(local.set $t (#T))
(#set 1 -1)
(local.set $pc (i32.add (local.get $pc) 
    (#signed (local.get $t))
))
"""
    ],
    [
        "JCN", """
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -2)
(if (local.get $n) (then (local.set $pc (i32.add (local.get $pc) 
    (#signed (local.get $t))
))))
"""
    ],
    [
        "JSR", """
(local.set $t (#T))
(#set 1 -1)
(#~set 0 2)
(#~T2! (local.get $pc))
(local.set $pc (i32.add (local.get $pc) 
    (#signed (local.get $t))
))
"""
    ],
    [
        "STH", """
(local.set $t (#T))
(#set 1 -1)
(#~set 0 1)
(#~T! (local.get $t))
"""
    ],
    [
        "LDZ", """
(local.set $t (#T))
(#set 1 0)
(#T! (i32.load8_u (local.get $t)))
"""
    ],
    [
        "STZ", """
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -2)
(i32.store8 (local.get $t) (local.get $n))
"""
    ],
    [
        "LDR", """
(local.set $t (#T))
(#set 1 0)
(#T! (i32.load8_u (i32.add (local.get $pc) 
    (#signed (local.get $t))
)))
"""
    ],
    [
        "STR", """
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -2)
(i32.store8 (i32.add (local.get $pc) 
    (#signed (local.get $t))
) (local.get $n))
"""
    ],
    [
        "LDA", """
(local.set $t (#T2))
(#set 2 -1)
(#T! (i32.load8_u (local.get $t)))
"""
    ],
    [
        "STA", """
(local.set $t (#T2))
(local.set $n (#L))
(#set 3 -3)
(i32.store8 (local.get $t) (local.get $n))
"""
    ],
    [
        "DEI", """
(local.set $t (#T))
(#set 1 0)
(#T! (call $dei (local.get $t)))
"""
    ],
    [
        "DEO", """
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -2)
(i32.store8 (i32.add (i32.const 0x10200) (local.get $t)) (local.get $n))
(call $deo (local.get $t) (local.get $n))
"""
    ],
    [
        "ADD", """
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.add (local.get $n) (local.get $t)))
"""
    ],
    [
        "SUB", """
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.sub (local.get $n) (local.get $t)))
"""
    ],
    [
        "MUL", """
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.mul (local.get $n) (local.get $t)))
"""
    ],
    [
        "DIV", """
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.div_u (local.get $n) (local.get $t)))
"""
    ],
    [
        "AND", """
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.and (local.get $n) (local.get $t)))
"""
    ],
    [
        "ORA", """
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.or (local.get $n) (local.get $t)))
"""
    ],
    [
        "EOR", """
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.xor (local.get $n) (local.get $t)))
"""
    ],
    [
        "SFT", """
(local.set $t (#T))
(local.set $n (#N))
(#set 2 -1)
(#T! (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4))))
"""
    ],
    [
        "JCI", """
(local.set $t (#T))
(#set 0 -1)
(if (local.get $t) 
    (then 
        (local.set $pc (i32.add (i32.const 2) (i32.add (local.get $pc) 
            (#signed2 (call $swap (i32.load16_u (local.get $pc))))
        ))))
    (else 
        (local.set $pc (i32.add (local.get $pc) (i32.const 2)))))
"""
    ],
    [
        "INC2", """
(local.set $t (#T2))
(#set 2 0)
(#T2! (i32.add (local.get $t) (i32.const 1)))
"""
    ],
    ["POP2", """
(#set 2 -2)
"""],
    ["NIP2", """
(local.set $t (#T2))
(#set 4 -2)
(#T2! (local.get $t))
"""],
    [
        "SWP2", """
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 0)
(#T2! (local.get $n))
(#N2! (local.get $t))
"""
    ],
    [
        "ROT2", """
(local.set $t (#T2))
(local.set $n (#N2))
(local.set $l (#L2))
(#set 6 0)
(#T2! (local.get $l))
(#N2! (local.get $t))
(#L2! (local.get $n))
"""
    ],
    [
        "DUP2", """
(local.set $t (#T2))
(#set 2 2)
(#T2! (local.get $t))
(#N2! (local.get $t))
"""
    ],
    [
        "OVR2", """
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 2)
(#T2! (local.get $n))
(#N2! (local.get $t))
(#L2! (local.get $n))
"""
    ],
    [
        "EQU2", """
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -3)
(#T! (i32.eq (local.get $t) (local.get $n)))
"""
    ],
    [
        "NEQ2", """
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -3)
(#T! (i32.ne (local.get $t) (local.get $n)))
"""
    ],
    [
        "GTH2", """
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -3)
(#T! (i32.gt_u (local.get $n) (local.get $t)))
"""
    ],
    [
        "LTH2", """
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -3)
(#T! (i32.lt_u (local.get $n) (local.get $t)))
"""
    ],
    [
        "JMP2", """
(local.set $t (#T2))
(#set 2 -2)
(local.set $pc (local.get $t))
"""
    ],
    [
        "JCN2", """
(local.set $t (#T2))
(local.set $n (#L))
(#set 3 -3)
(if (local.get $n) (then (local.set $pc (local.get $t))))
"""
    ],
    [
        "JSR2", """
(local.set $t (#T2))
(#set 2 -2)
(#~set 0 2)
(#~T2! (local.get $pc))
(local.set $pc (local.get $t))
"""
    ],
    [
        "STH2", """
(local.set $t (#T2))
(#set 2 -2)
(#~set 0 2)
(#~T2! (local.get $t))
"""
    ],
    [
        "LDZ2", """
(local.set $t (#T))
(#set 1 1)
(#T2! (call $swap (i32.load16_u (local.get $t))))
"""
    ],
    [
        "STZ2", """
(local.set $t (#T))
(local.set $n (#H2))
(#set 3 -3)
(i32.store16 (local.get $t) (call $swap (local.get $n)))
"""
    ],
    [
        "LDR2", """
(local.set $t (#T))
(#set 1 1)
(#T2! (call $swap (i32.load16_u (i32.add (local.get $pc) 
    (#signed (local.get $t))
))))
"""
    ],
    [
        "STR2", """
(local.set $t (#T))
(local.set $n (#H2))
(#set 3 -3)
(i32.store16 (i32.add (local.get $pc) 
    (#signed (local.get $t))
) (call $swap (local.get $n)))
"""
    ],
    [
        "LDA2", """
(local.set $t (#T2))
(#set 2 0)
(#T2! (call $swap (i32.load16_u (local.get $t))))
"""
    ],
    [
        "STA2", """
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -4)
(i32.store16 (local.get $t) (call $swap (local.get $n)))
"""
    ],
    [
        "DEI2", """
(local.set $t (#T))
(#set 1 1)
(#T! (call $dei (i32.add (local.get $t) (i32.const 1))))
(#N! (call $dei (local.get $t)))
"""
    ],
    [
        "DEO2", """
(local.set $t (#T))
(local.set $n (#N))
(local.set $l (#L))
(#set 3 -3)
(i32.store8 (i32.add (i32.const 0x10200) (local.get $t)) (local.get $l))
(call $deo (local.get $t) (local.get $l))
(i32.store8 (i32.add (i32.const 0x10201) (local.get $t)) (local.get $n))
(call $deo (i32.add (local.get $t) (i32.const 1)) (local.get $n))
"""
    ],
    [
        "ADD2", """
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -2)
(#T2! (i32.add (local.get $n) (local.get $t)))
"""
    ],
    [
        "SUB2", """
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -2)
(#T2! (i32.sub (local.get $n) (local.get $t)))
"""
    ],
    [
        "MUL2", """
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -2)
(#T2! (i32.mul (local.get $n) (local.get $t)))
"""
    ],
    [
        "DIV2", """
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -2)
(#T2! (i32.div_u (local.get $n) (local.get $t)))
"""
    ],
    [
        "AND2", """
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -2)
(#T2! (i32.and (local.get $n) (local.get $t)))
"""
    ],
    [
        "ORA2", """
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -2)
(#T2! (i32.or (local.get $n) (local.get $t)))
"""
    ],
    [
        "EOR2", """
(local.set $t (#T2))
(local.set $n (#N2))
(#set 4 -2)
(#T2! (i32.xor (local.get $n) (local.get $t)))
"""
    ],
    [
        "SFT2", """
(local.set $t (#T))
(local.set $n (#H2))
(#set 3 -1)
(#T2! (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4))))
"""
    ],
    [
        "JMI", """
(local.set $pc (i32.add (i32.const 2) (i32.add (local.get $pc) 
    (#signed2 (call $swap (i32.load16_u (local.get $pc))))
)))
"""
    ],
    ["INCr", None],
    ["POPr", None],
    ["NIPr", None],
    ["SWPr", None],
    ["ROTr", None],
    ["DUPr", None],
    ["OVRr", None],
    ["EQUr", None],
    ["NEQr", None],
    ["GTHr", None],
    ["LTHr", None],
    ["JMPr", None],
    ["JCNr", None],
    ["JSRr", None],
    ["STHr", None],
    ["LDZr", None],
    ["STZr", None],
    ["LDRr", None],
    ["STRr", None],
    ["LDAr", None],
    ["STAr", None],
    ["DEIr", None],
    ["DEOr", None],
    ["ADDr", None],
    ["SUBr", None],
    ["MULr", None],
    ["DIVr", None],
    ["ANDr", None],
    ["ORAr", None],
    ["EORr", None],
    ["SFTr", None],
    [
        "JSI", """
(#set 0 2)
(#T2! (local.tee $n (i32.add (local.get $pc) (i32.const 2))))
(local.set $pc (i32.add (local.get $n) 
    (#signed2 (call $swap (i32.load16_u (local.get $pc))))
))
"""
    ],
    ["INC2r", None],
    ["POP2r", None],
    ["NIP2r", None],
    ["SWP2r", None],
    ["ROT2r", None],
    ["DUP2r", None],
    ["OVR2r", None],
    ["EQU2r", None],
    ["NEQ2r", None],
    ["GTH2r", None],
    ["LTH2r", None],
    ["JMP2r", None],
    ["JCN2r", None],
    ["JSR2r", None],
    ["STH2r", None],
    ["LDZ2r", None],
    ["STZ2r", None],
    ["LDR2r", None],
    ["STR2r", None],
    ["LDA2r", None],
    ["STA2r", None],
    ["DEI2r", None],
    ["DEO2r", None],
    ["ADD2r", None],
    ["SUB2r", None],
    ["MUL2r", None],
    ["DIV2r", None],
    ["AND2r", None],
    ["ORA2r", None],
    ["EOR2r", None],
    ["SFT2r", None],
    [
        "LIT", """
(#set 0 1)
(#T! (i32.load8_u (local.get $pc)))
(local.set $pc (i32.add (local.get $pc) (i32.const 1)))
"""
    ],
    ["INCk", None],
    ["POPk", None],
    ["NIPk", None],
    ["SWPk", None],
    ["ROTk", None],
    ["DUPk", None],
    ["OVRk", None],
    ["EQUk", None],
    ["NEQk", None],
    ["GTHk", None],
    ["LTHk", None],
    ["JMPk", None],
    ["JCNk", None],
    ["JSRk", None],
    ["STHk", None],
    ["LDZk", None],
    ["STZk", None],
    ["LDRk", None],
    ["STRk", None],
    ["LDAk", None],
    ["STAk", None],
    ["DEIk", None],
    ["DEOk", None],
    ["ADDk", None],
    ["SUBk", None],
    ["MULk", None],
    ["DIVk", None],
    ["ANDk", None],
    ["ORAk", None],
    ["EORk", None],
    ["SFTk", None],
    [
        "LIT2", """
(#set 0 2)
(#T2! (call $swap (i32.load16_u (local.get $pc))))
(local.set $pc (i32.add (local.get $pc) (i32.const 2)))
"""
    ],
    ["INC2k", None],
    ["POP2k", None],
    ["NIP2k", None],
    ["SWP2k", None],
    ["ROT2k", None],
    ["DUP2k", None],
    ["OVR2k", None],
    ["EQU2k", None],
    ["NEQ2k", None],
    ["GTH2k", None],
    ["LTH2k", None],
    ["JMP2k", None],
    ["JCN2k", None],
    ["JSR2k", None],
    ["STH2k", None],
    ["LDZ2k", None],
    ["STZ2k", None],
    ["LDR2k", None],
    ["STR2k", None],
    ["LDA2k", None],
    ["STA2k", None],
    ["DEI2k", None],
    ["DEO2k", None],
    ["ADD2k", None],
    ["SUB2k", None],
    ["MUL2k", None],
    ["DIV2k", None],
    ["AND2k", None],
    ["ORA2k", None],
    ["EOR2k", None],
    ["SFT2k", None],
    ["LITr", None],
    ["INCkr", None],
    ["POPkr", None],
    ["NIPkr", None],
    ["SWPkr", None],
    ["ROTkr", None],
    ["DUPkr", None],
    ["OVRkr", None],
    ["EQUkr", None],
    ["NEQkr", None],
    ["GTHkr", None],
    ["LTHkr", None],
    ["JMPkr", None],
    ["JCNkr", None],
    ["JSRkr", None],
    ["STHkr", None],
    ["LDZkr", None],
    ["STZkr", None],
    ["LDRkr", None],
    ["STRkr", None],
    ["LDAkr", None],
    ["STAkr", None],
    ["DEIkr", None],
    ["DEOkr", None],
    ["ADDkr", None],
    ["SUBkr", None],
    ["MULkr", None],
    ["DIVkr", None],
    ["ANDkr", None],
    ["ORAkr", None],
    ["EORkr", None],
    ["SFTkr", None],
    ["LIT2r", None],
    ["INC2kr", None],
    ["POP2kr", None],
    ["NIP2kr", None],
    ["SWP2kr", None],
    ["ROT2kr", None],
    ["DUP2kr", None],
    ["OVR2kr", None],
    ["EQU2kr", None],
    ["NEQ2kr", None],
    ["GTH2kr", None],
    ["LTH2kr", None],
    ["JMP2kr", None],
    ["JCN2kr", None],
    ["JSR2kr", None],
    ["STH2kr", None],
    ["LDZ2kr", None],
    ["STZ2kr", None],
    ["LDR2kr", None],
    ["STR2kr", None],
    ["LDA2kr", None],
    ["STA2kr", None],
    ["DEI2kr", None],
    ["DEO2kr", None],
    ["ADD2kr", None],
    ["SUB2kr", None],
    ["MUL2kr", None],
    ["DIV2kr", None],
    ["AND2kr", None],
    ["ORA2kr", None],
    ["EOR2kr", None],
    ["SFT2kr", None],
]


def indent(code, n):
    return "\n".join([(n * " ") + c for c in code.strip().split("\n")
                      if len(c) > 0])


def replace_set(m, is_rst, is_keep, flip):
    stack = "rst" if (mode_rst ^ flip) else "wst"
    delta = int(m.group(1)) + int(m.group(2)) if is_keep else int(m.group(2))
    if delta != 0:
        return "(global.set $%sp (i32.sub (global.get $%sp) (i32.const %d)))" % (
            stack, stack, delta)
    else:
        return ""


out = """(module $uxn
  (import "system" "deo" (func $deo (param i32) (param i32)))
  (import "system" "dei" (func $dei (param i32) (result i32)))

  (memory (export "memory") 2)

  (func (export "eval") (param $pc i32)
    (local $ins i32)
    (local $t i32)
    (local $n i32)
    (local $l i32)
    (if (i32.eqz (local.get $pc)) (then (return)))
    (if (i32.load8_u (i32.const 0x1020f)) (then (return)))
    (block $endLoop
      (loop $loop
        (local.set $ins (i32.load8_u (local.get $pc)))
        (local.set $pc (i32.add (local.get $pc) (i32.const 1)))

        ;; Uxntal Opcodes
        ;; https://wiki.xxiivv.com/site/uxntal_opcodes.html
"""

for i, ins in enumerate(reversed(instructions)):
    if i % 16 == 0:
        out += "\n        "
    out += "(block $%s " % ins[0]
out += "\n"
out += "        (br_table"
for i, ins in enumerate(instructions):
    if i % 16 == 0:
        out += "\n          "
    out += "$%-6s " % ins[0]
out += "\n"
out += "          $BRK\n"
out += "          (local.get $ins))\n\n"

for ins, inss in enumerate(instructions):
    insn = inss[0]
    mode_keep = bool(ins & 0x80)
    mode_rst = bool(ins & 0x40)
    out += "        );; %s\n" % insn
    if inss[1] is not None:
        code = inss[1][1:]
    else:
        code = instructions[(ins & 0x3f) if (ins & 0x1f) else
                            (ins & 0xa0)][1][1:]
    stack = "rst" if mode_rst else "wst"
    flipstack = "wst" if mode_rst else "rst"
    ncode = ""
    for c in code.split("\n"):
        c = re.sub(r"\(#T2! (.*)\)\s*$",
                   r"(i32.store16 (global.get $%sp) \1)" % stack, c)
        c = c.replace("(#T2)", "(i32.load16_u (global.get $%sp))" % stack)
        c = re.sub(r"\(#T! (.*)\)\s*$",
                   r"(i32.store8 (global.get $%sp) \1)" % stack, c)
        c = c.replace("(#T)", "(i32.load8_u (global.get $%sp))" % stack)
        c = re.sub(r"\(#~T2! (.*)\)\s*$",
                   r"(i32.store16 (global.get $%sp) \1)" % flipstack, c)
        c = re.sub(r"\(#~T! (.*)\)\s*$",
                   r"(i32.store8 (global.get $%sp) \1)" % flipstack, c)

        c = re.sub(
            r"\(#N2! (.*)\)\s*$",
            r"(i32.store16 (i32.add (global.get $%sp) (i32.const 2)) \1)" %
            stack, c)
        c = c.replace(
            "(#N2)",
            "(i32.load16_u (i32.add (global.get $%sp) (i32.const 2)))" % stack)
        c = re.sub(
            r"\(#N! (.*)\)\s*$",
            r"(i32.store8 (i32.add (global.get $%sp) (i32.const 1)) \1)" %
            stack, c)
        c = c.replace(
            "(#N)",
            "(i32.load8_u (i32.add (global.get $%sp) (i32.const 1)))" % stack)

        c = re.sub(
            r"\(#L2! (.*)\)\s*$",
            r"(i32.store16 (i32.add (global.get $%sp) (i32.const 4)) \1)" %
            stack, c)
        c = c.replace(
            "(#L2)",
            "(i32.load16_u (i32.add (global.get $%sp) (i32.const 4)))" % stack)
        c = re.sub(
            r"\(#L! (.*)\)\s*$",
            r"(i32.store8 (i32.add (global.get $%sp) (i32.const 2)) \1)" %
            stack, c)
        c = c.replace(
            "(#L)",
            "(i32.load8_u (i32.add (global.get $%sp) (i32.const 2)))" % stack)

        c = c.replace(
            "(#H2)",
            "(i32.load16_u (i32.add (global.get $%sp) (i32.const 1)))" % stack)

        c = re.sub(r"\(#set (\-?\d+) (-?\d+)\)",
                   lambda m: replace_set(m, mode_rst, mode_keep, False), c)
        c = re.sub(r"\(#~set (\-?\d+) (-?\d+)\)",
                   lambda m: replace_set(m, mode_rst, mode_keep, True), c)

        c = re.sub(r"\(#signed2 (.*)\)\s*$",
                   r"(i32.shr_s (i32.shl \1 (i32.const 16)) (i32.const 16))",
                   c)
        c = re.sub(r"\(#signed (.*)\)\s*$",
                   r"(i32.shr_s (i32.shl \1 (i32.const 24)) (i32.const 24))",
                   c)
        ncode += c + "\n"
    code = indent(ncode.rstrip(), 8)
    if len(code) > 0:
        out += code + "\n"
    if insn == "BRK":
        out += "        (br $endLoop)\n\n"
    else:
        out += "        (br $loop)\n\n"

out += """        )));; end

  (func $swap (param $v i32) (result i32)
    (i32.or
      (i32.shl (i32.and (local.get $v) (i32.const 0xff)) (i32.const 8))
      (i32.shr_u (i32.and (local.get $v) (i32.const 0xff00)) (i32.const 8))))

  (global $wstp (mut i32) (i32.const 0x100ff))
  (global $rstp (mut i32) (i32.const 0x101ff))

  (func (export "wstp") (result i32) (global.get $wstp))
  (func (export "rstp") (result i32) (global.get $rstp))
)
"""
print(out)
