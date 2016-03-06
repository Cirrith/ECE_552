// Rotate Right Testing Assembly file 0

//ROR has: ROR Rd, Rs, Rt

lbi	r1, 0xaa
slbi	r1, 0xaa //R1 contains 0xAAAA

lbi	r2, 0
slbi	r2, 0x02 //R2 contains 0x0002

ror	r3, r1, r2 //Make sure it rotates by 2
halt