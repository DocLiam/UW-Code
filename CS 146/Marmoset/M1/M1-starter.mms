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

_pnlower    IS $0
_pnupper    IS $1
_pnrJ       IS $2

// Define other symbol as needed...

Solve    ADD _pnlower,$254,0
            ADD _pnupper,$255,0
            GET _pnrJ,rJ // Save jump register, because it will be 

                         // overwritten when we do function call
            ADD $255,_pnlower,_pnupper // Right now we are printing
                                       // the sum of two arguments
            PUSHJ 3,PrintInt // We are using $0 to $2, so X=3
            PUT rJ,_pnrJ // Restore the saved jump register
            POP 0        // Jump back to caller using jump register

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
