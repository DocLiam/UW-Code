        LOC 512
        GREG @ // Make $254 a global register, in addition to $255. 
               // They are not affected by push/pop

argc    IS $0  // X+1, X=Number of command line arguments

argv    IS $1  // Pointer to a null terminated array of pointers
               // pointing to each command line argument
lower   IS $2
upper   IS $3

//      PUSHJ X,Y automatically saves register $0 to $(X-1),
//      makes them inaccessible for the callee, and jump to label Y. 
//      Those registers are automatically restored during POP.

Main    ADD argv,argv,8
        LDO $255,argv,0
        PUSHJ 4,Atoi // We are using $0-$3, so X=4
        ADD lower,$255,0
        ADD argv,argv,8
        LDO $255,argv,0
        PUSHJ 4,Atoi
        ADD upper,$255,0
        ADD $254,lower,0
        ADD $255,upper,0
        PUSHJ 4,Solve
        TRAP 0,Halt,0

////////////////////////////////////////////////////////////
//
// Solve
// Solve assignment question
// Parameter: Lower bound and upper bound in $254 and $255
// Return value: None 
//
////////////////////////////////////////////////////////////

_m          IS $0
_n          IS $1
_pnrJ       IS $2
_temp_i     IS $3
_reversed_i IS $4
_perfect    IS $5
_i          IS $6
_j          IS $7
_zero       IS $8
_one        IS $9
_two        IS $10
_ten        IS $11
_fakerR     IS $12

_junk       IS $127

// Define other symbol as needed...
       
Solve       GET _pnrJ,rJ
            XOR _zero,_zero,_zero
            SETL _zero,0
            XOR _one,_one,_one
            SETL _one,1
            XOR _two,_two,_two
            SETL _two,2
            XOR _ten,_ten,_ten
            SETL _ten,10
//(data _m 7777)
            ADD _m,$254,_zero
//(data _n 88888)
            ADD _n,$255,_zero
//(data _i 10)
            ADD _i,_m,_zero
//(data _j 2)
            ADD _j,_two,_zero
//(data _temp_i 0)
            ADD _temp_i,_zero,_zero
//(data _reversed_i 0)
            ADD _reversed_i,_zero,_zero
//(data _perfect true)
            ADD _perfect,_one,_zero
//(label LABEL0)
//(le (0 PtoSP) _i _n)
_LABELA     CMP $55,_i,_n
//(branch (0 PtoSP) LABEL1)
            BNP $55,_LABELB
//(jump LABEL2)
            JMP _LABELC
//(label LABEL1)
//(move _perfect #t)
_LABELB     ADD _perfect,_one,_zero
//(move _temp_i _i)
            ADD _temp_i,_i,_zero
//(move _reversed_i 0)
            ADD _reversed_i,_zero,_zero
//(label LABEL3)
//(equal (0 PtoSP) _temp_i 0)
_LABELD     CMP $55,_temp_i,_zero
//(lnot (0 PtoSP) (0 PtoSP))
            //NEG $55,_zero,$55
//(branch (0 PtoSP) LABEL4)
            BNZ $55,_LABELE
//(jump LABEL5)
            JMP _LABELF
//(label LABEL4)
//(mul (0 PtoSP) _reversed_i 10)
_LABELE     MUL $55,_reversed_i,_ten
//(mod (1 PtoSP) _temp_i 10)
            DIV _junk,_temp_i,_ten
//(add (0 PtoSP) (0 PtoSP) (1 PtoSP))
            GET _fakerR,rR
            ADD $55,$55,_fakerR
//(move _reversed_i (0 PtoSP))
            ADD _reversed_i,$55,_zero
//(div (0 PtoSP) _temp_i 10)
            DIV $55,_temp_i,_ten
//(move _temp_i (0 PtoSP))
            ADD _temp_i,$55,_zero
//(jump LABEL3)
            JMP _LABELD
//(label LABEL5)
//(equal (0 PtoSP) _i _reversed_i)
_LABELF     CMP $55,_i,_reversed_i
//(lnot (0 PtoSP) (0 PtoSP))
            //NEG $55,_zero,$55
//(branch (0 PtoSP) LABEL6)
            BNZ $55,_LABELG
//(jump LABEL7)
            JMP _LABELH
//(label LABEL6)
//(jump LABEL8)
_LABELG     JMP _LABELI
//(label LABEL7)
//(move _j 2)
_LABELH     ADD _j,_two,_zero
//(label LABEL9)
//(mul (0 PtoSP) _j _j)
_LABELJ     MUL $55,_j,_j
//(le (0 PtoSP) (0 PtoSP) _i)
            CMP $55,$55,_i
