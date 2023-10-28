/* eslint no-unused-vars:0 */

import Uxn from "../uxn";
import { expect } from "chai";
import testsTAL from "./tests.tal";
import opctestTAL from "./opctest.tal";

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
          throw new Error("not implemented");
        },
      });
    });

    describe("core", () => {
      ////////////////////////////////////////////////////////////////////////////////
      // Basic instructions to get the test suite started
      ////////////////////////////////////////////////////////////////////////////////

      describe("LIT", () => {
        it("should work", () => {
          uxn.load([LIT, 0x12, LIT, 0x13]);
          uxn.eval(PROGRAM_OFFSET);
          expect(wst()).to.eql([0x12, 0x13]);
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
  });
}

export default loadTests;
