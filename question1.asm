.data
.align 2                       
file_Name:        .asciiz "Enter a wave file name:\n"        # Prompt for entering the file name
file_Size:        .asciiz "Enter the file size (in bytes):\n" # Prompt for entering the file size
infoHeader:       .asciiz "Information about the wave file:\n================================\n" # Header for file information
newline:          .asciiz "\n"                               # Newline character for formatting
name:             .space 100                                 # Space to store the file name (100 characters)
size:             .word 0                                    # Space to store the file size (word)

# Strings for output
outputNumChannels:   .asciiz "Number of channels: "          # Output string for number of channels
outputSampleRate:    .asciiz "Sample rate: "                 # Output string for sample rate
outputByteRate:      .asciiz "Byte rate: "                   # Output string for byte rate
outputBitsPerSample: .asciiz "Bits per sample: "             # Output string for bits per sample

.text
.globl main

main:
    # Prompt for file name
    li $v0, 4                    # syscall for printing string
    la $a0, file_Name             # address of prompt
    syscall

    # Get file name input
    li $v0, 8                    # syscall for reading string
    la $a0, name                 # address to store input
    li $a1, 100                  # max number of characters
    syscall

    # Remove trailing newline from file name
    move $t0, $a0                # start address of name in $t0
    li $t1, 0                    # index in $t1

remove_newline:
    lb $t2, name($t1)            # load byte at index $t1
    beq $t2, 0, done_remove      # if null terminator, stop
    beq $t2, 10, replace_newline # if newline, replace with null
    addi $t1, $t1, 1             # increment index
    j remove_newline             # repeat

replace_newline:
    sb $zero, name($t1)          # replace newline with null terminator

done_remove:
    # Prompt for file size
    li $v0, 4                    # syscall for printing string
    la $a0, file_Size             # address of prompt
    syscall

    # Get file size input
    li $v0, 5                    # syscall for reading integer
    syscall
    move $t0, $v0                # store the file size in $t0

    # Open file for reading
    li $v0, 13                   # syscall for opening a file
    la $a0, name                 # address of file name
    li $a1, 0                    # read-only mode
    li $a2, 0                    # no permission needed
    syscall
    move $a0, $v0                # store file descriptor in $a0

    # Read WAVE header (44 bytes)
    li $v0, 14                   # syscall for reading file
    move $a1, $sp                # store data on the stack
    li $a2, 44                   # read 44 bytes (WAVE header)
    syscall

    # Print header information
    li $v0, 4                    # print string syscall
    la $a0, infoHeader           # print wave file information header
    syscall

    # Extract NumChannels (2 bytes starting at offset 22)
    lh $t1, 22($sp)              # load half-word for NumChannels (2 bytes)

    li $v0, 4                    # print string syscall
    la $a0, outputNumChannels     # address of string
    syscall
    li $v0, 1                    # print integer syscall
    move $a0, $t1                # number of channels
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Extract SampleRate (4 bytes starting at offset 24)
    lw $t3, 24($sp)              # load word for SampleRate (4 bytes)

    li $v0, 4                    # print string syscall
    la $a0, outputSampleRate      # address of string
    syscall
    li $v0, 1                    # print integer syscall
    move $a0, $t3                # sample rate
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Calculate Byte Rate = SampleRate * NumChannels * (BitsPerSample / 8)
    lh $t7, 34($sp)              # load half-word for BitsPerSample (2 bytes)
    move $t9, $t7                # BitsPerSample into $t9
    li $t8, 8                    # divisor (8)
    div $t9, $t8                 # divide BitsPerSample by 8
    mflo $t9                     # store result (BitsPerSample / 8)

    mul $t9, $t9, $t1            # multiply by NumChannels
    mul $t9, $t9, $t3            # multiply by SampleRate (now ByteRate)

    li $v0, 4                    # print string syscall
    la $a0, outputByteRate        # address of string
    syscall
    li $v0, 1                    # print integer syscall
    move $a0, $t9                # calculated byte rate
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Print Bits Per Sample
    li $v0, 4                    # print string syscall
    la $a0, outputBitsPerSample   # address of string
    syscall
    li $v0, 1                    # print integer syscall
    move $a0, $t7                # bits per sample
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Close the file
    li $v0, 16                   # syscall for closing a file
    move $a0, $a0                # file descriptor
    syscall

    # Exit program
    li $v0, 10                   # exit syscall
    syscall

