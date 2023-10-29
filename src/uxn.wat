(module $uxn
  (import "system" "deo" (func $deo (param i32) (param i32)))
  (import "system" "dei" (func $dei (param i32) (result i32)))

  (func (export "eval") (param $pc i32)
    (local $wstp i32)
    (local $rstp i32)
    (local $t i32)
    (local $n i32)
    (local $l i32)
    (local $ins i32)
    (local $val i32)
    (local $signedswap_val i32)

    (if (i32.eqz (local.get $pc)) (then (return)))
    (if (i32.load8_u (i32.const 0x1020f)) (then (return)))

    (local.set $wstp (global.get $wstp))
    (local.set $rstp (global.get $rstp))
    (block $endLoop
      (loop $loop
        (local.set $ins (i32.load8_u (local.get $pc)))
        (local.set $pc (i32.add (local.get $pc) (i32.const 1)))

        ;; Uxntal Opcodes
        ;; https://wiki.xxiivv.com/site/uxntal_opcodes.html

        (block $SFT2kr (block $EOR2kr (block $ORA2kr (block $AND2kr (block $DIV2kr (block $MUL2kr (block $SUB2kr (block $ADD2kr (block $DEO2kr (block $DEI2kr (block $STA2kr (block $LDA2kr (block $STR2kr (block $LDR2kr (block $STZ2kr (block $LDZ2kr 
        (block $STH2kr (block $JSR2kr (block $JCN2kr (block $JMP2kr (block $LTH2kr (block $GTH2kr (block $NEQ2kr (block $EQU2kr (block $OVR2kr (block $DUP2kr (block $ROT2kr (block $SWP2kr (block $NIP2kr (block $POP2kr (block $INC2kr (block $LIT2r 
        (block $SFTkr (block $EORkr (block $ORAkr (block $ANDkr (block $DIVkr (block $MULkr (block $SUBkr (block $ADDkr (block $DEOkr (block $DEIkr (block $STAkr (block $LDAkr (block $STRkr (block $LDRkr (block $STZkr (block $LDZkr 
        (block $STHkr (block $JSRkr (block $JCNkr (block $JMPkr (block $LTHkr (block $GTHkr (block $NEQkr (block $EQUkr (block $OVRkr (block $DUPkr (block $ROTkr (block $SWPkr (block $NIPkr (block $POPkr (block $INCkr (block $LITr 
        (block $SFT2k (block $EOR2k (block $ORA2k (block $AND2k (block $DIV2k (block $MUL2k (block $SUB2k (block $ADD2k (block $DEO2k (block $DEI2k (block $STA2k (block $LDA2k (block $STR2k (block $LDR2k (block $STZ2k (block $LDZ2k 
        (block $STH2k (block $JSR2k (block $JCN2k (block $JMP2k (block $LTH2k (block $GTH2k (block $NEQ2k (block $EQU2k (block $OVR2k (block $DUP2k (block $ROT2k (block $SWP2k (block $NIP2k (block $POP2k (block $INC2k (block $LIT2 
        (block $SFTk (block $EORk (block $ORAk (block $ANDk (block $DIVk (block $MULk (block $SUBk (block $ADDk (block $DEOk (block $DEIk (block $STAk (block $LDAk (block $STRk (block $LDRk (block $STZk (block $LDZk 
        (block $STHk (block $JSRk (block $JCNk (block $JMPk (block $LTHk (block $GTHk (block $NEQk (block $EQUk (block $OVRk (block $DUPk (block $ROTk (block $SWPk (block $NIPk (block $POPk (block $INCk (block $LIT 
        (block $SFT2r (block $EOR2r (block $ORA2r (block $AND2r (block $DIV2r (block $MUL2r (block $SUB2r (block $ADD2r (block $DEO2r (block $DEI2r (block $STA2r (block $LDA2r (block $STR2r (block $LDR2r (block $STZ2r (block $LDZ2r 
        (block $STH2r (block $JSR2r (block $JCN2r (block $JMP2r (block $LTH2r (block $GTH2r (block $NEQ2r (block $EQU2r (block $OVR2r (block $DUP2r (block $ROT2r (block $SWP2r (block $NIP2r (block $POP2r (block $INC2r (block $JSI 
        (block $SFTr (block $EORr (block $ORAr (block $ANDr (block $DIVr (block $MULr (block $SUBr (block $ADDr (block $DEOr (block $DEIr (block $STAr (block $LDAr (block $STRr (block $LDRr (block $STZr (block $LDZr 
        (block $STHr (block $JSRr (block $JCNr (block $JMPr (block $LTHr (block $GTHr (block $NEQr (block $EQUr (block $OVRr (block $DUPr (block $ROTr (block $SWPr (block $NIPr (block $POPr (block $INCr (block $JMI 
        (block $SFT2 (block $EOR2 (block $ORA2 (block $AND2 (block $DIV2 (block $MUL2 (block $SUB2 (block $ADD2 (block $DEO2 (block $DEI2 (block $STA2 (block $LDA2 (block $STR2 (block $LDR2 (block $STZ2 (block $LDZ2 
        (block $STH2 (block $JSR2 (block $JCN2 (block $JMP2 (block $LTH2 (block $GTH2 (block $NEQ2 (block $EQU2 (block $OVR2 (block $DUP2 (block $ROT2 (block $SWP2 (block $NIP2 (block $POP2 (block $INC2 (block $JCI 
        (block $SFT (block $EOR (block $ORA (block $AND (block $DIV (block $MUL (block $SUB (block $ADD (block $DEO (block $DEI (block $STA (block $LDA (block $STR (block $LDR (block $STZ (block $LDZ 
        (block $STH (block $JSR (block $JCN (block $JMP (block $LTH (block $GTH (block $NEQ (block $EQU (block $OVR (block $DUP (block $ROT (block $SWP (block $NIP (block $POP (block $INC (block $BRK 
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
          (local.get $ins))

        );; BRK
        (br $endLoop)

        );; INC
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.add (local.get $t) (i32.const 1)))
        (br $loop)

        );; POP
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (br $loop)

        );; NIP
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $t))
        (br $loop)

        );; SWP
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $n))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (br $loop)

        );; ROT
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $l))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );; DUP
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $t))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (br $loop)

        );; OVR
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $n))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );; EQU
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.eq (local.get $t) (local.get $n)))
        (br $loop)

        );; NEQ
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.ne (local.get $t) (local.get $n)))
        (br $loop)

        );; GTH
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.gt_u (local.get $n) (local.get $t)))
        (br $loop)

        );; LTH
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.lt_u (local.get $n) (local.get $t)))
        (br $loop)

        );; JMP
        (local.set $t (i32.load8_s offset=0x10000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (local.set $pc (i32.add (local.get $pc) (local.get $t)))
        (br $loop)

        );; JCN
        (local.set $t (i32.load8_s offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (if (local.get $n) (then (local.set $pc (i32.add (local.get $pc) (local.get $t)))))
        (br $loop)

        );; JSR
        (local.set $t (i32.load8_s offset=0x10000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $pc)) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (local.set $pc (i32.add (local.get $pc) (local.get $t)))
        (br $loop)

        );; STH
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $t))
        (br $loop)

        );; LDZ
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.load8_u (local.get $t)))
        (br $loop)

        );; STZ
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 (local.get $t) (local.get $n))
        (br $loop)

        );; LDR
        (local.set $t (i32.load8_s offset=0x10000 (local.get $wstp)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.load8_u (i32.add (local.get $pc) (local.get $t))))
        (br $loop)

        );; STR
        (local.set $t (i32.load8_s offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 (i32.add (local.get $pc) (local.get $t)) (local.get $n))
        (br $loop)

        );; LDA
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.load8_u (local.get $t)))
        (br $loop)

        );; STA
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 (local.get $t) (local.get $n))
        (br $loop)

        );; DEI
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (i32.store8 offset=0x10000 (local.get $wstp) (call $dei (local.get $t)))
        (br $loop)

        );; DEO
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 (i32.add (i32.const 0x10200) (local.get $t)) (local.get $n))
        (call $deo (local.get $t) (local.get $n))
        (br $loop)

        );; ADD
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.add (local.get $n) (local.get $t)))
        (br $loop)

        );; SUB
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.sub (local.get $n) (local.get $t)))
        (br $loop)

        );; MUL
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.mul (local.get $n) (local.get $t)))
        (br $loop)

        );; DIV
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (if (result i32) (i32.eqz (local.get $t)) (then (i32.const 0)) (else (i32.div_u (local.get $n) (local.get $t)))))
        (br $loop)

        );; AND
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.and (local.get $n) (local.get $t)))
        (br $loop)

        );; ORA
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.or (local.get $n) (local.get $t)))
        (br $loop)

        );; EOR
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.xor (local.get $n) (local.get $t)))
        (br $loop)

        );; SFT
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4))))
        (br $loop)

        );; JCI
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (if (local.get $t) (then (local.set $pc (i32.add (i32.const 2) (i32.add (local.get $pc) (i32.shr_s (i32.or (i32.shl (i32.and (local.tee $signedswap_val (i32.load16_u (local.get $pc))) (i32.const 0xff)) (i32.const 24)) (i32.shl (i32.and (local.get $signedswap_val) (i32.const 0xff00)) (i32.const 8))) (i32.const 16)))))) (else (local.set $pc (i32.add (local.get $pc) (i32.const 2)))))
        (br $loop)

        );; INC2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.add (local.get $t) (i32.const 1))) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; POP2
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (br $loop)

        );; NIP2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; SWP2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $n)) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; ROT2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $l (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 5)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 4)) (i32.const 0xff)))))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $l)) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (local.get $val))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 5)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $n)) (i32.const 8)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 4)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; DUP2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; OVR2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $n)) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (local.get $val))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 5)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $n)) (i32.const 8)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 4)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; EQU2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.eq (local.get $t) (local.get $n)))
        (br $loop)

        );; NEQ2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.ne (local.get $t) (local.get $n)))
        (br $loop)

        );; GTH2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.gt_u (local.get $n) (local.get $t)))
        (br $loop)

        );; LTH2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.lt_u (local.get $n) (local.get $t)))
        (br $loop)

        );; JMP2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (local.set $pc (local.get $t))
        (br $loop)

        );; JCN2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))
        (if (local.get $n) (then (local.set $pc (local.get $t))))
        (br $loop)

        );; JSR2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $pc)) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (local.set $pc (local.get $t))
        (br $loop)

        );; STH2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; LDZ2
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.shr_u (local.tee $val (i32.load16_u (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; STZ2
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store16 (local.get $t) (local.get $n))
        (br $loop)

        );; LDR2
        (local.set $t (i32.load8_s offset=0x10000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.shr_u (local.tee $val (i32.load16_u (i32.add (local.get $pc) (local.get $t)))) (i32.const 8)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; STR2
        (local.set $t (i32.load8_s offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store16 (i32.add (local.get $pc) (local.get $t)) (local.get $n))
        (br $loop)

        );; LDA2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.shr_u (local.tee $val (i32.load16_u (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; STA2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 4)) (i32.const 0xff)))
        (i32.store16 (local.get $t) (local.get $n))
        (br $loop)

        );; DEI2
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (call $dei (i32.add (local.get $t) (i32.const 1))))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (call $dei (local.get $t)))
        (br $loop)

        );; DEO2
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 (i32.add (i32.const 0x10200) (local.get $t)) (local.get $l))
        (call $deo (local.get $t) (local.get $l))
        (i32.store8 (i32.add (i32.const 0x10201) (local.get $t)) (local.get $n))
        (call $deo (i32.add (local.get $t) (i32.const 1)) (local.get $n))
        (br $loop)

        );; ADD2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.add (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; SUB2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.sub (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; MUL2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.mul (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; DIV2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (if (result i32) (i32.eqz (local.get $t)) (then (i32.const 0)) (else (i32.div_u (local.get $n) (local.get $t))))) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; AND2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.and (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; ORA2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.or (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; EOR2
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.xor (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; SFT2
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4)))) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; JMI
        (local.set $pc (i32.add (i32.const 2) (i32.add (local.get $pc) (i32.shr_s (i32.or (i32.shl (i32.and (local.tee $signedswap_val (i32.load16_u (local.get $pc))) (i32.const 0xff)) (i32.const 24)) (i32.shl (i32.and (local.get $signedswap_val) (i32.const 0xff00)) (i32.const 8))) (i32.const 16)))))
        (br $loop)

        );; INCr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.add (local.get $t) (i32.const 1)))
        (br $loop)

        );; POPr
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (br $loop)

        );; NIPr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $t))
        (br $loop)

        );; SWPr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $n))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (br $loop)

        );; ROTr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $l))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );; DUPr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $t))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (br $loop)

        );; OVRr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $n))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );; EQUr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.eq (local.get $t) (local.get $n)))
        (br $loop)

        );; NEQr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.ne (local.get $t) (local.get $n)))
        (br $loop)

        );; GTHr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.gt_u (local.get $n) (local.get $t)))
        (br $loop)

        );; LTHr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.lt_u (local.get $n) (local.get $t)))
        (br $loop)

        );; JMPr
        (local.set $t (i32.load8_s offset=0x10100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (local.set $pc (i32.add (local.get $pc) (local.get $t)))
        (br $loop)

        );; JCNr
        (local.set $t (i32.load8_s offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (if (local.get $n) (then (local.set $pc (i32.add (local.get $pc) (local.get $t)))))
        (br $loop)

        );; JSRr
        (local.set $t (i32.load8_s offset=0x10100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $pc)) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (local.set $pc (i32.add (local.get $pc) (local.get $t)))
        (br $loop)

        );; STHr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $t))
        (br $loop)

        );; LDZr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.load8_u (local.get $t)))
        (br $loop)

        );; STZr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 (local.get $t) (local.get $n))
        (br $loop)

        );; LDRr
        (local.set $t (i32.load8_s offset=0x10100 (local.get $rstp)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.load8_u (i32.add (local.get $pc) (local.get $t))))
        (br $loop)

        );; STRr
        (local.set $t (i32.load8_s offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 (i32.add (local.get $pc) (local.get $t)) (local.get $n))
        (br $loop)

        );; LDAr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.load8_u (local.get $t)))
        (br $loop)

        );; STAr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 (local.get $t) (local.get $n))
        (br $loop)

        );; DEIr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (i32.store8 offset=0x10100 (local.get $rstp) (call $dei (local.get $t)))
        (br $loop)

        );; DEOr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 (i32.add (i32.const 0x10200) (local.get $t)) (local.get $n))
        (call $deo (local.get $t) (local.get $n))
        (br $loop)

        );; ADDr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.add (local.get $n) (local.get $t)))
        (br $loop)

        );; SUBr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.sub (local.get $n) (local.get $t)))
        (br $loop)

        );; MULr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.mul (local.get $n) (local.get $t)))
        (br $loop)

        );; DIVr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (if (result i32) (i32.eqz (local.get $t)) (then (i32.const 0)) (else (i32.div_u (local.get $n) (local.get $t)))))
        (br $loop)

        );; ANDr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.and (local.get $n) (local.get $t)))
        (br $loop)

        );; ORAr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.or (local.get $n) (local.get $t)))
        (br $loop)

        );; EORr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.xor (local.get $n) (local.get $t)))
        (br $loop)

        );; SFTr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4))))
        (br $loop)

        );; JSI
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.tee $n (i32.add (local.get $pc) (i32.const 2)))) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (local.set $pc (i32.add (local.get $n) (i32.shr_s (i32.or (i32.shl (i32.and (local.tee $signedswap_val (i32.load16_u (local.get $pc))) (i32.const 0xff)) (i32.const 24)) (i32.shl (i32.and (local.get $signedswap_val) (i32.const 0xff00)) (i32.const 8))) (i32.const 16))))
        (br $loop)

        );; INC2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.add (local.get $t) (i32.const 1))) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; POP2r
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (br $loop)

        );; NIP2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; SWP2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $n)) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; ROT2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $l (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 5)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 4)) (i32.const 0xff)))))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $l)) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (local.get $val))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 5)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $n)) (i32.const 8)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 4)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; DUP2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; OVR2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $n)) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (local.get $val))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 5)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $n)) (i32.const 8)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 4)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; EQU2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.eq (local.get $t) (local.get $n)))
        (br $loop)

        );; NEQ2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.ne (local.get $t) (local.get $n)))
        (br $loop)

        );; GTH2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.gt_u (local.get $n) (local.get $t)))
        (br $loop)

        );; LTH2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.lt_u (local.get $n) (local.get $t)))
        (br $loop)

        );; JMP2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (local.set $pc (local.get $t))
        (br $loop)

        );; JCN2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))
        (if (local.get $n) (then (local.set $pc (local.get $t))))
        (br $loop)

        );; JSR2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $pc)) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (local.set $pc (local.get $t))
        (br $loop)

        );; STH2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; LDZ2r
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.shr_u (local.tee $val (i32.load16_u (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; STZ2r
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store16 (local.get $t) (local.get $n))
        (br $loop)

        );; LDR2r
        (local.set $t (i32.load8_s offset=0x10100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.shr_u (local.tee $val (i32.load16_u (i32.add (local.get $pc) (local.get $t)))) (i32.const 8)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; STR2r
        (local.set $t (i32.load8_s offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store16 (i32.add (local.get $pc) (local.get $t)) (local.get $n))
        (br $loop)

        );; LDA2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.shr_u (local.tee $val (i32.load16_u (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; STA2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 4)) (i32.const 0xff)))
        (i32.store16 (local.get $t) (local.get $n))
        (br $loop)

        );; DEI2r
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (call $dei (i32.add (local.get $t) (i32.const 1))))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (call $dei (local.get $t)))
        (br $loop)

        );; DEO2r
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))
        (i32.store8 (i32.add (i32.const 0x10200) (local.get $t)) (local.get $l))
        (call $deo (local.get $t) (local.get $l))
        (i32.store8 (i32.add (i32.const 0x10201) (local.get $t)) (local.get $n))
        (call $deo (i32.add (local.get $t) (i32.const 1)) (local.get $n))
        (br $loop)

        );; ADD2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.add (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; SUB2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.sub (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; MUL2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.mul (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; DIV2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (if (result i32) (i32.eqz (local.get $t)) (then (i32.const 0)) (else (i32.div_u (local.get $n) (local.get $t))))) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; AND2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.and (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; ORA2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.or (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; EOR2r
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.xor (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; SFT2r
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4)))) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; LIT
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.load8_u (local.get $pc)))
        (local.set $pc (i32.add (local.get $pc) (i32.const 1)))
        (br $loop)

        );; INCk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.add (local.get $t) (i32.const 1)))
        (br $loop)

        );; POPk
        (br $loop)

        );; NIPk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $t))
        (br $loop)

        );; SWPk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $n))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (br $loop)

        );; ROTk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 253)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $l))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );; DUPk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $t))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (br $loop)

        );; OVRk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 253)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $n))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );; EQUk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.eq (local.get $t) (local.get $n)))
        (br $loop)

        );; NEQk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.ne (local.get $t) (local.get $n)))
        (br $loop)

        );; GTHk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.gt_u (local.get $n) (local.get $t)))
        (br $loop)

        );; LTHk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.lt_u (local.get $n) (local.get $t)))
        (br $loop)

        );; JMPk
        (local.set $t (i32.load8_s offset=0x10000 (local.get $wstp)))
        (local.set $pc (i32.add (local.get $pc) (local.get $t)))
        (br $loop)

        );; JCNk
        (local.set $t (i32.load8_s offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (if (local.get $n) (then (local.set $pc (i32.add (local.get $pc) (local.get $t)))))
        (br $loop)

        );; JSRk
        (local.set $t (i32.load8_s offset=0x10000 (local.get $wstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $pc)) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (local.set $pc (i32.add (local.get $pc) (local.get $t)))
        (br $loop)

        );; STHk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $t))
        (br $loop)

        );; LDZk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.load8_u (local.get $t)))
        (br $loop)

        );; STZk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 (local.get $t) (local.get $n))
        (br $loop)

        );; LDRk
        (local.set $t (i32.load8_s offset=0x10000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.load8_u (i32.add (local.get $pc) (local.get $t))))
        (br $loop)

        );; STRk
        (local.set $t (i32.load8_s offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 (i32.add (local.get $pc) (local.get $t)) (local.get $n))
        (br $loop)

        );; LDAk
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.load8_u (local.get $t)))
        (br $loop)

        );; STAk
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (i32.store8 (local.get $t) (local.get $n))
        (br $loop)

        );; DEIk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (call $dei (local.get $t)))
        (br $loop)

        );; DEOk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 (i32.add (i32.const 0x10200) (local.get $t)) (local.get $n))
        (call $deo (local.get $t) (local.get $n))
        (br $loop)

        );; ADDk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.add (local.get $n) (local.get $t)))
        (br $loop)

        );; SUBk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.sub (local.get $n) (local.get $t)))
        (br $loop)

        );; MULk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.mul (local.get $n) (local.get $t)))
        (br $loop)

        );; DIVk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (if (result i32) (i32.eqz (local.get $t)) (then (i32.const 0)) (else (i32.div_u (local.get $n) (local.get $t)))))
        (br $loop)

        );; ANDk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.and (local.get $n) (local.get $t)))
        (br $loop)

        );; ORAk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.or (local.get $n) (local.get $t)))
        (br $loop)

        );; EORk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.xor (local.get $n) (local.get $t)))
        (br $loop)

        );; SFTk
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4))))
        (br $loop)

        );; LIT2
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.shr_u (local.tee $val (i32.load16_u (local.get $pc))) (i32.const 8)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $val))
        (local.set $pc (i32.add (local.get $pc) (i32.const 2)))
        (br $loop)

        );; INC2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.add (local.get $t) (i32.const 1))) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; POP2k
        (br $loop)

        );; NIP2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; SWP2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 252)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $n)) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; ROT2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $l (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 5)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 4)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 250)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $l)) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (local.get $val))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 5)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $n)) (i32.const 8)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 4)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; DUP2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 252)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; OVR2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 250)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $n)) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)) (local.get $val))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 5)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $n)) (i32.const 8)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 4)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; EQU2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.eq (local.get $t) (local.get $n)))
        (br $loop)

        );; NEQ2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.ne (local.get $t) (local.get $n)))
        (br $loop)

        );; GTH2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.gt_u (local.get $n) (local.get $t)))
        (br $loop)

        );; LTH2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.lt_u (local.get $n) (local.get $t)))
        (br $loop)

        );; JMP2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $pc (local.get $t))
        (br $loop)

        );; JCN2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (if (local.get $n) (then (local.set $pc (local.get $t))))
        (br $loop)

        );; JSR2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $pc)) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (local.set $pc (local.get $t))
        (br $loop)

        );; STH2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; LDZ2k
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.shr_u (local.tee $val (i32.load16_u (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; STZ2k
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (i32.store16 (local.get $t) (local.get $n))
        (br $loop)

        );; LDR2k
        (local.set $t (i32.load8_s offset=0x10000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.shr_u (local.tee $val (i32.load16_u (i32.add (local.get $pc) (local.get $t)))) (i32.const 8)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; STR2k
        (local.set $t (i32.load8_s offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (i32.store16 (i32.add (local.get $pc) (local.get $t)) (local.get $n))
        (br $loop)

        );; LDA2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (i32.shr_u (local.tee $val (i32.load16_u (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; STA2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff)))))
        (i32.store16 (local.get $t) (local.get $n))
        (br $loop)

        );; DEI2k
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (call $dei (i32.add (local.get $t) (i32.const 1))))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (call $dei (local.get $t)))
        (br $loop)

        );; DEO2k
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))))
        (i32.store8 (i32.add (i32.const 0x10200) (local.get $t)) (local.get $l))
        (call $deo (local.get $t) (local.get $l))
        (i32.store8 (i32.add (i32.const 0x10201) (local.get $t)) (local.get $n))
        (call $deo (i32.add (local.get $t) (i32.const 1)) (local.get $n))
        (br $loop)

        );; ADD2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.add (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; SUB2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.sub (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; MUL2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.mul (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; DIV2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (if (result i32) (i32.eqz (local.get $t)) (then (i32.const 0)) (else (i32.div_u (local.get $n) (local.get $t))))) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; AND2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.and (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; ORA2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.or (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; EOR2k
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (local.get $wstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.xor (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; SFT2k
        (local.set $t (i32.load8_u offset=0x10000 (local.get $wstp)))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 2)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4)))) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; LITr
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.load8_u (local.get $pc)))
        (local.set $pc (i32.add (local.get $pc) (i32.const 1)))
        (br $loop)

        );; INCkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.add (local.get $t) (i32.const 1)))
        (br $loop)

        );; POPkr
        (br $loop)

        );; NIPkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $t))
        (br $loop)

        );; SWPkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $n))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (br $loop)

        );; ROTkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 253)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $l))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );; DUPkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $t))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (br $loop)

        );; OVRkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 253)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $n))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $t))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (local.get $n))
        (br $loop)

        );; EQUkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.eq (local.get $t) (local.get $n)))
        (br $loop)

        );; NEQkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.ne (local.get $t) (local.get $n)))
        (br $loop)

        );; GTHkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.gt_u (local.get $n) (local.get $t)))
        (br $loop)

        );; LTHkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.lt_u (local.get $n) (local.get $t)))
        (br $loop)

        );; JMPkr
        (local.set $t (i32.load8_s offset=0x10100 (local.get $rstp)))
        (local.set $pc (i32.add (local.get $pc) (local.get $t)))
        (br $loop)

        );; JCNkr
        (local.set $t (i32.load8_s offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (if (local.get $n) (then (local.set $pc (i32.add (local.get $pc) (local.get $t)))))
        (br $loop)

        );; JSRkr
        (local.set $t (i32.load8_s offset=0x10100 (local.get $rstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $pc)) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (local.set $pc (i32.add (local.get $pc) (local.get $t)))
        (br $loop)

        );; STHkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $t))
        (br $loop)

        );; LDZkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.load8_u (local.get $t)))
        (br $loop)

        );; STZkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 (local.get $t) (local.get $n))
        (br $loop)

        );; LDRkr
        (local.set $t (i32.load8_s offset=0x10100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.load8_u (i32.add (local.get $pc) (local.get $t))))
        (br $loop)

        );; STRkr
        (local.set $t (i32.load8_s offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 (i32.add (local.get $pc) (local.get $t)) (local.get $n))
        (br $loop)

        );; LDAkr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.load8_u (local.get $t)))
        (br $loop)

        );; STAkr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (i32.store8 (local.get $t) (local.get $n))
        (br $loop)

        );; DEIkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (call $dei (local.get $t)))
        (br $loop)

        );; DEOkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (i32.store8 (i32.add (i32.const 0x10200) (local.get $t)) (local.get $n))
        (call $deo (local.get $t) (local.get $n))
        (br $loop)

        );; ADDkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.add (local.get $n) (local.get $t)))
        (br $loop)

        );; SUBkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.sub (local.get $n) (local.get $t)))
        (br $loop)

        );; MULkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.mul (local.get $n) (local.get $t)))
        (br $loop)

        );; DIVkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (if (result i32) (i32.eqz (local.get $t)) (then (i32.const 0)) (else (i32.div_u (local.get $n) (local.get $t)))))
        (br $loop)

        );; ANDkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.and (local.get $n) (local.get $t)))
        (br $loop)

        );; ORAkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.or (local.get $n) (local.get $t)))
        (br $loop)

        );; EORkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.xor (local.get $n) (local.get $t)))
        (br $loop)

        );; SFTkr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4))))
        (br $loop)

        );; LIT2r
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.shr_u (local.tee $val (i32.load16_u (local.get $pc))) (i32.const 8)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $val))
        (local.set $pc (i32.add (local.get $pc) (i32.const 2)))
        (br $loop)

        );; INC2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.add (local.get $t) (i32.const 1))) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; POP2kr
        (br $loop)

        );; NIP2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; SWP2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 252)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $n)) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; ROT2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $l (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 5)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 4)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 250)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $l)) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (local.get $val))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 5)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $n)) (i32.const 8)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 4)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; DUP2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 252)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; OVR2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 250)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $n)) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)) (local.get $val))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 5)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $n)) (i32.const 8)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 4)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; EQU2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.eq (local.get $t) (local.get $n)))
        (br $loop)

        );; NEQ2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.ne (local.get $t) (local.get $n)))
        (br $loop)

        );; GTH2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.gt_u (local.get $n) (local.get $t)))
        (br $loop)

        );; LTH2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 255)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.lt_u (local.get $n) (local.get $t)))
        (br $loop)

        );; JMP2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $pc (local.get $t))
        (br $loop)

        );; JCN2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (if (local.get $n) (then (local.set $pc (local.get $t))))
        (br $loop)

        );; JSR2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $pc)) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (local.set $pc (local.get $t))
        (br $loop)

        );; STH2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $wstp (i32.and (i32.add (local.get $wstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10000 (i32.and (i32.add (local.get $wstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (local.get $t)) (i32.const 8)))
        (i32.store8 offset=0x10000 (local.get $wstp) (local.get $val))
        (br $loop)

        );; LDZ2kr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.shr_u (local.tee $val (i32.load16_u (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; STZ2kr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (i32.store16 (local.get $t) (local.get $n))
        (br $loop)

        );; LDR2kr
        (local.set $t (i32.load8_s offset=0x10100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.shr_u (local.tee $val (i32.load16_u (i32.add (local.get $pc) (local.get $t)))) (i32.const 8)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; STR2kr
        (local.set $t (i32.load8_s offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (i32.store16 (i32.add (local.get $pc) (local.get $t)) (local.get $n))
        (br $loop)

        );; LDA2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (i32.shr_u (local.tee $val (i32.load16_u (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (local.get $val))
        (br $loop)

        );; STA2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff)))))
        (i32.store16 (local.get $t) (local.get $n))
        (br $loop)

        );; DEI2kr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (local.get $rstp) (call $dei (i32.add (local.get $t) (i32.const 1))))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (call $dei (local.get $t)))
        (br $loop)

        );; DEO2kr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))))
        (local.set $l (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))))
        (i32.store8 (i32.add (i32.const 0x10200) (local.get $t)) (local.get $l))
        (call $deo (local.get $t) (local.get $l))
        (i32.store8 (i32.add (i32.const 0x10201) (local.get $t)) (local.get $n))
        (call $deo (i32.add (local.get $t) (i32.const 1)) (local.get $n))
        (br $loop)

        );; ADD2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.add (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; SUB2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.sub (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; MUL2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.mul (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; DIV2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (if (result i32) (i32.eqz (local.get $t)) (then (i32.const 0)) (else (i32.div_u (local.get $n) (local.get $t))))) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; AND2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.and (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; ORA2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.or (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; EOR2kr
        (local.set $t (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (local.get $rstp))))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 3)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.xor (local.get $n) (local.get $t))) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        );; SFT2kr
        (local.set $t (i32.load8_u offset=0x10100 (local.get $rstp)))
        (local.set $n (i32.or (i32.shl (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 2)) (i32.const 0xff))) (i32.const 8)) (i32.load8_u offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)))))
        (local.set $rstp (i32.and (i32.add (local.get $rstp) (i32.const 254)) (i32.const 0xff)))
        (i32.store8 offset=0x10100 (i32.and (i32.add (local.get $rstp) (i32.const 1)) (i32.const 0xff)) (i32.shr_u (local.tee $val (i32.shl (i32.shr_u (local.get $n) (i32.and (local.get $t) (i32.const 0xf))) (i32.shr_u (local.get $t) (i32.const 4)))) (i32.const 8)))
        (i32.store8 offset=0x10100 (local.get $rstp) (local.get $val))
        (br $loop)

        ));; end

    (global.set $wstp (local.get $wstp))
    (global.set $rstp (local.get $rstp)))


  (func $reset (export "reset")
    (global.set $wstp (i32.const 0xff))
    (global.set $rstp (i32.const 0xff))
    (memory.fill (i32.const 0x0) (i32.const 0x0) (i32.const 0x10300)))

  (func (export "wstp") (result i32) (global.get $wstp))
  (func (export "rstp") (result i32) (global.get $rstp))

  (memory (export "memory") 2)

  (global $wstp (mut i32) (i32.const -1))
  (global $rstp (mut i32) (i32.const -1))

  (start $reset))
