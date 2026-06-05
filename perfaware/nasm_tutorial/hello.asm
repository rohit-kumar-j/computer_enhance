		global _start

		section	.text
_start: 	mov	rax, 1			; sys call for write
		mov 	rdi, 1 			; file handle 1 is  stdout
	mov 	rsi, message		; addr for starting string output
		mov 	rdx, 13			; number of bytes
		syscall				; Ask Os to write 
		mov 	rdx, 13			; number of bytes
		xor rdi, rdi			; exit code 0
		syscall				; ask os to exit

		section .data
message:	db	"Hello, World!", 0x0a, ; note the newline at the end



;; Memory Ops --------------------------------
;
;[750]                  ; displacement only
;[rbp]                  ; base register only
;[rcx + rsi*4]          ; base + index * scale
;[rbp + rdx]            ; scale is 1
;[rbx - 8]              ; displacement is -8
;[rax + rdi*8 + 500]    ; all four components
;[rbx + counter]        ; uses the address of the variable 'counter' as the displacement
;; -------------------------------------------


;; Immediate Operands ------------------------
;
;200          ; decimal
;0200         ; still decimal - the leading 0 does not make it octal
;0200d        ; explicitly decimal - d suffix
;0d200        ; also decimal - 0d prefix
;0c8h         ; hex - h suffix, but leading 0 is required because c8h looks like a var
;0xc8         ; hex - the classic 0x prefix
;0hc8         ; hex - for some reason NASM likes 0h
;310q         ; octal - q suffix
;0q310        ; octal - 0q prefix
;11001000b    ; binary - b suffix
;0b1100_1000  ; binary - 0b prefix, and by the way, underscores are allowed
;; -------------------------------------------


;; Defining Data and Reserving Space ---------
;
;db    0x55                ; just the byte 0x55
;db    0x55,0x56,0x57      ; three bytes in succession
;db    'a',0x55            ; character constants are OK
;db    'hello',13,10,'$'   ; so are string constants
;dw    0x1234              ; 0x34 0x12
;dw    'a'                 ; 0x61 0x00 (it's just a number)
;dw    'ab'                ; 0x61 0x62 (character constant)
;dw    'abc'               ; 0x61 0x62 0x63 0x00 (string)
;dd    0x12345678          ; 0x78 0x56 0x34 0x12
;dd    1.234567e20         ; floating-point constant
;dq    0x123456789abcdef0  ; eight byte constant
;dq    1.234567e20         ; double-precision float
;dt    1.234567e20         ; extended-precision float


;; -------------------------------------------





;; Notes -------------------------------------
;
; 0x0a is newline
; 0x0a is null terminator
;message:	db	"Hello, World!", 0x0a, 
;message:	db	"Hello, World!", 0x0a, 0x00
;
; This auto computes 0x00's location, so we don't have to
; msglen:     equ   $ - message       ; length computed at assembly time
;
;; -------------------------------------------
