// Rotate Right Testing Assembly file 0

//ROR has: ROR Rd, Rs, Rt

lbi	r1, 0xff
slbi	r1, 0xff //R1 contains 0xFFFF

lbi	r2, 0
slbi	r2, 0x08 //R2 contains 0x0008

ror	r3, r1, r2 //Make sure it rotates by 8
halt