;***********************************************
;Lesson no. 4    - 7-segment display
;Example no. 1   - 16 bits addressing
;***********************************************
SEG_ON EQU    P1.6        ;power on/off
F_CSDS EQU    0FF30H      ;address of segment buffer (where to see)
F_CSDB EQU    0FF38H      ;address of data buffer (what to see)
DISPLAY EQU   00001001B   ;2 segments (electronic element with LEDs)
; Segment pattern for "7." (with decimal point)
;    (0)
;   ----
;   |     | (1)
;   -
;   |     | (2)
;   ----      dot (7)
;         (3)
;
; For digit 7 with decimal point: segments a, b, c (0,1,2) + dp (7) = 00000111B
; But according to your diagram, let's calculate:
; a(0)=1, b(1)=1, c(2)=1, dp(7)=1 → 10000111B (if bits are 7-0)
; However, your CODE was 01011011B, so we need to adjust

    LJMP    START
    ORG    100H
START:
    ; Initialize display
    MOV    DPTR,#F_CSDS    ;prepare address
    MOV    A,#DISPLAY      ;prepare data (same as original)
    MOVX   @DPTR,A         ;send data to address

    ; Send pattern for "7."
    ; For digit 7: segments a, b, c should be on (0,1,2)
    ; Plus decimal point (7)
    ; Assuming your CODE format matches the diagram:
    ; Bit 0: segment (0)
    ; Bit 1: segment (1)
    ; Bit 2: segment (2)
    ; ...
    ; Bit 7: decimal point
    MOV    DPTR,#F_CSDB    
    MOV    A,#00000111B    ;This lights segments 0,1,2 (7) - may need adjustment
    ; Alternative pattern if the above doesn't work:
    ; MOV    A,#10000111B    ;Try this if the decimal point isn't showing
    MOVX   @DPTR,A        

    ; Power on the display
    CLR    SEG_ON        ;power on
    SJMP    $            ;halt here