# AES FPGA Implementation

## Project Overview
This project presents the hardware implementation of the Advanced Encryption Standard (AES-128) algorithm using Verilog HDL on an FPGA platform. The objective of this work is to understand hardware-based cryptography and design a secure encryption system suitable for real-time digital applications.

AES is a symmetric key block cipher widely used in secure communication, embedded systems, and data protection.

## Objectives
The main goals of this project are:

- To understand the AES encryption algorithm in depth
- To implement AES-128 using Verilog HDL
- To verify functionality using simulation
- To learn FPGA design flow using Vivado
- To study hardware implementation of cryptographic systems

## AES Algorithm Summary
AES is a 128-bit block cipher that uses a 128-bit secret key and performs 10 rounds of encryption.

Each encryption round performs the following operations:

1. SubBytes – Non-linear byte substitution using S-Box
2. ShiftRows – Row-wise permutation of the state matrix
3. MixColumns – Column mixing using Galois Field arithmetic
4. AddRoundKey – XOR operation with generated round key

The final round excludes the MixColumns step as defined in the AES standard.

## Tools and Technologies Used

Hardware Description Language: Verilog HDL  
Design Tool: Vivado 2023.2  
Simulation: Vivado Simulator  
Target Platform: FPGA  
Version Control: GitHub  

## Hardware Design Architecture
The AES-128 encryption is implemented using a modular hardware architecture. Each AES transformation is designed as an independent Verilog module to improve readability, testing, and reusability.

Top Level Modules:
design_1_wrapper  
aes_128_top  

These modules control the complete AES encryption flow and connect all submodules.

## AES Module Hierarchy

### Key Expansion Module
AES requires a new round key for every encryption round.

Modules used:
key_expansion_round  
sbox_lut  

Round keys generated:
rk1 to rk10  

This module generates all round keys from the original secret key.

### Main AES Rounds (Rounds 1–9)
Module: aes_round

Each round performs four AES transformations:
SubBytes – subbytes.v  
ShiftRows – shiftrows.v  
MixColumns – mixcolumns.v  
AddRoundKey – addroundkey.v  

These steps are repeated for 9 rounds.

### Final AES Round (Round 10)
Module: aes_final_round

The final round performs:
SubBytes  
ShiftRows  
AddRoundKey  

MixColumns is removed in the final round according to the AES standard.

## Important Modules Summary

aes_128_top – Main AES controller  
key_expansion_round – Round key generation  
sbox_lut – AES S-Box lookup table  
aes_round – Main AES round logic  
aes_final_round – Final round logic  
subbytes – Byte substitution  
shiftrows – Row shifting  
mixcolumns – Column mixing  
addroundkey – XOR with round key  

## Project Folder Structure
aes-fpga-implementation/
src → Verilog source files  
testbench → Simulation files  
constraints → FPGA constraint files  

## Design Flow in Vivado
The following FPGA design flow was used:

1. RTL design entry using Verilog
2. Behavioral simulation
3. Synthesis
4. Implementation
5. Bitstream generation

The bitstream was successfully generated, confirming correct hardware design flow.

## Simulation and Verification
The AES design was verified using a Verilog testbench to ensure:
- Correct encryption functionality
- Proper round execution
- Accurate round key generation

Simulation results confirm successful AES encryption.

## Learning Outcomes
Through this project, the following concepts were learned:

- Hardware implementation of cryptographic algorithms
- FPGA design and verification flow
- Modular Verilog design methodology
- Importance of hardware security in embedded systems

## Future Improvements
Possible enhancements include:

- AES Decryption implementation
- Pipelined AES architecture
- Area and speed optimization
- Deployment on physical FPGA board

## Conclusion
This project demonstrates a successful FPGA implementation of AES-128 encryption using Verilog HDL. It provides practical experience in digital design, FPGA workflow, and hardware security systems.

Author  
FPGA & Digital Design Student Project
