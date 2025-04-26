; Simple 7-segment display of "7."
SEG_ON     EQU P1.6        ; Display power control
SEG_DATA   EQU 0FF38H      ; Data register address
SEG_SELECT EQU 0FF30H      ; Digit select register

; Segment mapping (common cathode):
;      0
;     ---
;  5 |   | 1
;     ---  6
;  4 |   | 2
;     ---
;      3   •7 (decimal point)

    LJMP START
    ORG 100H

START:
    ; Select digit position (e.g., first digit)
    MOV DPTR, #SEG_SELECT
    MOV A, #00000001B       ; Activate digit 0
    MOVX @DPTR, A

    ; Send pattern for "7." (segments 0, 1, 2, and 7)
    MOV DPTR, #SEG_DATA
    MOV A, #10000111B       ; 0, 1, 2, and dot (bit 7 set)
    MOVX @DPTR, A

    ; Turn on the display
    CLR SEG_ON

    ; Keep the display on
    SJMP $
