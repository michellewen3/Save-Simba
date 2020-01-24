; This file has the linked list for the
; Jungle's layout
	.ORIG	x5000
	.FILL	Head

blk2
        .FILL	1
	.FILL   1
	.FILL   x23
	.FILL   blk4

Head
        .FILL   3
	.FILL   1
	.FILL   x23
	.FILL	blk1

blk1
	.FILL   1
	.FILL   2
	.FILL   x48
	.FILL   blk3

blk3
	.FILL   2
	.FILL   1
	.FILL   x49
	.FILL   blk2

blk4
	.FILL   0
	.FILL   2
	.FILL   x23
	.FILL   0
	.END	