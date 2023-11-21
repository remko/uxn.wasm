/* eslint no-unused-vars:0 */

import { Uxn } from "../uxn";
import { expect } from "chai";
import testsTAL from "./tests.tal";
import opctestTAL from "./opctest.tal";
import {
  asm as asm_,
  decodeUlz as decodeUlz_,
  encodeUlz as encodeUlz_,
} from "../util/index.js";

function asm(v) {
  return Array.from(asm_(v));
}

function decodeUlz(v) {
  return Array.from(decodeUlz_(v));
}

function encodeUlz(v) {
  return Array.from(encodeUlz_(v));
}

const [
  BRK,
  INC,
  POP,
  NIP,
  SWP,
  ROT,
  DUP,
  OVR,
  EQU,
  NEQ,
  GTH,
  LTH,
  JMP,
  JCN,
  JSR,
  STH,
  LDZ,
  STZ,
  LDR,
  STR,
  LDA,
  STA,
  DEI,
  DEO,
  ADD,
  SUB,
  MUL,
  DIV,
  AND,
  ORA,
  EOR,
  SFT,
  JCI,
  INC2,
  POP2,
  NIP2,
  SWP2,
  ROT2,
  DUP2,
  OVR2,
  EQU2,
  NEQ2,
  GTH2,
  LTH2,
  JMP2,
  JCN2,
  JSR2,
  STH2,
  LDZ2,
  STZ2,
  LDR2,
  STR2,
  LDA2,
  STA2,
  DEI2,
  DEO2,
  ADD2,
  SUB2,
  MUL2,
  DIV2,
  AND2,
  ORA2,
  EOR2,
  SFT2,
  JMI,
  INCr,
  POPr,
  NIPr,
  SWPr,
  ROTr,
  DUPr,
  OVRr,
  EQUr,
  NEQr,
  GTHr,
  LTHr,
  JMPr,
  JCNr,
  JSRr,
  STHr,
  LDZr,
  STZr,
  LDRr,
  STRr,
  LDAr,
  STAr,
  DEIr,
  DEOr,
  ADDr,
  SUBr,
  MULr,
  DIVr,
  ANDr,
  ORAr,
  EORr,
  SFTr,
  JSI,
  INC2r,
  POP2r,
  NIP2r,
  SWP2r,
  ROT2r,
  DUP2r,
  OVR2r,
  EQU2r,
  NEQ2r,
  GTH2r,
  LTH2r,
  JMP2r,
  JCN2r,
  JSR2r,
  STH2r,
  LDZ2r,
  STZ2r,
  LDR2r,
  STR2r,
  LDA2r,
  STA2r,
  DEI2r,
  DEO2r,
  ADD2r,
  SUB2r,
  MUL2r,
  DIV2r,
  AND2r,
  ORA2r,
  EOR2r,
  SFT2r,
  LIT,
  INCk,
  POPk,
  NIPk,
  SWPk,
  ROTk,
  DUPk,
  OVRk,
  EQUk,
  NEQk,
  GTHk,
  LTHk,
  JMPk,
  JCNk,
  JSRk,
  STHk,
  LDZk,
  STZk,
  LDRk,
  STRk,
  LDAk,
  STAk,
  DEIk,
  DEOk,
  ADDk,
  SUBk,
  MULk,
  DIVk,
  ANDk,
  ORAk,
  EORk,
  SFTk,
  LIT2,
  INC2k,
  POP2k,
  NIP2k,
  SWP2k,
  ROT2k,
  DUP2k,
  OVR2k,
  EQU2k,
  NEQ2k,
  GTH2k,
  LTH2k,
  JMP2k,
  JCN2k,
  JSR2k,
  STH2k,
  LDZ2k,
  STZ2k,
  LDR2k,
  STR2k,
  LDA2k,
  STA2k,
  DEI2k,
  DEO2k,
  ADD2k,
  SUB2k,
  MUL2k,
  DIV2k,
  AND2k,
  ORA2k,
  EOR2k,
  SFT2k,
  LITr,
  INCkr,
  POPkr,
  NIPkr,
  SWPkr,
  ROTkr,
  DUPkr,
  OVRkr,
  EQUkr,
  NEQkr,
  GTHkr,
  LTHkr,
  JMPkr,
  JCNkr,
  JSRkr,
  STHkr,
  LDZkr,
  STZkr,
  LDRkr,
  STRkr,
  LDAkr,
  STAkr,
  DEIkr,
  DEOkr,
  ADDkr,
  SUBkr,
  MULkr,
  DIVkr,
  ANDkr,
  ORAkr,
  EORkr,
  SFTkr,
  LIT2r,
  INC2kr,
  POP2kr,
  NIP2kr,
  SWP2kr,
  ROT2kr,
  DUP2kr,
  OVR2kr,
  EQU2kr,
  NEQ2kr,
  GTH2kr,
  LTH2kr,
  JMP2kr,
  JCN2kr,
  JSR2kr,
  STH2kr,
  LDZ2kr,
  STZ2kr,
  LDR2kr,
  STR2kr,
  LDA2kr,
  STA2kr,
  DEI2kr,
  DEO2kr,
  ADD2kr,
  SUB2kr,
  MUL2kr,
  DIV2kr,
  AND2kr,
  ORA2kr,
  EOR2kr,
  SFT2kr,
] = Array(0x100).keys();

