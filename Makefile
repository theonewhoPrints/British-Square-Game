#
# Makefile for CCS Project 1 - British Square Game
#

#
# Location of the processing programs
#
RASM  = /home/fac/wrc/bin/rasm
RLINK = /home/fac/wrc/bin/rlink

#
# Suffixes to be used or created
#
.SUFFIXES:	.asm .obj .lst .out

#
# Transformation rule: .asm into .obj
#
.asm.obj:
	$(RASM) -l $*.asm > $*.lst

#
# Transformation rule: .obj into .out
#
.obj.out:
	$(RLINK) -m -o $*.out $*.obj > $*.map

#
# Object files
#
OBJECTS = BritishSquare.obj model.obj


#
# Main target
#
BritishSquare.out:	$(OBJECTS)
	$(RLINK) -m -o BritishSquare.out $(OBJECTS) > BritishSquare.map



