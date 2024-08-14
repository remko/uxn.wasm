(module $uxn
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

    ;; Check PC and `state` ( https://wiki.xxiivv.com/site/varvara.html#system )
    (if (i32.eqz (local.get $pc)) (then (return)))
    (if (i32.load8_u (i32.const 0x10020f)) (then (return)))

    (local.set $wstp (global.get $wstp))
    (local.set $rstp (global.get $rstp))
    (block $endLoop
      (loop $loop
        (local.set $val (i32.load8_u (local.get $pc)))
        (local.set $pc (i32.add (local.get $pc) (i32.const 1)))

        ;; Uxntal Opcodes (https://wiki.xxiivv.com/site/uxntal_opcodes.html)
        ;;
        ;; Opcode documentation below includes stack effects on a given stack a b c.
        ;; | denotes the effect on the return Stack.
        ;; For the `r` variants, the stack effect describes the reset stack effect, and 
        ;; | the working stack effect.

        (block $SFT2kr (block $EOR2kr (block $ORA2kr (block $AND2kr (block $DIV2kr (block $MUL2kr (block $SUB2kr (block $ADD2kr (block $DEO2kr (block $DEI2kr (block $STA2kr (block $LDA2kr (block $STR2kr (block $LDR2kr (block $STZ2kr (block $LDZ2kr 
        (block $STH2kr (block $JSR2kr (block $JCN2kr (block $JMP2kr (block $LTH2kr (block $GTH2kr (block $NEQ2kr (block $EQU2kr (block $OVR2kr (block $DUP2kr (block $ROT2kr (block $SWP2kr (block $NIP2kr (block $POP2kr (block $INC2kr (block $LIT2r  
        (block $SFTkr  (block $EORkr  (block $ORAkr  (block $ANDkr  (block $DIVkr  (block $MULkr  (block $SUBkr  (block $ADDkr  (block $DEOkr  (block $DEIkr  (block $STAkr  (block $LDAkr  (block $STRkr  (block $LDRkr  (block $STZkr  (block $LDZkr  
        (block $STHkr  (block $JSRkr  (block $JCNkr  (block $JMPkr  (block $LTHkr  (block $GTHkr  (block $NEQkr  (block $EQUkr  (block $OVRkr  (block $DUPkr  (block $ROTkr  (block $SWPkr  (block $NIPkr  (block $POPkr  (block $INCkr  (block $LITr   
        (block $SFT2k  (block $EOR2k  (block $ORA2k  (block $AND2k  (block $DIV2k  (block $MUL2k  (block $SUB2k  (block $ADD2k  (block $DEO2k  (block $DEI2k  (block $STA2k  (block $LDA2k  (block $STR2k  (block $LDR2k  (block $STZ2k  (block $LDZ2k  
        (block $STH2k  (block $JSR2k  (block $JCN2k  (block $JMP2k  (block $LTH2k  (block $GTH2k  (block $NEQ2k  (block $EQU2k  (block $OVR2k  (block $DUP2k  (block $ROT2k  (block $SWP2k  (block $NIP2k  (block $POP2k  (block $INC2k  (block $LIT2   
        (block $SFTk   (block $EORk   (block $ORAk   (block $ANDk   (block $DIVk   (block $MULk   (block $SUBk   (block $ADDk   (block $DEOk   (block $DEIk   (block $STAk   (block $LDAk   (block $STRk   (block $LDRk   (block $STZk   (block $LDZk   
        (block $STHk   (block $JSRk   (block $JCNk   (block $JMPk   (block $LTHk   (block $GTHk   (block $NEQk   (block $EQUk   (block $OVRk   (block $DUPk   (block $ROTk   (block $SWPk   (block $NIPk   (block $POPk   (block $INCk   (block $LIT    
        (block $SFT2r  (block $EOR2r  (block $ORA2r  (block $AND2r  (block $DIV2r  (block $MUL2r  (block $SUB2r  (block $ADD2r  (block $DEO2r  (block $DEI2r  (block $STA2r  (block $LDA2r  (block $STR2r  (block $LDR2r  (block $STZ2r  (block $LDZ2r  
        (block $STH2r  (block $JSR2r  (block $JCN2r  (block $JMP2r  (block $LTH2r  (block $GTH2r  (block $NEQ2r  (block $EQU2r  (block $OVR2r  (block $DUP2r  (block $ROT2r  (block $SWP2r  (block $NIP2r  (block $POP2r  (block $INC2r  (block $JSI    
        (block $SFTr   (block $EORr   (block $ORAr   (block $ANDr   (block $DIVr   (block $MULr   (block $SUBr   (block $ADDr   (block $DEOr   (block $DEIr   (block $STAr   (block $LDAr   (block $STRr   (block $LDRr   (block $STZr   (block $LDZr   
        (block $STHr   (block $JSRr   (block $JCNr   (block $JMPr   (block $LTHr   (block $GTHr   (block $NEQr   (block $EQUr   (block $OVRr   (block $DUPr   (block $ROTr   (block $SWPr   (block $NIPr   (block $POPr   (block $INCr   (block $JMI    
        (block $SFT2   (block $EOR2   (block $ORA2   (block $AND2   (block $DIV2   (block $MUL2   (block $SUB2   (block $ADD2   (block $DEO2   (block $DEI2   (block $STA2   (block $LDA2   (block $STR2   (block $LDR2   (block $STZ2   (block $LDZ2   
        (block $STH2   (block $JSR2   (block $JCN2   (block $JMP2   (block $LTH2   (block $GTH2   (block $NEQ2   (block $EQU2   (block $OVR2   (block $DUP2   (block $ROT2   (block $SWP2   (block $NIP2   (block $POP2   (block $INC2   (block $JCI    
        (block $SFT    (block $EOR    (block $ORA    (block $AND    (block $DIV    (block $MUL    (block $SUB    (block $ADD    (block $DEO    (block $DEI    (block $STA    (block $LDA    (block $STR    (block $LDR    (block $STZ    (block $LDZ    
        (block $STH    (block $JSR    (block $JCN    (block $JMP    (block $LTH    (block $GTH    (block $NEQ    (block $EQU    (block $OVR    (block $DUP    (block $ROT    (block $SWP    (block $NIP    (block $POP    (block $INC    (block $BRK    
        (br_table
          $BRK    $INC    $POP    $NIP    $SWP    $ROT    $DUP    $OVR    $EQU    $NEQ    $GTH    $LTH    $JMP    $JCN    $JSR    $STH    
          $LDZ    $STZ    $LDR    $STR    $LDA    $STA    $DEI    $DEO    $ADD    $SUB    $MUL    $DIV    $AND    $ORA    $EOR    $SFT    
          $JCI    $INC2   $POP2   $NIP2   $SWP2   $ROT2   $DUP2   $OVR2   $EQU2   $NEQ2   $GTH2   $LTH2   $JMP2   $JCN2   $JSR2   $STH2   
          $LDZ2   $STZ2   $LDR2   $STR2   $LDA2   $STA2   $DEI2   $DEO2   $ADD2   $SUB2   $MUL2   $DIV2   $AND2   $ORA2   $EOR2   $SFT2   
          $JMI    $INCr   $POPr   $NIPr   $SWPr   $ROTr   $DUPr   $OVRr   $EQUr   $NEQr   $GTHr   $LTHr   $JMPr   $JCNr   $JSRr   $STHr   
          $LDZr   $STZr   $LDRr   $STRr   $LDAr   $STAr   $DEIr   $DEOr   $ADDr   $SUBr   $MULr   $DIVr   $ANDr   $ORAr   $EORr   $SFTr   
          $JSI    $INC2r  $POP2r  $NIP2r  $SWP2r  $ROT2r  $DUP2r  $OVR2r  $EQU2r  $NEQ2r  $GTH2r  $LTH2r  $JMP2r  $JCN2r  $JSR2r  $STH2r  
          $LDZ2r  $STZ2r  $LDR2r  $STR2r  $LDA2r  $STA2r  $DEI2r  $DEO2r  $ADD2r  $SUB2r  $MUL2r  $DIV2r  $AND2r  $ORA2r  $EOR2r  $SFT2r  
          $LIT    $INCk   $POPk   $NIPk   $SWPk   $ROTk   $DUPk   $OVRk   $EQUk   $NEQk   $GTHk   $LTHk   $JMPk   $JCNk   $JSRk   $STHk   
          $LDZk   $STZk   $LDRk   $STRk   $LDAk   $STAk   $DEIk   $DEOk   $ADDk   $SUBk   $MULk   $DIVk   $ANDk   $ORAk   $EORk   $SFTk   
          $LIT2   $INC2k  $POP2k  $NIP2k  $SWP2k  $ROT2k  $DUP2k  $OVR2k  $EQU2k  $NEQ2k  $GTH2k  $LTH2k  $JMP2k  $JCN2k  $JSR2k  $STH2k  
          $LDZ2k  $STZ2k  $LDR2k  $STR2k  $LDA2k  $STA2k  $DEI2k  $DEO2k  $ADD2k  $SUB2k  $MUL2k  $DIV2k  $AND2k  $ORA2k  $EOR2k  $SFT2k  
          $LITr   $INCkr  $POPkr  $NIPkr  $SWPkr  $ROTkr  $DUPkr  $OVRkr  $EQUkr  $NEQkr  $GTHkr  $LTHkr  $JMPkr  $JCNkr  $JSRkr  $STHkr  
          $LDZkr  $STZkr  $LDRkr  $STRkr  $LDAkr  $STAkr  $DEIkr  $DEOkr  $ADDkr  $SUBkr  $MULkr  $DIVkr  $ANDkr  $ORAkr  $EORkr  $SFTkr  
          $LIT2r  $INC2kr $POP2kr $NIP2kr $SWP2kr $ROT2kr $DUP2kr $OVR2kr $EQU2kr $NEQ2kr $GTH2kr $LTH2kr $JMP2kr $JCN2kr $JSR2kr $STH2kr 
          $LDZ2kr $STZ2kr $LDR2kr $STR2kr $LDA2kr $STA2kr $DEI2kr $DEO2kr $ADD2kr $SUB2kr $MUL2kr $DIV2kr $AND2kr $ORA2kr $EOR2kr $SFT2kr 
          $BRK
          (local.get $val))

        );;
        ;;; BRK ( -- ) [0x00]
        ;;;
        ;;; Break
        ;;;
        ;;; Ends the evalutation of the current vector. This opcode has no modes.
        ;;;
        (br $endLoop)

        );;
        ;;; INC (a -- a+1) [0x01]
        ;;;
        ;;; Increment
        ;;;
        ;;; Increments the value at the top of the stack, by 1.
        ;;;
        ;;; Example:
        ;;;   #01 INC         ( 02 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.add (local.get $t) (i32.const 1)))
        (br $loop)

        );;
        ;;; POP (a -- ) [0x02]
        ;;;
        ;;; Pop
        ;;;
        ;;; Removes the value at the top of the stack.
        ;;;
        ;;; Example:
        ;;;   #1234 POP    ( 12 )
        ;;;
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (br $loop)

        );;
        ;;; NIP (a b -- b) [0x03]
        ;;;
        ;;; Nip
        ;;;
        ;;; Removes the second value from the stack. This is practical to convert
        ;;; a short into a byte.
        ;;;
        ;;; Example:
        ;;;   #1234 NIP          ( 34 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (local.get $t))
        (br $loop)

        );;
        ;;; SWP (a b -- b a) [0x04]
        ;;;
        ;;; Swap
        ;;;
        ;;; Exchanges the first and second values at the top of the stack.
        ;;;
        ;;; Example:
        ;;;   #1234 SWP          ( 34 12 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 offset=0x100000 (local.get $wstp) (local.get $n))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (br $loop)

        );;
        ;;; ROT (a b c -- b c a) [0x05]
        ;;;
        ;;; Rotate
        ;;;
        ;;; Rotates three values at the top of the stack, to the left, wrapping
        ;;; around.
        ;;;
        ;;; Example:
        ;;;   #1234 #56 ROT            ( 34 56 12 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (i32.store8 offset=0x100000 (local.get $wstp) (local.get $l))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );;
        ;;; DUP (a -- a a) [0x06]
        ;;;
        ;;; Duplicate
        ;;;
        ;;; Duplicates the value at the top of the stack.
        ;;;
        ;;; Example:
        ;;;   #1234 DUP   ( 12 34 34 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (local.get $t))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (br $loop)

        );;
        ;;; OVR (a b -- a b a) [0x07]
        ;;;
        ;;; Over
        ;;;
        ;;; Duplicates the second value at the top of the stack.
        ;;;
        ;;; Example:
        ;;;   #1234 OVR          ( 12 34 12 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (local.get $n))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );;
        ;;; EQU (a b -- bool8) [0x08]
        ;;;
        ;;; Equal
        ;;;
        ;;; Pushes 01 to the stack if the two values at the top of the stack are
        ;;; equal, 00 otherwise.
        ;;;
        ;;; Example:
        ;;;   #1212 EQU          ( 01 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.eq (local.get $t) (local.get $n)))
        (br $loop)

        );;
        ;;; NEQ (a b -- bool8) [0x09]
        ;;;
        ;;; Not Equal
        ;;;
        ;;; Pushes 01 to the stack if the two values at the top of the stack are
        ;;; not equal, 00 otherwise.
        ;;;
        ;;; Example:
        ;;;   #1212 NEQ          ( 00 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.ne (local.get $t) (local.get $n)))
        (br $loop)

        );;
        ;;; GTH (a b -- bool8) [0x0a]
        ;;;
        ;;; Greater Than
        ;;;
        ;;; Pushes 01 to the stack if the second value at the top of the stack
        ;;; is greater than the value at the top of the stack, 00 otherwise.
        ;;;
        ;;; Example:
        ;;;   #1234 GTH          ( 00 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.gt_u (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; LTH (a b -- bool8) [0x0b]
        ;;;
        ;;; Lesser Than
        ;;;
        ;;; Pushes 01 to the stack if the second value at the top of the stack
        ;;; is lesser than the value at the top of the stack, 00 otherwise.
        ;;;
        ;;; Example:
        ;;;   #0101 LTH          ( 00 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.lt_u (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; JMP (addr -- ) [0x0c]
        ;;;
        ;;; Jump
        ;;;
        ;;; Moves the PC by a relative distance equal to the signed byte on the
        ;;; top of the stack, or to an absolute address in short mode.
        ;;;
        ;;; Example:
        ;;;   ,&skip-rel JMP BRK &skip-rel #01  ( 01 )
        ;;;
        (local.set $t (i32.load8_s offset=0x100000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (local.set $pc (i32.add (local.get $pc) (local.get $t)))
        (br $loop)

        );;
        ;;; JCN (cond8 addr -- ) [0x0d]
        ;;;
        ;;; Jump Conditional
        ;;;
        ;;; If the byte preceeding the address is not 00, moves the PC by a signed
        ;;; value equal to the byte on the top of the stack, or to an absolute
        ;;; address in short mode.
        ;;;
        ;;; Examples:
        ;;;   #abcd #01 ,&pass JCN SWP &pass POP  ( ab )
        ;;;   #abcd #00 ,&fail JCN SWP &fail POP  ( cd )
        ;;;
        (local.set $t (i32.load8_s offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (local.set $pc (i32.add (local.get $pc) (select (local.get $t) (i32.const 0) (local.get $n))))
        (br $loop)

        );;
        ;;; JSR (addr -- | ret16) [0x0e]
        ;;;
        ;;; Jump Stash Return
        ;;;
        ;;; Pushes the PC to the return-stack and moves the PC by a signed value
        ;;; equal to the byte on the top of the stack, or to an absolute address
        ;;; in short mode.
        ;;;
        ;;; Examples:
        ;;;   ,&routine JSR                     ( | PC* )
        ;;;   ,&get JSR #01 BRK &get #02 JMP2r  ( 02 01 )
        ;;;
        (local.set $t (i32.load8_s offset=0x100000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (local.get $pc)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (local.set $pc (i32.add (local.get $pc) (local.get $t)))
        (br $loop)

        );;
        ;;; STH (a -- | a) [0x0f]
        ;;;
        ;;; Stash
        ;;;
        ;;; Moves the value at the top of the stack to the return stack. Note
        ;;; that with the r-mode, the stacks are exchanged and the value is moved
        ;;; from the return stack to the working stack.
        ;;;
        ;;; Example:
        ;;;   #12 STH       ( | 12 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (local.get $t))
        (br $loop)

        );;
        ;;; LDZ (addr8 -- value) [0x10]
        ;;;
        ;;; Load Zero-Page
        ;;;
        ;;; Pushes the value at an address within the first 256 bytes of memory,
        ;;; to the top of the stack.
        ;;;
        ;;; Example:
        ;;;   |00 @cell $2 |0100 .cell LDZ ( 00 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.load8_u (local.get $t)))
        (br $loop)

        );;
        ;;; STZ (val addr8 -- ) [0x11]
        ;;;
        ;;; Store Zero-Page
        ;;;
        ;;; Writes a value to an address within the first 256 bytes of memory.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 (local.get $t) (local.get $n))
        (br $loop)

        );;
        ;;; LDR (addr8 -- value) [0x12]
        ;;;
        ;;; Load Relative
        ;;;
        ;;; Pushes a value at a relative address in relation to the PC, within
        ;;; a range between -128 and +127 bytes, to the top of the stack.
        ;;;
        (local.set $t (i32.load8_s offset=0x100000 (local.get $wstp)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.load8_u (i32.add (local.get $pc) (local.get $t))))
        (br $loop)

        );;
        ;;; STR (val addr8 -- ) [0x13]
        ;;;
        ;;; Store Relative
        ;;;
        ;;; Writes a value to a relative address in relation to the PC, within
        ;;; a range between -128 and +127 bytes.
        ;;;
        (local.set $t (i32.load8_s offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 (i32.add (local.get $pc) (local.get $t)) (local.get $n))
        (br $loop)

        );;
        ;;; LDA (addr16 -- value) [0x14]
        ;;;
        ;;; Load Absolute
        ;;;
        ;;; Pushes the value at a absolute address, to the top of the stack.
        ;;;
        ;;; Example:
        ;;;   ;cell LDA BRK @cell abcd ( ab )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.load8_u (local.get $t)))
        (br $loop)

        );;
        ;;; STA (val addr16 -- ) [0x15]
        ;;;
        ;;; Store Absolute
        ;;;
        ;;; Writes a value to a absolute address.
        ;;;
        ;;; Example:
        ;;;   #abcd ;cell STA BRK @cell $1 ( ab )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 (local.get $t) (local.get $n))
        (br $loop)

        );;
        ;;; DEI (device8 -- value) [0x16]
        ;;;
        ;;; Device Input
        ;;;
        ;;; Pushes a value from the device page, to the top of the stack. The
        ;;; target device might capture the reading to trigger an I/O event.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (i32.store8 offset=0x100000 (local.get $wstp) (call $dei (local.get $t)))
        (br $loop)

        );;
        ;;; DEO (val device8 -- ) [0x17]
        ;;;
        ;;; Device Output
        ;;;
        ;;; Writes a value to the device page. The target device might capture
        ;;; the writing to trigger an I/O event.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x100200 (local.get $t) (local.get $n))
        (call $deo (local.get $t) (local.get $n))
        (br $loop)

        );;
        ;;; ADD (a b -- a+b) [0x18]
        ;;;
        ;;; Add
        ;;;
        ;;; Pushes the sum of the two values at the top of the stack.
        ;;;
        ;;; Example:
        ;;;   #1a #2e ADD       ( 48 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.add (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; SUB (a b -- a-b) [0x19]
        ;;;
        ;;; Subtract
        ;;;
        ;;; Pushes the difference of the first value minus the second, to the
        ;;; top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.sub (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; MUL (a b -- a*b) [0x1a]
        ;;;
        ;;; Multiply
        ;;;
        ;;; Pushes the product of the first and second values at the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.mul (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; DIV (a b -- a/b) [0x1b]
        ;;;
        ;;; Divide
        ;;;
        ;;; Pushes the quotient of the first value over the second, to the top
        ;;; of the stack. A division by zero pushes zero on the stack. The rounding
        ;;; direction is toward zero.
        ;;;
        ;;; Example:
        ;;;   #10 #02 DIV       ( 08 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (if (result i32) (i32.eqz (local.get $t)) (then (i32.const 0)) (else (i32.div_u (local.get $n) (local.get $t)))))
        (br $loop)

        );;
        ;;; AND (a b -- a&b) [0x1c]
        ;;;
        ;;; And
        ;;;
        ;;; Pushes the result of the bitwise operation AND, to the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; ORA (a b -- a|b) [0x1d]
        ;;;
        ;;; Or
        ;;;
        ;;; Pushes the result of the bitwise operation OR, to the top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.or (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; EOR (a b -- a^b) [0x1e]
        ;;;
        ;;; Exclusive Or
        ;;;
        ;;; Pushes the result of the bitwise operation XOR, to the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.xor (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; SFT (a shift8 -- c) [0x1f]
        ;;;
        ;;; Shift
        ;;;
        ;;; Shifts the bits of the second value of the stack to the left or right,
        ;;; depending on the control value at the top of the stack. The high nibble
        ;;; of the control value indicates how many bits to shift left, and the
        ;;; low nibble how many bits to shift right. The rightward shift is done
        ;;; first.
        ;;;
        ;;; Examples:
        ;;;   #34 #10 SFT        ( 68 )
        ;;;   #34 #01 SFT        ( 1a )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4))))
        (br $loop)

        );;
        ;;; JCI (cond8 -- ) [0x20]
        ;;;
        ;;; Jump Conditional Instant
        ;;;
        ;;; Pops a byte from the working stack and if it is not zero, moves the
        ;;; PC to a relative address at a distance equal to the next short in
        ;;; memory, otherwise moves PC+2. This opcode has no modes.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (if (local.get $t) (then (local.set $pc (i32.add (i32.const 2) (i32.and (i32.add (local.get $pc) (i32.or (i32.shl (i32.load8_u (local.get $pc)) (i32.const 8)) (i32.load8_u (i32.and (i32.add (local.get $pc) (i32.const 1)) (i32.const 0xffff))))) (i32.const 0xffff))))) (else (local.set $pc (i32.add (local.get $pc) (i32.const 2)))))
        (br $loop)

        );;
        ;;; INC2 (a -- a+1) [0x21]
        ;;;
        ;;; Increment
        ;;;
        ;;; Increments the value at the top of the stack, by 1.
        ;;;
        ;;; Example:
        ;;;   #0001 INC2      ( 00 02 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (i32.add (local.get $t) (i32.const 1))) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; POP2 (a -- ) [0x22]
        ;;;
        ;;; Pop
        ;;;
        ;;; Removes the value at the top of the stack.
        ;;;
        ;;; Example:
        ;;;   #1234 POP2   ( )
        ;;;
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (br $loop)

        );;
        ;;; NIP2 (a b -- b) [0x23]
        ;;;
        ;;; Nip
        ;;;
        ;;; Removes the second value from the stack. This is practical to convert
        ;;; a short into a byte.
        ;;;
        ;;; Example:
        ;;;   #1234 #5678 NIP2   ( 56 78 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; SWP2 (a b -- b a) [0x24]
        ;;;
        ;;; Swap
        ;;;
        ;;; Exchanges the first and second values at the top of the stack.
        ;;;
        ;;; Example:
        ;;;   #1234 #5678 SWP2   ( 56 78 12 34 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (local.get $n)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; ROT2 (a b c -- b c a) [0x25]
        ;;;
        ;;; Rotate
        ;;;
        ;;; Rotates three values at the top of the stack, to the left, wrapping
        ;;; around.
        ;;;
        ;;; Example:
        ;;;   #1234 #5678 #9abc ROT2   ( 56 78 9a bc 12 34 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $l (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 4)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 5)) (i32.const 0xff))) (i32.const 8))))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (local.get $l)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 4)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $n)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 5)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; DUP2 (a -- a a) [0x26]
        ;;;
        ;;; Duplicate
        ;;;
        ;;; Duplicates the value at the top of the stack.
        ;;;
        ;;; Example:
        ;;;   #1234 DUP2  ( 12 34 12 34 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; OVR2 (a b -- a b a) [0x27]
        ;;;
        ;;; Over
        ;;;
        ;;; Duplicates the second value at the top of the stack.
        ;;;
        ;;; Example:
        ;;;   #1234 #5678 OVR2   ( 12 34 56 78 12 34 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (local.get $n)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 4)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $n)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 5)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; EQU2 (a b -- bool8) [0x28]
        ;;;
        ;;; Equal
        ;;;
        ;;; Pushes 01 to the stack if the two values at the top of the stack are
        ;;; equal, 00 otherwise.
        ;;;
        ;;; Example:
        ;;;   #abcd #ef01 EQU2   ( 00 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.eq (local.get $t) (local.get $n)))
        (br $loop)

        );;
        ;;; NEQ2 (a b -- bool8) [0x29]
        ;;;
        ;;; Not Equal
        ;;;
        ;;; Pushes 01 to the stack if the two values at the top of the stack are
        ;;; not equal, 00 otherwise.
        ;;;
        ;;; Example:
        ;;;   #abcd #ef01 NEQ2   ( 01 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.ne (local.get $t) (local.get $n)))
        (br $loop)

        );;
        ;;; GTH2 (a b -- bool8) [0x2a]
        ;;;
        ;;; Greater Than
        ;;;
        ;;; Pushes 01 to the stack if the second value at the top of the stack
        ;;; is greater than the value at the top of the stack, 00 otherwise.
        ;;;
        ;;; Example:
        ;;;   #3456 #1234 GTH2   ( 01 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.gt_u (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; LTH2 (a b -- bool8) [0x2b]
        ;;;
        ;;; Lesser Than
        ;;;
        ;;; Pushes 01 to the stack if the second value at the top of the stack
        ;;; is lesser than the value at the top of the stack, 00 otherwise.
        ;;;
        ;;; Example:
        ;;;   #0001 #0000 LTH2   ( 00 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.lt_u (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; JMP2 (addr -- ) [0x2c]
        ;;;
        ;;; Jump
        ;;;
        ;;; Moves the PC by a relative distance equal to the signed byte on the
        ;;; top of the stack, or to an absolute address in short mode.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (local.set $pc (local.get $t))
        (br $loop)

        );;
        ;;; JCN2 (cond8 addr -- ) [0x2d]
        ;;;
        ;;; Jump Conditional
        ;;;
        ;;; If the byte preceeding the address is not 00, moves the PC by a signed
        ;;; value equal to the byte on the top of the stack, or to an absolute
        ;;; address in short mode.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))
        (local.set $pc (select (local.get $t) (local.get $pc) (local.get $n)))
        (br $loop)

        );;
        ;;; JSR2 (addr -- | ret16) [0x2e]
        ;;;
        ;;; Jump Stash Return
        ;;;
        ;;; Pushes the PC to the return-stack and moves the PC by a signed value
        ;;; equal to the byte on the top of the stack, or to an absolute address
        ;;; in short mode.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (local.get $pc)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (local.set $pc (local.get $t))
        (br $loop)

        );;
        ;;; STH2 (a -- | a) [0x2f]
        ;;;
        ;;; Stash
        ;;;
        ;;; Moves the value at the top of the stack to the return stack. Note
        ;;; that with the r-mode, the stacks are exchanged and the value is moved
        ;;; from the return stack to the working stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; LDZ2 (addr8 -- value) [0x30]
        ;;;
        ;;; Load Zero-Page
        ;;;
        ;;; Pushes the value at an address within the first 256 bytes of memory,
        ;;; to the top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.load8_u (local.get $t)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.load8_u (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xff))))
        (br $loop)

        );;
        ;;; STZ2 (val addr8 -- ) [0x31]
        ;;;
        ;;; Store Zero-Page
        ;;;
        ;;; Writes a value to an address within the first 256 bytes of memory.
        ;;;
        ;;; Example:
        ;;;   |00 @cell $2 |0100 #abcd .cell STZ2  { ab cd }
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 (local.get $t) (local.get $l))
        (i32.store8 (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );;
        ;;; LDR2 (addr8 -- value) [0x32]
        ;;;
        ;;; Load Relative
        ;;;
        ;;; Pushes a value at a relative address in relation to the PC, within
        ;;; a range between -128 and +127 bytes, to the top of the stack.
        ;;;
        ;;; Example:
        ;;;   ,cell LDR2 BRK @cell abcd  ( ab cd )
        ;;;
        (local.set $t (i32.load8_s offset=0x100000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.load8_u (local.tee $mval (i32.add (local.get $pc) (local.get $t)))))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.load8_u (i32.and (i32.add (local.get $mval) (i32.const 1)) (i32.const 0xffff))))
        (br $loop)

        );;
        ;;; STR2 (val addr8 -- ) [0x33]
        ;;;
        ;;; Store Relative
        ;;;
        ;;; Writes a value to a relative address in relation to the PC, within
        ;;; a range between -128 and +127 bytes.
        ;;;
        ;;; Example:
        ;;;   #1234 ,cell STR2 BRK @cell $2  ( )
        ;;;
        (local.set $t (i32.load8_s offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 (local.tee $mval (i32.and (i32.add (local.get $pc) (local.get $t)) (i32.const 0xffff))) (local.get $l))
        (i32.store8 (i32.and (i32.add (local.get $mval) (i32.const 1)) (i32.const 0xffff)) (local.get $n))
        (br $loop)

        );;
        ;;; LDA2 (addr16 -- value) [0x34]
        ;;;
        ;;; Load Absolute
        ;;;
        ;;; Pushes the value at a absolute address, to the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.load8_u (local.get $t)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.load8_u (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xffff))))
        (br $loop)

        );;
        ;;; STA2 (val addr16 -- ) [0x35]
        ;;;
        ;;; Store Absolute
        ;;;
        ;;; Writes a value to a absolute address.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 4)) (i32.const 0xff)))
        (i32.store8 (local.get $t) (local.get $l))
        (i32.store8 (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xffff)) (local.get $n))
        (br $loop)

        );;
        ;;; DEI2 (device8 -- value) [0x36]
        ;;;
        ;;; Device Input
        ;;;
        ;;; Pushes a value from the device page, to the top of the stack. The
        ;;; target device might capture the reading to trigger an I/O event.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (call $dei (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (call $dei (local.get $t)))
        (br $loop)

        );;
        ;;; DEO2 (val device8 -- ) [0x37]
        ;;;
        ;;; Device Output
        ;;;
        ;;; Writes a value to the device page. The target device might capture
        ;;; the writing to trigger an I/O event.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 offset=0x100200 (local.get $t) (local.get $l))
        (call $deo (local.get $t) (local.get $l))
        (i32.store8 offset=0x100200 (local.tee $t (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xff))) (local.get $n))
        (call $deo (local.get $t) (local.get $n))
        (br $loop)

        );;
        ;;; ADD2 (a b -- a+b) [0x38]
        ;;;
        ;;; Add
        ;;;
        ;;; Pushes the sum of the two values at the top of the stack.
        ;;;
        ;;; Example:
        ;;;   #0001 #0002 ADD2  ( 00 03 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (i32.add (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; SUB2 (a b -- a-b) [0x39]
        ;;;
        ;;; Subtract
        ;;;
        ;;; Pushes the difference of the first value minus the second, to the
        ;;; top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (i32.sub (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; MUL2 (a b -- a*b) [0x3a]
        ;;;
        ;;; Multiply
        ;;;
        ;;; Pushes the product of the first and second values at the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (i32.mul (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; DIV2 (a b -- a/b) [0x3b]
        ;;;
        ;;; Divide
        ;;;
        ;;; Pushes the quotient of the first value over the second, to the top
        ;;; of the stack. A division by zero pushes zero on the stack. The rounding
        ;;; direction is toward zero.
        ;;;
        ;;; Example:
        ;;;   #0010 #0000 DIV2  ( 00 00 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (if (result i32) (i32.eqz (local.get $t)) (then (i32.const 0)) (else (i32.div_u (local.get $n) (local.get $t))))) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; AND2 (a b -- a&b) [0x3c]
        ;;;
        ;;; And
        ;;;
        ;;; Pushes the result of the bitwise operation AND, to the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (i32.and (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; ORA2 (a b -- a|b) [0x3d]
        ;;;
        ;;; Or
        ;;;
        ;;; Pushes the result of the bitwise operation OR, to the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (i32.or (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; EOR2 (a b -- a^b) [0x3e]
        ;;;
        ;;; Exclusive Or
        ;;;
        ;;; Pushes the result of the bitwise operation XOR, to the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (i32.xor (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; SFT2 (a shift8 -- c) [0x3f]
        ;;;
        ;;; Shift
        ;;;
        ;;; Shifts the bits of the second value of the stack to the left or right,
        ;;; depending on the control value at the top of the stack. The high nibble
        ;;; of the control value indicates how many bits to shift left, and the
        ;;; low nibble how many bits to shift right. The rightward shift is done
        ;;; first.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4)))) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; JMI ( -- ) [0x40]
        ;;;
        ;;; Jump Instant
        ;;;
        ;;; Moves the PC to a relative address at a distance equal to the next
        ;;; short in memory. This opcode has no modes.
        ;;;
        (local.set $pc (i32.add (i32.const 2) (i32.and (i32.add (local.get $pc) (i32.or (i32.shl (i32.load8_u (local.get $pc)) (i32.const 8)) (i32.load8_u (i32.and (i32.add (local.get $pc) (i32.const 1)) (i32.const 0xffff))))) (i32.const 0xffff))))
        (br $loop)

        );;
        ;;; INCr (a -- a+1) [0x41]
        ;;;
        ;;; Increment
        ;;;
        ;;; Increments the value at the top of the stack, by 1.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.add (local.get $t) (i32.const 1)))
        (br $loop)

        );;
        ;;; POPr (a -- ) [0x42]
        ;;;
        ;;; Pop
        ;;;
        ;;; Removes the value at the top of the stack.
        ;;;
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (br $loop)

        );;
        ;;; NIPr (a b -- b) [0x43]
        ;;;
        ;;; Nip
        ;;;
        ;;; Removes the second value from the stack. This is practical to convert
        ;;; a short into a byte.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (local.get $t))
        (br $loop)

        );;
        ;;; SWPr (a b -- b a) [0x44]
        ;;;
        ;;; Swap
        ;;;
        ;;; Exchanges the first and second values at the top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 offset=0x100100 (local.get $rstp) (local.get $n))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (br $loop)

        );;
        ;;; ROTr (a b c -- b c a) [0x45]
        ;;;
        ;;; Rotate
        ;;;
        ;;; Rotates three values at the top of the stack, to the left, wrapping
        ;;; around.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (i32.store8 offset=0x100100 (local.get $rstp) (local.get $l))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );;
        ;;; DUPr (a -- a a) [0x46]
        ;;;
        ;;; Duplicate
        ;;;
        ;;; Duplicates the value at the top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (local.get $t))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (br $loop)

        );;
        ;;; OVRr (a b -- a b a) [0x47]
        ;;;
        ;;; Over
        ;;;
        ;;; Duplicates the second value at the top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (local.get $n))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );;
        ;;; EQUr (a b -- bool8) [0x48]
        ;;;
        ;;; Equal
        ;;;
        ;;; Pushes 01 to the stack if the two values at the top of the stack are
        ;;; equal, 00 otherwise.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.eq (local.get $t) (local.get $n)))
        (br $loop)

        );;
        ;;; NEQr (a b -- bool8) [0x49]
        ;;;
        ;;; Not Equal
        ;;;
        ;;; Pushes 01 to the stack if the two values at the top of the stack are
        ;;; not equal, 00 otherwise.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.ne (local.get $t) (local.get $n)))
        (br $loop)

        );;
        ;;; GTHr (a b -- bool8) [0x4a]
        ;;;
        ;;; Greater Than
        ;;;
        ;;; Pushes 01 to the stack if the second value at the top of the stack
        ;;; is greater than the value at the top of the stack, 00 otherwise.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.gt_u (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; LTHr (a b -- bool8) [0x4b]
        ;;;
        ;;; Lesser Than
        ;;;
        ;;; Pushes 01 to the stack if the second value at the top of the stack
        ;;; is lesser than the value at the top of the stack, 00 otherwise.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.lt_u (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; JMPr (addr -- ) [0x4c]
        ;;;
        ;;; Jump
        ;;;
        ;;; Moves the PC by a relative distance equal to the signed byte on the
        ;;; top of the stack, or to an absolute address in short mode.
        ;;;
        (local.set $t (i32.load8_s offset=0x100100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (local.set $pc (i32.add (local.get $pc) (local.get $t)))
        (br $loop)

        );;
        ;;; JCNr (cond8 addr -- ) [0x4d]
        ;;;
        ;;; Jump Conditional
        ;;;
        ;;; If the byte preceeding the address is not 00, moves the PC by a signed
        ;;; value equal to the byte on the top of the stack, or to an absolute
        ;;; address in short mode.
        ;;;
        (local.set $t (i32.load8_s offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (local.set $pc (i32.add (local.get $pc) (select (local.get $t) (i32.const 0) (local.get $n))))
        (br $loop)

        );;
        ;;; JSRr (addr -- | ret16) [0x4e]
        ;;;
        ;;; Jump Stash Return
        ;;;
        ;;; Pushes the PC to the return-stack and moves the PC by a signed value
        ;;; equal to the byte on the top of the stack, or to an absolute address
        ;;; in short mode.
        ;;;
        (local.set $t (i32.load8_s offset=0x100100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (local.get $pc)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (local.set $pc (i32.add (local.get $pc) (local.get $t)))
        (br $loop)

        );;
        ;;; STHr (a -- | a) [0x4f]
        ;;;
        ;;; Stash
        ;;;
        ;;; Moves the value at the top of the stack to the return stack. Note
        ;;; that with the r-mode, the stacks are exchanged and the value is moved
        ;;; from the return stack to the working stack.
        ;;;
        ;;; Example:
        ;;;   LITr 34 STHr  ( 34 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (local.get $t))
        (br $loop)

        );;
        ;;; LDZr (addr8 -- value) [0x50]
        ;;;
        ;;; Load Zero-Page
        ;;;
        ;;; Pushes the value at an address within the first 256 bytes of memory,
        ;;; to the top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.load8_u (local.get $t)))
        (br $loop)

        );;
        ;;; STZr (val addr8 -- ) [0x51]
        ;;;
        ;;; Store Zero-Page
        ;;;
        ;;; Writes a value to an address within the first 256 bytes of memory.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 (local.get $t) (local.get $n))
        (br $loop)

        );;
        ;;; LDRr (addr8 -- value) [0x52]
        ;;;
        ;;; Load Relative
        ;;;
        ;;; Pushes a value at a relative address in relation to the PC, within
        ;;; a range between -128 and +127 bytes, to the top of the stack.
        ;;;
        (local.set $t (i32.load8_s offset=0x100100 (local.get $rstp)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.load8_u (i32.add (local.get $pc) (local.get $t))))
        (br $loop)

        );;
        ;;; STRr (val addr8 -- ) [0x53]
        ;;;
        ;;; Store Relative
        ;;;
        ;;; Writes a value to a relative address in relation to the PC, within
        ;;; a range between -128 and +127 bytes.
        ;;;
        (local.set $t (i32.load8_s offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 (i32.add (local.get $pc) (local.get $t)) (local.get $n))
        (br $loop)

        );;
        ;;; LDAr (addr16 -- value) [0x54]
        ;;;
        ;;; Load Absolute
        ;;;
        ;;; Pushes the value at a absolute address, to the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.load8_u (local.get $t)))
        (br $loop)

        );;
        ;;; STAr (val addr16 -- ) [0x55]
        ;;;
        ;;; Store Absolute
        ;;;
        ;;; Writes a value to a absolute address.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 (local.get $t) (local.get $n))
        (br $loop)

        );;
        ;;; DEIr (device8 -- value) [0x56]
        ;;;
        ;;; Device Input
        ;;;
        ;;; Pushes a value from the device page, to the top of the stack. The
        ;;; target device might capture the reading to trigger an I/O event.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (i32.store8 offset=0x100100 (local.get $rstp) (call $dei (local.get $t)))
        (br $loop)

        );;
        ;;; DEOr (val device8 -- ) [0x57]
        ;;;
        ;;; Device Output
        ;;;
        ;;; Writes a value to the device page. The target device might capture
        ;;; the writing to trigger an I/O event.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x100200 (local.get $t) (local.get $n))
        (call $deo (local.get $t) (local.get $n))
        (br $loop)

        );;
        ;;; ADDr (a b -- a+b) [0x58]
        ;;;
        ;;; Add
        ;;;
        ;;; Pushes the sum of the two values at the top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.add (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; SUBr (a b -- a-b) [0x59]
        ;;;
        ;;; Subtract
        ;;;
        ;;; Pushes the difference of the first value minus the second, to the
        ;;; top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.sub (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; MULr (a b -- a*b) [0x5a]
        ;;;
        ;;; Multiply
        ;;;
        ;;; Pushes the product of the first and second values at the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.mul (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; DIVr (a b -- a/b) [0x5b]
        ;;;
        ;;; Divide
        ;;;
        ;;; Pushes the quotient of the first value over the second, to the top
        ;;; of the stack. A division by zero pushes zero on the stack. The rounding
        ;;; direction is toward zero.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (if (result i32) (i32.eqz (local.get $t)) (then (i32.const 0)) (else (i32.div_u (local.get $n) (local.get $t)))))
        (br $loop)

        );;
        ;;; ANDr (a b -- a&b) [0x5c]
        ;;;
        ;;; And
        ;;;
        ;;; Pushes the result of the bitwise operation AND, to the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; ORAr (a b -- a|b) [0x5d]
        ;;;
        ;;; Or
        ;;;
        ;;; Pushes the result of the bitwise operation OR, to the top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.or (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; EORr (a b -- a^b) [0x5e]
        ;;;
        ;;; Exclusive Or
        ;;;
        ;;; Pushes the result of the bitwise operation XOR, to the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.xor (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; SFTr (a shift8 -- c) [0x5f]
        ;;;
        ;;; Shift
        ;;;
        ;;; Shifts the bits of the second value of the stack to the left or right,
        ;;; depending on the control value at the top of the stack. The high nibble
        ;;; of the control value indicates how many bits to shift left, and the
        ;;; low nibble how many bits to shift right. The rightward shift is done
        ;;; first.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4))))
        (br $loop)

        );;
        ;;; JSI ( -- ) [0x60]
        ;;;
        ;;; Jump Stash Return Instant
        ;;;
        ;;; Pushes PC+2 to the return-stack and moves the PC to a relative address
        ;;; at a distance equal to the next short in memory. This opcode has no
        ;;; modes.
        ;;;
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (local.tee $n (i32.add (local.get $pc) (i32.const 2)))) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (local.set $pc (i32.and (i32.add (local.get $n) (i32.or (i32.shl (i32.load8_u (local.get $pc)) (i32.const 8)) (i32.load8_u (i32.and (i32.add (local.get $pc) (i32.const 1)) (i32.const 0xffff))))) (i32.const 0xffff)))
        (br $loop)

        );;
        ;;; INC2r (a -- a+1) [0x61]
        ;;;
        ;;; Increment
        ;;;
        ;;; Increments the value at the top of the stack, by 1.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (i32.add (local.get $t) (i32.const 1))) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; POP2r (a -- ) [0x62]
        ;;;
        ;;; Pop
        ;;;
        ;;; Removes the value at the top of the stack.
        ;;;
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (br $loop)

        );;
        ;;; NIP2r (a b -- b) [0x63]
        ;;;
        ;;; Nip
        ;;;
        ;;; Removes the second value from the stack. This is practical to convert
        ;;; a short into a byte.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; SWP2r (a b -- b a) [0x64]
        ;;;
        ;;; Swap
        ;;;
        ;;; Exchanges the first and second values at the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (local.get $n)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; ROT2r (a b c -- b c a) [0x65]
        ;;;
        ;;; Rotate
        ;;;
        ;;; Rotates three values at the top of the stack, to the left, wrapping
        ;;; around.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $l (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 4)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 5)) (i32.const 0xff))) (i32.const 8))))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (local.get $l)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 4)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $n)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 5)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; DUP2r (a -- a a) [0x66]
        ;;;
        ;;; Duplicate
        ;;;
        ;;; Duplicates the value at the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; OVR2r (a b -- a b a) [0x67]
        ;;;
        ;;; Over
        ;;;
        ;;; Duplicates the second value at the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (local.get $n)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 4)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $n)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 5)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; EQU2r (a b -- bool8) [0x68]
        ;;;
        ;;; Equal
        ;;;
        ;;; Pushes 01 to the stack if the two values at the top of the stack are
        ;;; equal, 00 otherwise.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.eq (local.get $t) (local.get $n)))
        (br $loop)

        );;
        ;;; NEQ2r (a b -- bool8) [0x69]
        ;;;
        ;;; Not Equal
        ;;;
        ;;; Pushes 01 to the stack if the two values at the top of the stack are
        ;;; not equal, 00 otherwise.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.ne (local.get $t) (local.get $n)))
        (br $loop)

        );;
        ;;; GTH2r (a b -- bool8) [0x6a]
        ;;;
        ;;; Greater Than
        ;;;
        ;;; Pushes 01 to the stack if the second value at the top of the stack
        ;;; is greater than the value at the top of the stack, 00 otherwise.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.gt_u (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; LTH2r (a b -- bool8) [0x6b]
        ;;;
        ;;; Lesser Than
        ;;;
        ;;; Pushes 01 to the stack if the second value at the top of the stack
        ;;; is lesser than the value at the top of the stack, 00 otherwise.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.lt_u (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; JMP2r (addr -- ) [0x6c]
        ;;;
        ;;; Jump
        ;;;
        ;;; Moves the PC by a relative distance equal to the signed byte on the
        ;;; top of the stack, or to an absolute address in short mode.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (local.set $pc (local.get $t))
        (br $loop)

        );;
        ;;; JCN2r (cond8 addr -- ) [0x6d]
        ;;;
        ;;; Jump Conditional
        ;;;
        ;;; If the byte preceeding the address is not 00, moves the PC by a signed
        ;;; value equal to the byte on the top of the stack, or to an absolute
        ;;; address in short mode.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))
        (local.set $pc (select (local.get $t) (local.get $pc) (local.get $n)))
        (br $loop)

        );;
        ;;; JSR2r (addr -- | ret16) [0x6e]
        ;;;
        ;;; Jump Stash Return
        ;;;
        ;;; Pushes the PC to the return-stack and moves the PC by a signed value
        ;;; equal to the byte on the top of the stack, or to an absolute address
        ;;; in short mode.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (local.get $pc)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (local.set $pc (local.get $t))
        (br $loop)

        );;
        ;;; STH2r (a -- | a) [0x6f]
        ;;;
        ;;; Stash
        ;;;
        ;;; Moves the value at the top of the stack to the return stack. Note
        ;;; that with the r-mode, the stacks are exchanged and the value is moved
        ;;; from the return stack to the working stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; LDZ2r (addr8 -- value) [0x70]
        ;;;
        ;;; Load Zero-Page
        ;;;
        ;;; Pushes the value at an address within the first 256 bytes of memory,
        ;;; to the top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.load8_u (local.get $t)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.load8_u (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xff))))
        (br $loop)

        );;
        ;;; STZ2r (val addr8 -- ) [0x71]
        ;;;
        ;;; Store Zero-Page
        ;;;
        ;;; Writes a value to an address within the first 256 bytes of memory.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 (local.get $t) (local.get $l))
        (i32.store8 (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );;
        ;;; LDR2r (addr8 -- value) [0x72]
        ;;;
        ;;; Load Relative
        ;;;
        ;;; Pushes a value at a relative address in relation to the PC, within
        ;;; a range between -128 and +127 bytes, to the top of the stack.
        ;;;
        (local.set $t (i32.load8_s offset=0x100100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.load8_u (local.tee $mval (i32.add (local.get $pc) (local.get $t)))))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.load8_u (i32.and (i32.add (local.get $mval) (i32.const 1)) (i32.const 0xffff))))
        (br $loop)

        );;
        ;;; STR2r (val addr8 -- ) [0x73]
        ;;;
        ;;; Store Relative
        ;;;
        ;;; Writes a value to a relative address in relation to the PC, within
        ;;; a range between -128 and +127 bytes.
        ;;;
        (local.set $t (i32.load8_s offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 (local.tee $mval (i32.and (i32.add (local.get $pc) (local.get $t)) (i32.const 0xffff))) (local.get $l))
        (i32.store8 (i32.and (i32.add (local.get $mval) (i32.const 1)) (i32.const 0xffff)) (local.get $n))
        (br $loop)

        );;
        ;;; LDA2r (addr16 -- value) [0x74]
        ;;;
        ;;; Load Absolute
        ;;;
        ;;; Pushes the value at a absolute address, to the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.load8_u (local.get $t)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.load8_u (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xffff))))
        (br $loop)

        );;
        ;;; STA2r (val addr16 -- ) [0x75]
        ;;;
        ;;; Store Absolute
        ;;;
        ;;; Writes a value to a absolute address.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 4)) (i32.const 0xff)))
        (i32.store8 (local.get $t) (local.get $l))
        (i32.store8 (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xffff)) (local.get $n))
        (br $loop)

        );;
        ;;; DEI2r (device8 -- value) [0x76]
        ;;;
        ;;; Device Input
        ;;;
        ;;; Pushes a value from the device page, to the top of the stack. The
        ;;; target device might capture the reading to trigger an I/O event.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (call $dei (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (call $dei (local.get $t)))
        (br $loop)

        );;
        ;;; DEO2r (val device8 -- ) [0x77]
        ;;;
        ;;; Device Output
        ;;;
        ;;; Writes a value to the device page. The target device might capture
        ;;; the writing to trigger an I/O event.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 offset=0x100200 (local.get $t) (local.get $l))
        (call $deo (local.get $t) (local.get $l))
        (i32.store8 offset=0x100200 (local.tee $t (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xff))) (local.get $n))
        (call $deo (local.get $t) (local.get $n))
        (br $loop)

        );;
        ;;; ADD2r (a b -- a+b) [0x78]
        ;;;
        ;;; Add
        ;;;
        ;;; Pushes the sum of the two values at the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (i32.add (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; SUB2r (a b -- a-b) [0x79]
        ;;;
        ;;; Subtract
        ;;;
        ;;; Pushes the difference of the first value minus the second, to the
        ;;; top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (i32.sub (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; MUL2r (a b -- a*b) [0x7a]
        ;;;
        ;;; Multiply
        ;;;
        ;;; Pushes the product of the first and second values at the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (i32.mul (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; DIV2r (a b -- a/b) [0x7b]
        ;;;
        ;;; Divide
        ;;;
        ;;; Pushes the quotient of the first value over the second, to the top
        ;;; of the stack. A division by zero pushes zero on the stack. The rounding
        ;;; direction is toward zero.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (if (result i32) (i32.eqz (local.get $t)) (then (i32.const 0)) (else (i32.div_u (local.get $n) (local.get $t))))) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; AND2r (a b -- a&b) [0x7c]
        ;;;
        ;;; And
        ;;;
        ;;; Pushes the result of the bitwise operation AND, to the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (i32.and (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; ORA2r (a b -- a|b) [0x7d]
        ;;;
        ;;; Or
        ;;;
        ;;; Pushes the result of the bitwise operation OR, to the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (i32.or (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; EOR2r (a b -- a^b) [0x7e]
        ;;;
        ;;; Exclusive Or
        ;;;
        ;;; Pushes the result of the bitwise operation XOR, to the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (i32.xor (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; SFT2r (a shift8 -- c) [0x7f]
        ;;;
        ;;; Shift
        ;;;
        ;;; Shifts the bits of the second value of the stack to the left or right,
        ;;; depending on the control value at the top of the stack. The high nibble
        ;;; of the control value indicates how many bits to shift left, and the
        ;;; low nibble how many bits to shift right. The rightward shift is done
        ;;; first.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4)))) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; LIT ( --  a) [0x80]
        ;;;
        ;;; Literal
        ;;;
        ;;; Pushes the next bytes in memory, and moves the PC+2. The LIT opcode
        ;;; always has the keep mode active. Notice how the 0x00 opcode, with
        ;;; the keep bit toggled, is the location of the literal opcodes.
        ;;;
        ;;; Example:
        ;;;   LIT 12          ( 12 )
        ;;;
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.load8_u (local.get $pc)))
        (local.set $pc (i32.add (local.get $pc) (i32.const 1)))
        (br $loop)

        );;
        ;;; INCk (a -- a a+1) [0x81]
        ;;;
        ;;; Increment
        ;;;
        ;;; Increments the value at the top of the stack, by 1.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.add (local.get $t) (i32.const 1)))
        (br $loop)

        );;
        ;;; POPk (a -- a ) [0x82]
        ;;;
        ;;; Pop
        ;;;
        ;;; Removes the value at the top of the stack.
        ;;;
        (br $loop)

        );;
        ;;; NIPk (a b -- a b b) [0x83]
        ;;;
        ;;; Nip
        ;;;
        ;;; Removes the second value from the stack. This is practical to convert
        ;;; a short into a byte.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (local.get $t))
        (br $loop)

        );;
        ;;; SWPk (a b -- a b b a) [0x84]
        ;;;
        ;;; Swap
        ;;;
        ;;; Exchanges the first and second values at the top of the stack.
        ;;;
        ;;; Example:
        ;;;   #1234 SWPk         ( 12 34 34 12 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (local.get $n))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (br $loop)

        );;
        ;;; ROTk (a b c -- a b c b c a) [0x85]
        ;;;
        ;;; Rotate
        ;;;
        ;;; Rotates three values at the top of the stack, to the left, wrapping
        ;;; around.
        ;;;
        ;;; Example:
        ;;;   #1234 #56 ROTk           ( 12 34 56 34 56 12 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 253)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (local.get $l))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );;
        ;;; DUPk (a -- a a a) [0x86]
        ;;;
        ;;; Duplicate
        ;;;
        ;;; Duplicates the value at the top of the stack.
        ;;;
        ;;; Example:
        ;;;   #12 DUPk    ( 12 12 12 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (local.get $t))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (br $loop)

        );;
        ;;; OVRk (a b -- a b a b a) [0x87]
        ;;;
        ;;; Over
        ;;;
        ;;; Duplicates the second value at the top of the stack.
        ;;;
        ;;; Example:
        ;;;   #1234 OVRk         ( 12 34 12 34 12 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 253)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (local.get $n))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );;
        ;;; EQUk (a b -- a b bool8) [0x88]
        ;;;
        ;;; Equal
        ;;;
        ;;; Pushes 01 to the stack if the two values at the top of the stack are
        ;;; equal, 00 otherwise.
        ;;;
        ;;; Example:
        ;;;   #1234 EQUk         ( 12 34 00 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.eq (local.get $t) (local.get $n)))
        (br $loop)

        );;
        ;;; NEQk (a b -- a b bool8) [0x89]
        ;;;
        ;;; Not Equal
        ;;;
        ;;; Pushes 01 to the stack if the two values at the top of the stack are
        ;;; not equal, 00 otherwise.
        ;;;
        ;;; Example:
        ;;;   #1234 NEQk         ( 12 34 01 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.ne (local.get $t) (local.get $n)))
        (br $loop)

        );;
        ;;; GTHk (a b -- a b bool8) [0x8a]
        ;;;
        ;;; Greater Than
        ;;;
        ;;; Pushes 01 to the stack if the second value at the top of the stack
        ;;; is greater than the value at the top of the stack, 00 otherwise.
        ;;;
        ;;; Example:
        ;;;   #3412 GTHk         ( 34 12 01 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.gt_u (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; LTHk (a b -- a b bool8) [0x8b]
        ;;;
        ;;; Lesser Than
        ;;;
        ;;; Pushes 01 to the stack if the second value at the top of the stack
        ;;; is lesser than the value at the top of the stack, 00 otherwise.
        ;;;
        ;;; Example:
        ;;;   #0100 LTHk         ( 01 00 00 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.lt_u (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; JMPk (addr -- addr ) [0x8c]
        ;;;
        ;;; Jump
        ;;;
        ;;; Moves the PC by a relative distance equal to the signed byte on the
        ;;; top of the stack, or to an absolute address in short mode.
        ;;;
        (local.set $t (i32.load8_s offset=0x100000 (local.get $wstp)))
        (local.set $pc (i32.add (local.get $pc) (local.get $t)))
        (br $loop)

        );;
        ;;; JCNk (cond8 addr -- cond8 addr ) [0x8d]
        ;;;
        ;;; Jump Conditional
        ;;;
        ;;; If the byte preceeding the address is not 00, moves the PC by a signed
        ;;; value equal to the byte on the top of the stack, or to an absolute
        ;;; address in short mode.
        ;;;
        (local.set $t (i32.load8_s offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $pc (i32.add (local.get $pc) (select (local.get $t) (i32.const 0) (local.get $n))))
        (br $loop)

        );;
        ;;; JSRk (addr -- addr | ret16) [0x8e]
        ;;;
        ;;; Jump Stash Return
        ;;;
        ;;; Pushes the PC to the return-stack and moves the PC by a signed value
        ;;; equal to the byte on the top of the stack, or to an absolute address
        ;;; in short mode.
        ;;;
        (local.set $t (i32.load8_s offset=0x100000 (local.get $wstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (local.get $pc)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (local.set $pc (i32.add (local.get $pc) (local.get $t)))
        (br $loop)

        );;
        ;;; STHk (a -- a | a) [0x8f]
        ;;;
        ;;; Stash
        ;;;
        ;;; Moves the value at the top of the stack to the return stack. Note
        ;;; that with the r-mode, the stacks are exchanged and the value is moved
        ;;; from the return stack to the working stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (local.get $t))
        (br $loop)

        );;
        ;;; LDZk (addr8 -- addr8 value) [0x90]
        ;;;
        ;;; Load Zero-Page
        ;;;
        ;;; Pushes the value at an address within the first 256 bytes of memory,
        ;;; to the top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.load8_u (local.get $t)))
        (br $loop)

        );;
        ;;; STZk (val addr8 -- val addr8 ) [0x91]
        ;;;
        ;;; Store Zero-Page
        ;;;
        ;;; Writes a value to an address within the first 256 bytes of memory.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 (local.get $t) (local.get $n))
        (br $loop)

        );;
        ;;; LDRk (addr8 -- addr8 value) [0x92]
        ;;;
        ;;; Load Relative
        ;;;
        ;;; Pushes a value at a relative address in relation to the PC, within
        ;;; a range between -128 and +127 bytes, to the top of the stack.
        ;;;
        (local.set $t (i32.load8_s offset=0x100000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.load8_u (i32.add (local.get $pc) (local.get $t))))
        (br $loop)

        );;
        ;;; STRk (val addr8 -- val addr8 ) [0x93]
        ;;;
        ;;; Store Relative
        ;;;
        ;;; Writes a value to a relative address in relation to the PC, within
        ;;; a range between -128 and +127 bytes.
        ;;;
        (local.set $t (i32.load8_s offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 (i32.add (local.get $pc) (local.get $t)) (local.get $n))
        (br $loop)

        );;
        ;;; LDAk (addr16 -- addr16 value) [0x94]
        ;;;
        ;;; Load Absolute
        ;;;
        ;;; Pushes the value at a absolute address, to the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.load8_u (local.get $t)))
        (br $loop)

        );;
        ;;; STAk (val addr16 -- val addr16 ) [0x95]
        ;;;
        ;;; Store Absolute
        ;;;
        ;;; Writes a value to a absolute address.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (i32.store8 (local.get $t) (local.get $n))
        (br $loop)

        );;
        ;;; DEIk (device8 -- device8 value) [0x96]
        ;;;
        ;;; Device Input
        ;;;
        ;;; Pushes a value from the device page, to the top of the stack. The
        ;;; target device might capture the reading to trigger an I/O event.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (call $dei (local.get $t)))
        (br $loop)

        );;
        ;;; DEOk (val device8 -- val device8 ) [0x97]
        ;;;
        ;;; Device Output
        ;;;
        ;;; Writes a value to the device page. The target device might capture
        ;;; the writing to trigger an I/O event.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 offset=0x100200 (local.get $t) (local.get $n))
        (call $deo (local.get $t) (local.get $n))
        (br $loop)

        );;
        ;;; ADDk (a b -- a b a+b) [0x98]
        ;;;
        ;;; Add
        ;;;
        ;;; Pushes the sum of the two values at the top of the stack.
        ;;;
        ;;; Example:
        ;;;   #02 #5d ADDk      ( 02 5d 5f )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.add (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; SUBk (a b -- a b a-b) [0x99]
        ;;;
        ;;; Subtract
        ;;;
        ;;; Pushes the difference of the first value minus the second, to the
        ;;; top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.sub (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; MULk (a b -- a b a*b) [0x9a]
        ;;;
        ;;; Multiply
        ;;;
        ;;; Pushes the product of the first and second values at the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.mul (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; DIVk (a b -- a b a/b) [0x9b]
        ;;;
        ;;; Divide
        ;;;
        ;;; Pushes the quotient of the first value over the second, to the top
        ;;; of the stack. A division by zero pushes zero on the stack. The rounding
        ;;; direction is toward zero.
        ;;;
        ;;; Example:
        ;;;   #10 #03 DIVk      ( 10 03 05 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (if (result i32) (i32.eqz (local.get $t)) (then (i32.const 0)) (else (i32.div_u (local.get $n) (local.get $t)))))
        (br $loop)

        );;
        ;;; ANDk (a b -- a b a&b) [0x9c]
        ;;;
        ;;; And
        ;;;
        ;;; Pushes the result of the bitwise operation AND, to the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; ORAk (a b -- a b a|b) [0x9d]
        ;;;
        ;;; Or
        ;;;
        ;;; Pushes the result of the bitwise operation OR, to the top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.or (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; EORk (a b -- a b a^b) [0x9e]
        ;;;
        ;;; Exclusive Or
        ;;;
        ;;; Pushes the result of the bitwise operation XOR, to the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.xor (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; SFTk (a shift8 -- a shift8 c) [0x9f]
        ;;;
        ;;; Shift
        ;;;
        ;;; Shifts the bits of the second value of the stack to the left or right,
        ;;; depending on the control value at the top of the stack. The high nibble
        ;;; of the control value indicates how many bits to shift left, and the
        ;;; low nibble how many bits to shift right. The rightward shift is done
        ;;; first.
        ;;;
        ;;; Example:
        ;;;   #34 #33 SFTk       ( 34 33 30 )
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4))))
        (br $loop)

        );;
        ;;; LIT2 ( --  a) [0xa0]
        ;;;
        ;;; Literal
        ;;;
        ;;; Pushes the next bytes in memory, and moves the PC+2. The LIT opcode
        ;;; always has the keep mode active. Notice how the 0x00 opcode, with
        ;;; the keep bit toggled, is the location of the literal opcodes.
        ;;;
        ;;; Example:
        ;;;   LIT2 abcd       ( ab cd )
        ;;;
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.load8_u (local.get $pc)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.load8_u (i32.and (i32.add (local.get $pc) (i32.const 1)) (i32.const 0xffff))))
        (local.set $pc (i32.add (local.get $pc) (i32.const 2)))
        (br $loop)

        );;
        ;;; INC2k (a -- a a+1) [0xa1]
        ;;;
        ;;; Increment
        ;;;
        ;;; Increments the value at the top of the stack, by 1.
        ;;;
        ;;; Example:
        ;;;   #0001 INC2k     ( 00 01 00 02 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (i32.add (local.get $t) (i32.const 1))) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; POP2k (a -- a ) [0xa2]
        ;;;
        ;;; Pop
        ;;;
        ;;; Removes the value at the top of the stack.
        ;;;
        ;;; Example:
        ;;;   #1234 POP2k  ( 12 34 )
        ;;;
        (br $loop)

        );;
        ;;; NIP2k (a b -- a b b) [0xa3]
        ;;;
        ;;; Nip
        ;;;
        ;;; Removes the second value from the stack. This is practical to convert
        ;;; a short into a byte.
        ;;;
        ;;; Example:
        ;;;   #1234 #5678 NIP2k  ( 12 34 56 78 56 78 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; SWP2k (a b -- a b b a) [0xa4]
        ;;;
        ;;; Swap
        ;;;
        ;;; Exchanges the first and second values at the top of the stack.
        ;;;
        ;;; Example:
        ;;;   #1234 #5678 SWP2k  ( 12 34 56 78 56 78 12 34 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 252)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (local.get $n)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; ROT2k (a b c -- a b c b c a) [0xa5]
        ;;;
        ;;; Rotate
        ;;;
        ;;; Rotates three values at the top of the stack, to the left, wrapping
        ;;; around.
        ;;;
        ;;; Example:
        ;;;   #1234 #5678 #9abc ROT2k  ( 12 34 56 78 9a bc 56 78 9a bc 12 34 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $l (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 4)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 5)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 250)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (local.get $l)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 4)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $n)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 5)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; DUP2k (a -- a a a) [0xa6]
        ;;;
        ;;; Duplicate
        ;;;
        ;;; Duplicates the value at the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 252)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; OVR2k (a b -- a b a b a) [0xa7]
        ;;;
        ;;; Over
        ;;;
        ;;; Duplicates the second value at the top of the stack.
        ;;;
        ;;; Example:
        ;;;   #1234 #5678 OVR2k  ( 12 34 56 78 12 34 56 78 12 34 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 250)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (local.get $n)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 4)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $n)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 5)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; EQU2k (a b -- a b bool8) [0xa8]
        ;;;
        ;;; Equal
        ;;;
        ;;; Pushes 01 to the stack if the two values at the top of the stack are
        ;;; equal, 00 otherwise.
        ;;;
        ;;; Example:
        ;;;   #abcd #abcd EQU2k  ( ab cd ab cd 01 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.eq (local.get $t) (local.get $n)))
        (br $loop)

        );;
        ;;; NEQ2k (a b -- a b bool8) [0xa9]
        ;;;
        ;;; Not Equal
        ;;;
        ;;; Pushes 01 to the stack if the two values at the top of the stack are
        ;;; not equal, 00 otherwise.
        ;;;
        ;;; Example:
        ;;;   #abcd #abcd NEQ2k  ( ab cd ab cd 00 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.ne (local.get $t) (local.get $n)))
        (br $loop)

        );;
        ;;; GTH2k (a b -- a b bool8) [0xaa]
        ;;;
        ;;; Greater Than
        ;;;
        ;;; Pushes 01 to the stack if the second value at the top of the stack
        ;;; is greater than the value at the top of the stack, 00 otherwise.
        ;;;
        ;;; Example:
        ;;;   #1234 #3456 GTH2k  ( 12 34 34 56 00 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.gt_u (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; LTH2k (a b -- a b bool8) [0xab]
        ;;;
        ;;; Lesser Than
        ;;;
        ;;; Pushes 01 to the stack if the second value at the top of the stack
        ;;; is lesser than the value at the top of the stack, 00 otherwise.
        ;;;
        ;;; Example:
        ;;;   #0001 #0000 LTH2k  ( 00 01 00 00 00 )
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.lt_u (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; JMP2k (addr -- addr ) [0xac]
        ;;;
        ;;; Jump
        ;;;
        ;;; Moves the PC by a relative distance equal to the signed byte on the
        ;;; top of the stack, or to an absolute address in short mode.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $pc (local.get $t))
        (br $loop)

        );;
        ;;; JCN2k (cond8 addr -- cond8 addr ) [0xad]
        ;;;
        ;;; Jump Conditional
        ;;;
        ;;; If the byte preceeding the address is not 00, moves the PC by a signed
        ;;; value equal to the byte on the top of the stack, or to an absolute
        ;;; address in short mode.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $pc (select (local.get $t) (local.get $pc) (local.get $n)))
        (br $loop)

        );;
        ;;; JSR2k (addr -- addr | ret16) [0xae]
        ;;;
        ;;; Jump Stash Return
        ;;;
        ;;; Pushes the PC to the return-stack and moves the PC by a signed value
        ;;; equal to the byte on the top of the stack, or to an absolute address
        ;;; in short mode.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (local.get $pc)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (local.set $pc (local.get $t))
        (br $loop)

        );;
        ;;; STH2k (a -- a | a) [0xaf]
        ;;;
        ;;; Stash
        ;;;
        ;;; Moves the value at the top of the stack to the return stack. Note
        ;;; that with the r-mode, the stacks are exchanged and the value is moved
        ;;; from the return stack to the working stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; LDZ2k (addr8 -- addr8 value) [0xb0]
        ;;;
        ;;; Load Zero-Page
        ;;;
        ;;; Pushes the value at an address within the first 256 bytes of memory,
        ;;; to the top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.load8_u (local.get $t)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.load8_u (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xff))))
        (br $loop)

        );;
        ;;; STZ2k (val addr8 -- val addr8 ) [0xb1]
        ;;;
        ;;; Store Zero-Page
        ;;;
        ;;; Writes a value to an address within the first 256 bytes of memory.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (i32.store8 (local.get $t) (local.get $l))
        (i32.store8 (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );;
        ;;; LDR2k (addr8 -- addr8 value) [0xb2]
        ;;;
        ;;; Load Relative
        ;;;
        ;;; Pushes a value at a relative address in relation to the PC, within
        ;;; a range between -128 and +127 bytes, to the top of the stack.
        ;;;
        (local.set $t (i32.load8_s offset=0x100000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.load8_u (local.tee $mval (i32.add (local.get $pc) (local.get $t)))))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.load8_u (i32.and (i32.add (local.get $mval) (i32.const 1)) (i32.const 0xffff))))
        (br $loop)

        );;
        ;;; STR2k (val addr8 -- val addr8 ) [0xb3]
        ;;;
        ;;; Store Relative
        ;;;
        ;;; Writes a value to a relative address in relation to the PC, within
        ;;; a range between -128 and +127 bytes.
        ;;;
        (local.set $t (i32.load8_s offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (i32.store8 (local.tee $mval (i32.and (i32.add (local.get $pc) (local.get $t)) (i32.const 0xffff))) (local.get $l))
        (i32.store8 (i32.and (i32.add (local.get $mval) (i32.const 1)) (i32.const 0xffff)) (local.get $n))
        (br $loop)

        );;
        ;;; LDA2k (addr16 -- addr16 value) [0xb4]
        ;;;
        ;;; Load Absolute
        ;;;
        ;;; Pushes the value at a absolute address, to the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.load8_u (local.get $t)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.load8_u (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xffff))))
        (br $loop)

        );;
        ;;; STA2k (val addr16 -- val addr16 ) [0xb5]
        ;;;
        ;;; Store Absolute
        ;;;
        ;;; Writes a value to a absolute address.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))))
        (i32.store8 (local.get $t) (local.get $l))
        (i32.store8 (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xffff)) (local.get $n))
        (br $loop)

        );;
        ;;; DEI2k (device8 -- device8 value) [0xb6]
        ;;;
        ;;; Device Input
        ;;;
        ;;; Pushes a value from the device page, to the top of the stack. The
        ;;; target device might capture the reading to trigger an I/O event.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (call $dei (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (call $dei (local.get $t)))
        (br $loop)

        );;
        ;;; DEO2k (val device8 -- val device8 ) [0xb7]
        ;;;
        ;;; Device Output
        ;;;
        ;;; Writes a value to the device page. The target device might capture
        ;;; the writing to trigger an I/O event.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (i32.store8 offset=0x100200 (local.get $t) (local.get $l))
        (call $deo (local.get $t) (local.get $l))
        (i32.store8 offset=0x100200 (local.tee $t (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xff))) (local.get $n))
        (call $deo (local.get $t) (local.get $n))
        (br $loop)

        );;
        ;;; ADD2k (a b -- a b a+b) [0xb8]
        ;;;
        ;;; Add
        ;;;
        ;;; Pushes the sum of the two values at the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (i32.add (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; SUB2k (a b -- a b a-b) [0xb9]
        ;;;
        ;;; Subtract
        ;;;
        ;;; Pushes the difference of the first value minus the second, to the
        ;;; top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (i32.sub (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; MUL2k (a b -- a b a*b) [0xba]
        ;;;
        ;;; Multiply
        ;;;
        ;;; Pushes the product of the first and second values at the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (i32.mul (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; DIV2k (a b -- a b a/b) [0xbb]
        ;;;
        ;;; Divide
        ;;;
        ;;; Pushes the quotient of the first value over the second, to the top
        ;;; of the stack. A division by zero pushes zero on the stack. The rounding
        ;;; direction is toward zero.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (if (result i32) (i32.eqz (local.get $t)) (then (i32.const 0)) (else (i32.div_u (local.get $n) (local.get $t))))) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; AND2k (a b -- a b a&b) [0xbc]
        ;;;
        ;;; And
        ;;;
        ;;; Pushes the result of the bitwise operation AND, to the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (i32.and (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; ORA2k (a b -- a b a|b) [0xbd]
        ;;;
        ;;; Or
        ;;;
        ;;; Pushes the result of the bitwise operation OR, to the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (i32.or (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; EOR2k (a b -- a b a^b) [0xbe]
        ;;;
        ;;; Exclusive Or
        ;;;
        ;;; Pushes the result of the bitwise operation XOR, to the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100000 (local.get $wstp)) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (i32.xor (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; SFT2k (a shift8 -- a shift8 c) [0xbf]
        ;;;
        ;;; Shift
        ;;;
        ;;; Shifts the bits of the second value of the stack to the left or right,
        ;;; depending on the control value at the top of the stack. The high nibble
        ;;; of the control value indicates how many bits to shift left, and the
        ;;; low nibble how many bits to shift right. The rightward shift is done
        ;;; first.
        ;;;
        (local.set $t (i32.load8_u offset=0x100000 (local.get $wstp)))
        (local.set $n (i32.or (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4)))) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; LITr ( --  a) [0xc0]
        ;;;
        ;;; Literal
        ;;;
        ;;; Pushes the next bytes in memory, and moves the PC+2. The LIT opcode
        ;;; always has the keep mode active. Notice how the 0x00 opcode, with
        ;;; the keep bit toggled, is the location of the literal opcodes.
        ;;;
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.load8_u (local.get $pc)))
        (local.set $pc (i32.add (local.get $pc) (i32.const 1)))
        (br $loop)

        );;
        ;;; INCkr (a -- a a+1) [0xc1]
        ;;;
        ;;; Increment
        ;;;
        ;;; Increments the value at the top of the stack, by 1.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.add (local.get $t) (i32.const 1)))
        (br $loop)

        );;
        ;;; POPkr (a -- a ) [0xc2]
        ;;;
        ;;; Pop
        ;;;
        ;;; Removes the value at the top of the stack.
        ;;;
        (br $loop)

        );;
        ;;; NIPkr (a b -- a b b) [0xc3]
        ;;;
        ;;; Nip
        ;;;
        ;;; Removes the second value from the stack. This is practical to convert
        ;;; a short into a byte.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (local.get $t))
        (br $loop)

        );;
        ;;; SWPkr (a b -- a b b a) [0xc4]
        ;;;
        ;;; Swap
        ;;;
        ;;; Exchanges the first and second values at the top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (local.get $n))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (br $loop)

        );;
        ;;; ROTkr (a b c -- a b c b c a) [0xc5]
        ;;;
        ;;; Rotate
        ;;;
        ;;; Rotates three values at the top of the stack, to the left, wrapping
        ;;; around.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 253)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (local.get $l))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );;
        ;;; DUPkr (a -- a a a) [0xc6]
        ;;;
        ;;; Duplicate
        ;;;
        ;;; Duplicates the value at the top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (local.get $t))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (br $loop)

        );;
        ;;; OVRkr (a b -- a b a b a) [0xc7]
        ;;;
        ;;; Over
        ;;;
        ;;; Duplicates the second value at the top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 253)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (local.get $n))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );;
        ;;; EQUkr (a b -- a b bool8) [0xc8]
        ;;;
        ;;; Equal
        ;;;
        ;;; Pushes 01 to the stack if the two values at the top of the stack are
        ;;; equal, 00 otherwise.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.eq (local.get $t) (local.get $n)))
        (br $loop)

        );;
        ;;; NEQkr (a b -- a b bool8) [0xc9]
        ;;;
        ;;; Not Equal
        ;;;
        ;;; Pushes 01 to the stack if the two values at the top of the stack are
        ;;; not equal, 00 otherwise.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.ne (local.get $t) (local.get $n)))
        (br $loop)

        );;
        ;;; GTHkr (a b -- a b bool8) [0xca]
        ;;;
        ;;; Greater Than
        ;;;
        ;;; Pushes 01 to the stack if the second value at the top of the stack
        ;;; is greater than the value at the top of the stack, 00 otherwise.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.gt_u (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; LTHkr (a b -- a b bool8) [0xcb]
        ;;;
        ;;; Lesser Than
        ;;;
        ;;; Pushes 01 to the stack if the second value at the top of the stack
        ;;; is lesser than the value at the top of the stack, 00 otherwise.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.lt_u (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; JMPkr (addr -- addr ) [0xcc]
        ;;;
        ;;; Jump
        ;;;
        ;;; Moves the PC by a relative distance equal to the signed byte on the
        ;;; top of the stack, or to an absolute address in short mode.
        ;;;
        (local.set $t (i32.load8_s offset=0x100100 (local.get $rstp)))
        (local.set $pc (i32.add (local.get $pc) (local.get $t)))
        (br $loop)

        );;
        ;;; JCNkr (cond8 addr -- cond8 addr ) [0xcd]
        ;;;
        ;;; Jump Conditional
        ;;;
        ;;; If the byte preceeding the address is not 00, moves the PC by a signed
        ;;; value equal to the byte on the top of the stack, or to an absolute
        ;;; address in short mode.
        ;;;
        (local.set $t (i32.load8_s offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $pc (i32.add (local.get $pc) (select (local.get $t) (i32.const 0) (local.get $n))))
        (br $loop)

        );;
        ;;; JSRkr (addr -- addr | ret16) [0xce]
        ;;;
        ;;; Jump Stash Return
        ;;;
        ;;; Pushes the PC to the return-stack and moves the PC by a signed value
        ;;; equal to the byte on the top of the stack, or to an absolute address
        ;;; in short mode.
        ;;;
        (local.set $t (i32.load8_s offset=0x100100 (local.get $rstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (local.get $pc)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (local.set $pc (i32.add (local.get $pc) (local.get $t)))
        (br $loop)

        );;
        ;;; STHkr (a -- a | a) [0xcf]
        ;;;
        ;;; Stash
        ;;;
        ;;; Moves the value at the top of the stack to the return stack. Note
        ;;; that with the r-mode, the stacks are exchanged and the value is moved
        ;;; from the return stack to the working stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (local.get $t))
        (br $loop)

        );;
        ;;; LDZkr (addr8 -- addr8 value) [0xd0]
        ;;;
        ;;; Load Zero-Page
        ;;;
        ;;; Pushes the value at an address within the first 256 bytes of memory,
        ;;; to the top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.load8_u (local.get $t)))
        (br $loop)

        );;
        ;;; STZkr (val addr8 -- val addr8 ) [0xd1]
        ;;;
        ;;; Store Zero-Page
        ;;;
        ;;; Writes a value to an address within the first 256 bytes of memory.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 (local.get $t) (local.get $n))
        (br $loop)

        );;
        ;;; LDRkr (addr8 -- addr8 value) [0xd2]
        ;;;
        ;;; Load Relative
        ;;;
        ;;; Pushes a value at a relative address in relation to the PC, within
        ;;; a range between -128 and +127 bytes, to the top of the stack.
        ;;;
        (local.set $t (i32.load8_s offset=0x100100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.load8_u (i32.add (local.get $pc) (local.get $t))))
        (br $loop)

        );;
        ;;; STRkr (val addr8 -- val addr8 ) [0xd3]
        ;;;
        ;;; Store Relative
        ;;;
        ;;; Writes a value to a relative address in relation to the PC, within
        ;;; a range between -128 and +127 bytes.
        ;;;
        (local.set $t (i32.load8_s offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 (i32.add (local.get $pc) (local.get $t)) (local.get $n))
        (br $loop)

        );;
        ;;; LDAkr (addr16 -- addr16 value) [0xd4]
        ;;;
        ;;; Load Absolute
        ;;;
        ;;; Pushes the value at a absolute address, to the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.load8_u (local.get $t)))
        (br $loop)

        );;
        ;;; STAkr (val addr16 -- val addr16 ) [0xd5]
        ;;;
        ;;; Store Absolute
        ;;;
        ;;; Writes a value to a absolute address.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (i32.store8 (local.get $t) (local.get $n))
        (br $loop)

        );;
        ;;; DEIkr (device8 -- device8 value) [0xd6]
        ;;;
        ;;; Device Input
        ;;;
        ;;; Pushes a value from the device page, to the top of the stack. The
        ;;; target device might capture the reading to trigger an I/O event.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (call $dei (local.get $t)))
        (br $loop)

        );;
        ;;; DEOkr (val device8 -- val device8 ) [0xd7]
        ;;;
        ;;; Device Output
        ;;;
        ;;; Writes a value to the device page. The target device might capture
        ;;; the writing to trigger an I/O event.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 offset=0x100200 (local.get $t) (local.get $n))
        (call $deo (local.get $t) (local.get $n))
        (br $loop)

        );;
        ;;; ADDkr (a b -- a b a+b) [0xd8]
        ;;;
        ;;; Add
        ;;;
        ;;; Pushes the sum of the two values at the top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.add (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; SUBkr (a b -- a b a-b) [0xd9]
        ;;;
        ;;; Subtract
        ;;;
        ;;; Pushes the difference of the first value minus the second, to the
        ;;; top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.sub (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; MULkr (a b -- a b a*b) [0xda]
        ;;;
        ;;; Multiply
        ;;;
        ;;; Pushes the product of the first and second values at the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.mul (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; DIVkr (a b -- a b a/b) [0xdb]
        ;;;
        ;;; Divide
        ;;;
        ;;; Pushes the quotient of the first value over the second, to the top
        ;;; of the stack. A division by zero pushes zero on the stack. The rounding
        ;;; direction is toward zero.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (if (result i32) (i32.eqz (local.get $t)) (then (i32.const 0)) (else (i32.div_u (local.get $n) (local.get $t)))))
        (br $loop)

        );;
        ;;; ANDkr (a b -- a b a&b) [0xdc]
        ;;;
        ;;; And
        ;;;
        ;;; Pushes the result of the bitwise operation AND, to the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; ORAkr (a b -- a b a|b) [0xdd]
        ;;;
        ;;; Or
        ;;;
        ;;; Pushes the result of the bitwise operation OR, to the top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.or (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; EORkr (a b -- a b a^b) [0xde]
        ;;;
        ;;; Exclusive Or
        ;;;
        ;;; Pushes the result of the bitwise operation XOR, to the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.xor (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; SFTkr (a shift8 -- a shift8 c) [0xdf]
        ;;;
        ;;; Shift
        ;;;
        ;;; Shifts the bits of the second value of the stack to the left or right,
        ;;; depending on the control value at the top of the stack. The high nibble
        ;;; of the control value indicates how many bits to shift left, and the
        ;;; low nibble how many bits to shift right. The rightward shift is done
        ;;; first.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4))))
        (br $loop)

        );;
        ;;; LIT2r ( --  a) [0xe0]
        ;;;
        ;;; Literal
        ;;;
        ;;; Pushes the next bytes in memory, and moves the PC+2. The LIT opcode
        ;;; always has the keep mode active. Notice how the 0x00 opcode, with
        ;;; the keep bit toggled, is the location of the literal opcodes.
        ;;;
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.load8_u (local.get $pc)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.load8_u (i32.and (i32.add (local.get $pc) (i32.const 1)) (i32.const 0xffff))))
        (local.set $pc (i32.add (local.get $pc) (i32.const 2)))
        (br $loop)

        );;
        ;;; INC2kr (a -- a a+1) [0xe1]
        ;;;
        ;;; Increment
        ;;;
        ;;; Increments the value at the top of the stack, by 1.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (i32.add (local.get $t) (i32.const 1))) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; POP2kr (a -- a ) [0xe2]
        ;;;
        ;;; Pop
        ;;;
        ;;; Removes the value at the top of the stack.
        ;;;
        (br $loop)

        );;
        ;;; NIP2kr (a b -- a b b) [0xe3]
        ;;;
        ;;; Nip
        ;;;
        ;;; Removes the second value from the stack. This is practical to convert
        ;;; a short into a byte.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; SWP2kr (a b -- a b b a) [0xe4]
        ;;;
        ;;; Swap
        ;;;
        ;;; Exchanges the first and second values at the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 252)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (local.get $n)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; ROT2kr (a b c -- a b c b c a) [0xe5]
        ;;;
        ;;; Rotate
        ;;;
        ;;; Rotates three values at the top of the stack, to the left, wrapping
        ;;; around.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $l (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 4)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 5)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 250)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (local.get $l)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 4)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $n)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 5)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; DUP2kr (a -- a a a) [0xe6]
        ;;;
        ;;; Duplicate
        ;;;
        ;;; Duplicates the value at the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 252)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; OVR2kr (a b -- a b a b a) [0xe7]
        ;;;
        ;;; Over
        ;;;
        ;;; Duplicates the second value at the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 250)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (local.get $n)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 4)) (i32.const 0xff)) (i32.and (local.tee $val (local.get $n)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 5)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; EQU2kr (a b -- a b bool8) [0xe8]
        ;;;
        ;;; Equal
        ;;;
        ;;; Pushes 01 to the stack if the two values at the top of the stack are
        ;;; equal, 00 otherwise.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.eq (local.get $t) (local.get $n)))
        (br $loop)

        );;
        ;;; NEQ2kr (a b -- a b bool8) [0xe9]
        ;;;
        ;;; Not Equal
        ;;;
        ;;; Pushes 01 to the stack if the two values at the top of the stack are
        ;;; not equal, 00 otherwise.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.ne (local.get $t) (local.get $n)))
        (br $loop)

        );;
        ;;; GTH2kr (a b -- a b bool8) [0xea]
        ;;;
        ;;; Greater Than
        ;;;
        ;;; Pushes 01 to the stack if the second value at the top of the stack
        ;;; is greater than the value at the top of the stack, 00 otherwise.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.gt_u (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; LTH2kr (a b -- a b bool8) [0xeb]
        ;;;
        ;;; Lesser Than
        ;;;
        ;;; Pushes 01 to the stack if the second value at the top of the stack
        ;;; is lesser than the value at the top of the stack, 00 otherwise.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.lt_u (local.get $n) (local.get $t)))
        (br $loop)

        );;
        ;;; JMP2kr (addr -- addr ) [0xec]
        ;;;
        ;;; Jump
        ;;;
        ;;; Moves the PC by a relative distance equal to the signed byte on the
        ;;; top of the stack, or to an absolute address in short mode.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $pc (local.get $t))
        (br $loop)

        );;
        ;;; JCN2kr (cond8 addr -- cond8 addr ) [0xed]
        ;;;
        ;;; Jump Conditional
        ;;;
        ;;; If the byte preceeding the address is not 00, moves the PC by a signed
        ;;; value equal to the byte on the top of the stack, or to an absolute
        ;;; address in short mode.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $pc (select (local.get $t) (local.get $pc) (local.get $n)))
        (br $loop)

        );;
        ;;; JSR2kr (addr -- addr | ret16) [0xee]
        ;;;
        ;;; Jump Stash Return
        ;;;
        ;;; Pushes the PC to the return-stack and moves the PC by a signed value
        ;;; equal to the byte on the top of the stack, or to an absolute address
        ;;; in short mode.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (local.get $pc)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (local.set $pc (local.get $t))
        (br $loop)

        );;
        ;;; STH2kr (a -- a | a) [0xef]
        ;;;
        ;;; Stash
        ;;;
        ;;; Moves the value at the top of the stack to the return stack. Note
        ;;; that with the r-mode, the stacks are exchanged and the value is moved
        ;;; from the return stack to the working stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (local.get $wstp) (i32.and (local.tee $val (local.get $t)) (i32.const 0xff)))
        (i32.store8 offset=0x100000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; LDZ2kr (addr8 -- addr8 value) [0xf0]
        ;;;
        ;;; Load Zero-Page
        ;;;
        ;;; Pushes the value at an address within the first 256 bytes of memory,
        ;;; to the top of the stack.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.load8_u (local.get $t)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.load8_u (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xff))))
        (br $loop)

        );;
        ;;; STZ2kr (val addr8 -- val addr8 ) [0xf1]
        ;;;
        ;;; Store Zero-Page
        ;;;
        ;;; Writes a value to an address within the first 256 bytes of memory.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (i32.store8 (local.get $t) (local.get $l))
        (i32.store8 (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );;
        ;;; LDR2kr (addr8 -- addr8 value) [0xf2]
        ;;;
        ;;; Load Relative
        ;;;
        ;;; Pushes a value at a relative address in relation to the PC, within
        ;;; a range between -128 and +127 bytes, to the top of the stack.
        ;;;
        (local.set $t (i32.load8_s offset=0x100100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.load8_u (local.tee $mval (i32.add (local.get $pc) (local.get $t)))))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.load8_u (i32.and (i32.add (local.get $mval) (i32.const 1)) (i32.const 0xffff))))
        (br $loop)

        );;
        ;;; STR2kr (val addr8 -- val addr8 ) [0xf3]
        ;;;
        ;;; Store Relative
        ;;;
        ;;; Writes a value to a relative address in relation to the PC, within
        ;;; a range between -128 and +127 bytes.
        ;;;
        (local.set $t (i32.load8_s offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (i32.store8 (local.tee $mval (i32.and (i32.add (local.get $pc) (local.get $t)) (i32.const 0xffff))) (local.get $l))
        (i32.store8 (i32.and (i32.add (local.get $mval) (i32.const 1)) (i32.const 0xffff)) (local.get $n))
        (br $loop)

        );;
        ;;; LDA2kr (addr16 -- addr16 value) [0xf4]
        ;;;
        ;;; Load Absolute
        ;;;
        ;;; Pushes the value at a absolute address, to the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.load8_u (local.get $t)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.load8_u (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xffff))))
        (br $loop)

        );;
        ;;; STA2kr (val addr16 -- val addr16 ) [0xf5]
        ;;;
        ;;; Store Absolute
        ;;;
        ;;; Writes a value to a absolute address.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))))
        (i32.store8 (local.get $t) (local.get $l))
        (i32.store8 (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xffff)) (local.get $n))
        (br $loop)

        );;
        ;;; DEI2kr (device8 -- device8 value) [0xf6]
        ;;;
        ;;; Device Input
        ;;;
        ;;; Pushes a value from the device page, to the top of the stack. The
        ;;; target device might capture the reading to trigger an I/O event.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (call $dei (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (call $dei (local.get $t)))
        (br $loop)

        );;
        ;;; DEO2kr (val device8 -- val device8 ) [0xf7]
        ;;;
        ;;; Device Output
        ;;;
        ;;; Writes a value to the device page. The target device might capture
        ;;; the writing to trigger an I/O event.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (i32.store8 offset=0x100200 (local.get $t) (local.get $l))
        (call $deo (local.get $t) (local.get $l))
        (i32.store8 offset=0x100200 (local.tee $t (i32.and (i32.add (local.get $t) (i32.const 1)) (i32.const 0xff))) (local.get $n))
        (call $deo (local.get $t) (local.get $n))
        (br $loop)

        );;
        ;;; ADD2kr (a b -- a b a+b) [0xf8]
        ;;;
        ;;; Add
        ;;;
        ;;; Pushes the sum of the two values at the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (i32.add (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; SUB2kr (a b -- a b a-b) [0xf9]
        ;;;
        ;;; Subtract
        ;;;
        ;;; Pushes the difference of the first value minus the second, to the
        ;;; top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (i32.sub (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; MUL2kr (a b -- a b a*b) [0xfa]
        ;;;
        ;;; Multiply
        ;;;
        ;;; Pushes the product of the first and second values at the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (i32.mul (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; DIV2kr (a b -- a b a/b) [0xfb]
        ;;;
        ;;; Divide
        ;;;
        ;;; Pushes the quotient of the first value over the second, to the top
        ;;; of the stack. A division by zero pushes zero on the stack. The rounding
        ;;; direction is toward zero.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (if (result i32) (i32.eqz (local.get $t)) (then (i32.const 0)) (else (i32.div_u (local.get $n) (local.get $t))))) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; AND2kr (a b -- a b a&b) [0xfc]
        ;;;
        ;;; And
        ;;;
        ;;; Pushes the result of the bitwise operation AND, to the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (i32.and (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; ORA2kr (a b -- a b a|b) [0xfd]
        ;;;
        ;;; Or
        ;;;
        ;;; Pushes the result of the bitwise operation OR, to the top of the stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (i32.or (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; EOR2kr (a b -- a b a^b) [0xfe]
        ;;;
        ;;; Exclusive Or
        ;;;
        ;;; Pushes the result of the bitwise operation XOR, to the top of the
        ;;; stack.
        ;;;
        (local.set $t (i32.or (i32.load8_u offset=0x100100 (local.get $rstp)) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8))))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (i32.xor (local.get $n) (local.get $t))) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)

        );;
        ;;; SFT2kr (a shift8 -- a shift8 c) [0xff]
        ;;;
        ;;; Shift
        ;;;
        ;;; Shifts the bits of the second value of the stack to the left or right,
        ;;; depending on the control value at the top of the stack. The high nibble
        ;;; of the control value indicates how many bits to shift left, and the
        ;;; low nibble how many bits to shift right. The rightward shift is done
        ;;; first.
        ;;;
        (local.set $t (i32.load8_u offset=0x100100 (local.get $rstp)))
        (local.set $n (i32.or (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.shl (i32.load8_u offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.const 8))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (local.get $rstp) (i32.and (local.tee $val (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4)))) (i32.const 0xff)))
        (i32.store8 offset=0x100100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.get $val) (i32.const 8)))
        (br $loop)))

    (global.set $wstp (local.get $wstp))
    (global.set $rstp (local.get $rstp)))

  (func $reset (export "reset")
    (global.set $wstp (i32.const 0x00))
    (global.set $rstp (i32.const 0x00))
    (memory.fill (i32.const 0x0) (i32.const 0x0) (i32.const 0x100300)))

  (func (export "wstp") (result i32) (global.get $wstp))
  (func (export "rstp") (result i32) (global.get $rstp))

  (memory (export "memory") 17)

  (global $wstp (mut i32) (i32.const 0))
  (global $rstp (mut i32) (i32.const 0)))