//(branch (0 PtoSP) LABEL10)
            BNP $55,_LABELK
//(jump LABEL11)
            JMP _LABELL
//(label LABEL10)
//(mul (1 PtoSP) _j _j)
_LABELK     MUL $56,_j,_j
//(mod (0 PtoSP) _i (1 PtoSP))
            DIV _junk,_i,$56
//(equal (0 PtoSP) (0 PtoSP) 0)
            GET _fakerR,rR
            CMP $55,_fakerR,_zero
//(branch (0 PtoSP) LABEL12)
            BZ $55,_LABELM
//(jump LABEL13)
            JMP _LABELN
//(label LABEL12)
//(move _perfect #f)
_LABELM     ADD _perfect,_zero,_zero
//(move _j _i)
            ADD _j,_i,_zero
//(jump LABEL14)
            JMP _LABELO
//(label LABEL13)
//(label LABEL14)
//(add (0 PtoSP) _j 1)
_LABELN     ADD _junk,_junk,_junk
_LABELO     ADD $55,_j,_one
//(move _j (0 PtoSP))
            ADD _j,$55,_zero
//(jump LABEL9)
            JMP _LABELJ
//(label LABEL11)
//(move (0 PtoSP) _perfect)
_LABELL     ADD $55,_perfect,_zero
//(branch (0 PtoSP) LABEL15)
            BNZ $55,_LABELP
//(jump LABEL16)
            JMP _LABELQ
//(label LABEL15)
//(print-val _i)
//(print-string "\n")
_LABELP     ADD $255,_i,_zero
            PUSHJ 158,PrintInt
//(jump LABEL17)
            JMP _LABELR
//(label LABEL16)
//(label LABEL17)
//(label LABEL8)
//(add (0 PtoSP) _i 1)
_LABELQ     ADD _junk,_junk,_junk
_LABELR     ADD _junk,_junk,_junk
_LABELI     ADD $55,_i,_one
//(move _i (0 PtoSP))
            ADD _i,$55,_zero
//(jump LABEL0)
            JMP _LABELA
//(label LABEL2)
_LABELC     PUT rJ,_pnrJ
//(halt)
            POP 0

////////////////////////////////////////////////////////////
//
// PrintInt
// Print non negative number to standard output with new line
// Parameter: The non negative number to print, in $255
// Return value: None
//
///////////////////////////////////////////////////////////

_piNum          IS  $255
_piCurChar      IS  $0
_piResult       IS  $1
_piBeginChar    IS  $2
_piRevChar      IS  $3

PrintInt        GETA _piCurChar,_piBuffer
_PiLoop         DIV _piNum,_piNum,10
                GET _piResult,rR
                ADD _piResult,_piResult,'0'
                STB _piResult,_piCurChar,0
                ADD _piCurChar,_piCurChar,1
                CMP _piResult,_piNum,0
                BZ _piResult,_PiLoopEnd
                JMP _PiLoop
_PiLoopEnd      GETA _piRevChar,_piBufferRev
                GETA _piBeginChar,_piBuffer
_PiRev          SUB _piCurChar,_piCurChar,1
                LDB _piResult,_piCurChar,0
                STB _piResult,_piRevChar,0
                ADD _piRevChar,_piRevChar,1
                CMP _piResult,_piCurChar,_piBeginChar
                BZ _piResult,_PiEnd
                JMP _PiRev
_PiEnd          SETL _piResult,10
                STB _piResult,_piRevChar,0
                SETL _piResult,0
                STB _piResult,_piRevChar,1
                GETA $255,_piBufferRev
                TRAP 0,Fputs,StdOut
                POP 0
_piBuffer       OCTA 0,0,0,0
_piBufferRev    OCTA 0,0,0,0

////////////////////////////////////////////////////////////
//
// Atoi
// Convert string to non negative number
// Parameter: Pointer to a null terminated 
//        string containing non negative number, in $255
// Return value: The converted non negative number, in $255
//
////////////////////////////////////////////////////////////

_atPtr  IS  $255
_atAcc  IS  $1
_atRes  IS  $2
_atCmp  IS  $3

Atoi    XOR _atAcc,_atAcc,_atAcc
_AtLoop LDB _atRes,_atPtr,0
        CMP _atCmp,_atRes,0
        BZ _atCmp,_AtEnd
        SUB _atRes,_atRes,'0'
        MUL _atAcc,_atAcc,10
        ADD _atAcc,_atAcc,_atRes
        ADD _atPtr,_atPtr,1
        JMP _AtLoop
_AtEnd  ADD $255,_atAcc,0
        POP 0