const PROGRAM_OFFSET = 0x100;

function loadTests() {
  describe("uxn.wasm", () => {
    let uxn, rstd;
    let deos;
    let deo;

    function wst() {
      const result = [];
      for (let i = 0; i < uxn.wst.ptr(); i += 1) {
        result.push(uxn.wst.get(i));
      }
      return result;
    }

    function rst() {
      const result = [];
      for (let i = 0; i < uxn.rst.ptr(); i += 1) {
        result.push(uxn.rst.get(i));
      }
      return result;
    }

    beforeEach(async () => {
      deos = [];
      deo = (port, value) => {
        deos.push([port, value]);
      };

      uxn = new Uxn();
      await uxn.init({
        deo: (port, value) => {
          deo(port, value);
        },
        dei(port) {
          return uxn.dev[port];
        },
      });
    });

    describe("core", () => {
      describe("stack", () => {
        it("should support the full range", () => {
          uxn.load(Array.from({ length: 256 }, (_, i) => [LIT, i]).flat());
          uxn.eval(PROGRAM_OFFSET);
          expect(uxn.wst.get(255)).to.eql(255);
        });
      });

      ////////////////////////////////////////////////////////////////////////////////
      // Basic instructions to get the test suite started
      ////////////////////////////////////////////////////////////////////////////////

      describe("LIT", () => {
        it("should work", () => {
          uxn.load([LIT, 0x12, LIT, 0x13]);
          uxn.eval(PROGRAM_OFFSET);
          expect(wst()).to.eql([0x12, 0x13]);
        });

        it("should wrap stack around", () => {
          uxn.load(Array.from({ length: 257 }, () => [LIT, 0x24]).flat());
          uxn.eval(PROGRAM_OFFSET);
          expect(wst()).to.eql([0x24]);
        });
      });

      describe("EQU", () => {
        it("should work for equal values", () => {
          uxn.load([LIT, 0x12, LIT, 0x12, EQU]);
          uxn.eval(PROGRAM_OFFSET);
          expect(wst()).to.eql([0x1]);
        });

        it("should work for inequal values", () => {
          uxn.load([LIT, 0x12, LIT, 0x13, EQU]);
          uxn.eval(PROGRAM_OFFSET);
          expect(wst()).to.eql([0x0]);
        });
      });

      describe("EQU2", () => {
        it("should work for equal values", () => {
          uxn.load([LIT2, 0x12, 0x13, LIT2, 0x12, 0x13, EQU2]);
          uxn.eval(PROGRAM_OFFSET);
          expect(wst()).to.eql([0x1]);
        });

        it("should work for inequal values", () => {
          uxn.load([LIT2, 0x12, 0x13, LIT2, 0x13, 0x13, EQU2]);
          uxn.eval(PROGRAM_OFFSET);
          expect(wst()).to.eql([0x0]);
        });

        it("should work for unaligned values", () => {
          uxn.load([LIT, 0x11, LIT2, 0x12, 0x13, LIT2, 0x12, 0x13, EQU2]);
          uxn.eval(PROGRAM_OFFSET);
          expect(wst()).to.eql([0x11, 0x1]);
        });
      });

      describe("ADD", () => {
        it("should work", () => {
          uxn.load([LIT, 0x12, LIT, 0x13, ADD]);
          uxn.eval(PROGRAM_OFFSET);
          expect(wst()).to.eql([0x25]);
        });
      });

      describe("ADD", () => {
        it("should work with wrapped stacks", () => {
          uxn.load([POP, LIT, 0x12, LIT, 0x13, ADD, DUP]);
          uxn.eval(PROGRAM_OFFSET);
          expect(wst()).to.eql([0x25]);
        });
      });

      describe("POP", () => {
        it("should wrap stack around", () => {
          uxn.load(
            Array.from({ length: 255 }, () => [LITr, 0x24])
              .flat()
              .concat([POP, POP, LIT, 0x12, LIT, 0x12])
          );
          uxn.ram[0xffff] = 0x23;
          uxn.eval(PROGRAM_OFFSET);
          expect(wst()).to.eql([]);
          expect(uxn.ram[0xffff]).to.eql(0x23);
          expect(rst()).to.eql(Array.from({ length: 255 }, () => 0x24));
        });
      });

      ////////////////////////////////////////////////////////////////////////////////
      // Extra instruction tests
      ////////////////////////////////////////////////////////////////////////////////

      describe("JMP", () => {
        it("should support negative jumps", () => {
          uxn.load([
            LIT,
            10,
            LIT,
            0x05,
            JMP,

            LIT,
            12,
            LIT,
            0x05,
            JMP,

            LIT,
            11,
            LIT,
            0xf6,
            JMP,
            LIT,
            13,
          ]);
          uxn.eval(PROGRAM_OFFSET);
          expect(wst()).to.eql([10, 11, 12, 13]);
        });
      });

      describe("ADD2", () => {
        it("should work", () => {
          uxn.load([LIT, 0x01, LIT, 0x02, LIT, 0x01, LIT, 0x02, ADD2]);
          uxn.eval(PROGRAM_OFFSET);
          expect(wst()).to.eql([0x02, 0x04]);
        });
      });

      describe("LDR2", () => {
        it("should work", () => {
          uxn.load([LIT, 0x03, LDR2, BRK, 0x13, 0x14, 0x15, 0x16]);
          uxn.eval(PROGRAM_OFFSET);
          expect(wst()).to.eql([0x15, 0x16]);
        });
      });

      describe("LDZ2", () => {
        it("should work", () => {
          uxn.load([LIT, 0x10, LDZ2]);
          uxn.ram[0x10] = 0xab;
          uxn.ram[0x11] = 0xcd;
          uxn.eval(PROGRAM_OFFSET);
          expect(wst()).to.eql([0xab, 0xcd]);
        });

        it("should wrap around zero page", () => {
          uxn.load([LIT, 0xff, LDZ2]);
          uxn.ram[0xff] = 0xab;
          uxn.ram[0x00] = 0xcd;
          uxn.eval(PROGRAM_OFFSET);
          expect(wst()).to.eql([0xab, 0xcd]);
        });
      });

      ////////////////////////////////////////////////////////////////////////////////

      describe("uxn instruction test suite", () => {
        it("should pass", () => {
          let output = [];
          let complete = false;
          deo = (port, value) => {
            if (port == 0x18) {
              output.push(value);
            } else if (port == 0x0f) {
              complete = true;
            }
          };
          uxn.load(testsTAL);
          uxn.eval(PROGRAM_OFFSET);

          const result = new TextDecoder().decode(Uint8Array.from(output));
          const succeeded = (result.match(/1/g) || "").length;
          const failed = (result.match(/0/g) || "").length;

          const msg = `${failed}/${
            succeeded + failed
          } tests failed. Results:\n${result}`;
          expect(complete).to.eql(true, msg);
          expect(failed).to.eql(0, msg);
        });
      });

      ////////////////////////////////////////////////////////////////////////////////

      describe("opctest.tal", () => {
        it("should pass", () => {
          let output = [];
          let complete = false;
          deo = (port, value) => {
            if (port == 0x18) {
              output.push(value);
            } else if (port == 0x0f) {
              complete = true;
            }
          };
          uxn.load(opctestTAL);
          uxn.eval(PROGRAM_OFFSET);

          const result = new TextDecoder().decode(Uint8Array.from(output));
          const succeeded = (result.match(/Ok/g) || "").length;
          const failed = (result.match(/failed/g) || "").length;

          const msg = `${failed}/${
            succeeded + failed
          } tests failed. Results:\n${result}`;
          expect(complete).to.eql(true, msg);
          expect(succeeded).to.be.greaterThan(0);
          expect(failed).to.eql(0, msg);
        });
      });
    });

    ////////////////////////////////////////////////////////////////////////////////

    describe("Uxn", () => {
      describe("init", () => {
        it("should initialize the state", () => {
          expect(wst()).to.eql([]);
          expect(rst()).to.eql([]);
        });
      });

      describe("load", () => {
        it("should reset the state", () => {
          uxn.load([LIT, 2, LIT, 1, STZ]);
          uxn.eval(PROGRAM_OFFSET);
          expect(uxn.ram[1]).to.eql(2);

          uxn.load([LIT, 20]);

          expect(wst()).to.eql([]);
          expect(rst()).to.eql([]);
          expect(uxn.ram[1]).to.eql(0);
        });
      });

      describe("eval", () => {
        it("should return on system error code", () => {
          uxn.load([LIT, 10]);
          uxn.dev[0xf] = 0x1;
          uxn.eval(PROGRAM_OFFSET);
          expect(wst()).to.eql([]);
        });
      });
    });

    ////////////////////////////////////////////////////////////////////////////////

    describe("asm", () => {
      it("should compile a byte literal", () => {
        const result = asm(`#12 #13`);
        expect(result).to.eql([LIT, 0x12, LIT, 0x13]);
      });

      it("should compile a short literal", () => {
        expect(asm(`#1213`)).to.eql([LIT2, 0x12, 0x13]);
      });

      it("should compile raw ascii", () => {
        expect(asm(`"abc😀d`)).to.eql([
          0x61, 0x62, 0x63, 0xf0, 0x9f, 0x98, 0x80, 0x64,
        ]);
      });

      it("should read relative padding", () => {
        const result = asm("$10 #20");
        expect(result).to.eql([
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          LIT,
          0x20,
        ]);
      });

      it("should read absolute padding", () => {
        const result = asm("|0110 #10");
        expect(result).to.eql([
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          0x00,
          LIT,
          0x10,
        ]);
      });

      it("should not write to low offsets", () => {
        expect(() => asm("|0000 #10")).to.throw();
      });

      it("should support literal relative addressing", () => {
        const result = asm(`
      |0095 @foo $02 &bar $03 &baz
      |0100 ,foo ,foo/bar ,foo/baz ,bam ,bam/boo
      |0110 @bam $03 &boo
      `);
        expect(result).to.eql([
          LIT,
          0x92,
          LIT,
          0x92,
          LIT,
          0x93,
          LIT,
          0x07,
          LIT,
          0x08,
        ]);
      });

      it("should support raw relative addressing", () => {
        const result = asm(`
      |0095 @foo $02 &bar $03 &baz
      |0100 _foo _foo/bar _foo/baz _bam _bam/boo
      |0110 @bam $03 &boo
      `);
        expect(result).to.eql([0x93, 0x94, 0x96, 0x0b, 0x0d]);
      });

      it("should support literal zero-page addressing", () => {
        const result = asm(`
|0010 @foo $02 &bar $03 &baz
|0100 .foo .foo/bar .foo/baz .bam .bam/boo
|2000 @bam $03 &boo`);
        expect(result).to.eql([
          LIT,
          0x10,
          LIT,
          0x12,
          LIT,
          0x15,
          LIT,
          0x00,
          LIT,
          0x03,
        ]);
      });

      it("should support raw zero-page addressing", () => {
        const result = asm(`
|0010 @foo $02 &bar $03 &baz
|0100 -foo -foo/bar -foo/baz -bam -bam/boo
|2000 @bam $03 &boo`);
        expect(result).to.eql([0x10, 0x12, 0x15, 0x00, 0x03]);
      });

      it("should support literal absolute addressing", () => {
        const result = asm(`
|0010 @foo $02 &bar $03 &baz
|0100 ;foo ;foo/bar ;foo/baz ;bam ;bam/boo
|2000 @bam $03 &boo`);
        expect(result).to.eql([
          0xa0, 0x00, 0x10, 0xa0, 0x00, 0x12, 0xa0, 0x00, 0x15, 0xa0, 0x20,
          0x00, 0xa0, 0x20, 0x03,
        ]);
      });

      it("should support raw absolute addressing", () => {
        const result = asm(`
|0010 @foo $02 &bar $03 &baz
|0100 =foo =foo/bar =foo/baz =bam =bam/boo
|2000 @bam $03 &boo`);
        expect(result).to.eql([
          0x00, 0x10, 0x00, 0x12, 0x00, 0x15, 0x20, 0x00, 0x20, 0x03,
        ]);
      });

      it("should support jmi", () => {
        const result = asm(`
|0100 !foo/bar
|2000 @foo $03 &bar`);
        expect(result).to.eql([JMI, 0x1f, 0x00]);
      });

      it("should support jci", () => {
        const result = asm(`
|0100 ?foo/bar
|2000 @foo $03 &bar`);
        expect(result).to.eql([JCI, 0x1f, 0x00]);
      });

      it("should support subroutine", () => {
        const result = asm(`
|0100 foo/bar
|2000 @foo $03 &bar`);
        expect(result).to.eql([JSI, 0x1f, 0x00]);
      });

      it("should support opcodes", () => {
        const result = asm(`
|0100 LIT LIT2 LITr LIT2r ADD ADD2 ADDr ADD2r ADDk ADD2k ADDkr ADD2kr
`);
        expect(result).to.eql([
          LIT,
          LIT2,
          LITr,
          LIT2r,
          ADD,
          ADD2,
          ADDr,
          ADD2r,
          ADDk,
          ADD2k,
          ADDkr,
          ADD2kr,
        ]);
      });

      it("should support lambdas", () => {
        const result = asm(`
#12 #34 { ADD JMP2r } STH2r JSR2
`);
        expect(result).to.eql([
          LIT,
          0x12,
          LIT,
          0x34,
          JSI,
          0x00,
          0x02,
          ADD,
          JMP2r,
          STH2r,
          JSR2,
        ]);
      });

      it("should support conditional lambdas", () => {
        const result = asm(`
#12 #34 ?{ ADD JMP2r } STH2r JSR2
`);
        expect(result).to.eql([
          LIT,
          0x12,
          LIT,
          0x34,
          JCI,
          0x00,
          0x02,
          ADD,
          JMP2r,
          STH2r,
          JSR2,
        ]);
      });

      it("should support macros", () => {
        const result = asm(`
%ADDDD { ADD ADD }
#12 #34 ADDDD #56
`);
        expect(result).to.eql([LIT, 0x12, LIT, 0x34, ADD, ADD, LIT, 0x56]);
      });

      it("should support numbers", () => {
        const result = asm(`10 11 1213`);
        expect(result).to.eql([0x10, 0x11, 0x12, 0x13]);
      });

      it("should ignore blocks", () => {
        const result = asm("[ [ #10 ] #20");
        expect(result).to.eql([LIT, 0x10, LIT, 0x20]);
      });

      it("should skip comments", () => {
        const result = asm("( Foo\nBar)#10");
        expect(result).to.eql([LIT, 0x10]);
      });

      it("should skip nested comments", () => {
        const result = asm("( ( Foo\n)Bar)#10");
        expect(result).to.eql([LIT, 0x10]);
      });
    });

    ////////////////////////////////////////////////////////////////////////////////

    describe("ulz", () => {
      const tests = [
        {
          decoded: `Blue like my corvette its in and outside
Blue are the words I say
And what I think
Blue are the feelings
That live inside me
I'm blue
Da ba dee da ba di
Da ba dee da ba di
Da ba dee da ba di
Da ba dee da ba di`,
          encoded: [
            0x28, 0x42, 0x6c, 0x75, 0x65, 0x20, 0x6c, 0x69, 0x6b, 0x65, 0x20,
            0x6d, 0x79, 0x20, 0x63, 0x6f, 0x72, 0x76, 0x65, 0x74, 0x74, 0x65,
            0x20, 0x69, 0x74, 0x73, 0x20, 0x69, 0x6e, 0x20, 0x61, 0x6e, 0x64,
            0x20, 0x6f, 0x75, 0x74, 0x73, 0x69, 0x64, 0x65, 0x0a, 0x81, 0x28,
            0x23, 0x61, 0x72, 0x65, 0x20, 0x74, 0x68, 0x65, 0x20, 0x77, 0x6f,
            0x72, 0x64, 0x73, 0x20, 0x49, 0x20, 0x73, 0x61, 0x79, 0x0a, 0x41,
            0x6e, 0x64, 0x20, 0x77, 0x68, 0x61, 0x74, 0x20, 0x49, 0x20, 0x74,
            0x68, 0x69, 0x6e, 0x6b, 0x8a, 0x29, 0x09, 0x66, 0x65, 0x65, 0x6c,
            0x69, 0x6e, 0x67, 0x73, 0x0a, 0x54, 0x80, 0x22, 0x06, 0x6c, 0x69,
            0x76, 0x65, 0x20, 0x69, 0x6e, 0x80, 0x50, 0x17, 0x20, 0x6d, 0x65,
            0x0a, 0x49, 0x27, 0x6d, 0x20, 0x62, 0x6c, 0x75, 0x65, 0x0a, 0x44,
            0x61, 0x20, 0x62, 0x61, 0x20, 0x64, 0x65, 0x65, 0x20, 0x64, 0x82,
            0x09, 0x00, 0x69, 0xb5, 0x12,
          ],
        },
        {
          decoded: `abcd`,
          encoded: [0x03, 0x61, 0x62, 0x63, 0x64],
        },
        {
          decoded: `abcdabcdabcd`,
          encoded: [0x03, 0x61, 0x62, 0x63, 0x64, 0x84, 0x03],
        },
      ];

      describe("decodeUlz", () => {
        for (const t of tests) {
          it(`should decode "${t.decoded.substr(0, 10)}"`, () => {
            const result = decodeUlz(t.encoded);
            expect(result.map((c) => String.fromCharCode(c)).join("")).to.eql(
              t.decoded
            );
          });
        }

        it("should not allow out-of-bounds LIT", () => {
          expect(() => decodeUlz([0x2, 0x1])).to.throw();
        });

        it("should not allow underflow CPY", () => {
          expect(() => decodeUlz([0x81, 0x1])).to.throw();
        });

        it("should not allow incomplete CPY instruction", () => {
          expect(() => decodeUlz([0x1, 0x2, 0x3, 0x81])).to.throw();
        });

        it("should not allow incomplete CPY2 instruction", () => {
          expect(() => decodeUlz([0x1, 0x2, 0x3, 0xc1])).to.throw();
        });

        it("should not allow incomplete CPY2 instruction (2)", () => {
          expect(() => decodeUlz([0x1, 0x2, 0x3, 0xc1, 0x1])).to.throw();
        });
      });

      describe("encodeUlz", () => {
        for (const t of tests) {
          it(`should encode "${t.decoded.substr(0, 10)}"`, () => {
            const result = encodeUlz(
              t.decoded.split("").map((c, i) => c.charCodeAt(0))
            );
            expect(result).to.eql(t.encoded);
          });
        }
      });
    });
  });
}

export default loadTests;
