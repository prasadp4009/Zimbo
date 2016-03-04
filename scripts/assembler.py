#!usr/bin/python

import sys
import re
import pprint

print ("Welcome to Zimbo Assembler")
str = input("Enter file name: ");
print ("Received input is : ", str)
try:
    file = open(str,'r')
except FileNotFoundError:
    print ("ERROR: There was error in reading file ", str)
    sys.exit(0)

codefound = False
datafound = False

code =[]
data =[]
loop =[]
count=dict()



pc = 0
error = False

opcode = ["NOP","HLT","LDD","LDR","LDM","LDI","STR","ADD","ADI","SUB","SUI","MUL","MOD","AND","ORR","XOR","BZR","BEQ","BPV","BNG","JMP"]
registers = ["R0", "R1", "R2", "R3", "R4", "R5", "R6", "R7", "R8", "R9", "R10", "R11", "R12", "R13", "R14", "R15", "R16"]

decode_op = {"NOP" : "00000","HLT" : "11111","LDD":"00011","LDR":"00100","LDM":"00101","LDI":"00110","STR":"00111","ADD":"01000","ADI":"01001","SUB":"01010","SUI":"01011","MUL":"01100","MOD":"01100","AND":"01101","ORR":"01110","XOR":"01111","BZR":"10000","BEQ":"10001","BPV":"10010","BNG":"10011","JMP":"110"}

for line in file.readlines():
	if ".code" in line:
		codefound = True
	if ".data" in line:
		datafound = True
	if(codefound and (line.strip() != ".code") and not datafound):
		if ":" in line.rstrip('\n'):
			loop.append(re.sub(r'[\s+]', "",line.split(':')[0]))#line.rstrip('\n'))
			#code.append(re.sub(r'[\s+]', "", line))#line.rstrip('\n'))
			if("=" in line):
				part = line.split('=')
				code.append(re.sub(r'[\s+]', "", (part[0]+"#0")))
				code.append(re.sub(r'[\s+]', "", part[1]))#line.rstrip('\n'))
			else:
				code.append(re.sub(r'[\s+]', "", line))#line.rstrip('\n'))
			count[line.rstrip('\n')] = pc
			pc += 2
		elif (any(rg in line.strip() for rg in registers) or \
		any(op in line.strip() for op in opcode)) and line.strip() and ":" not in line.rstrip('\n'):
			if("=" in line):
				part = line.split('=')
				code.append(re.sub(r'[\s+]', "", (part[0]+"#0")))
				code.append(re.sub(r'[\s+]', "", part[1]))#line.rstrip('\n'))
			else:
				code.append(re.sub(r'[\s+]', "", line))#line.rstrip('\n'))

			#code.append(line.rstrip('\n'))
			count[line.rstrip('\n')] = pc
			pc += 2
		elif not((any(rg in line.strip() for rg in registers) and any(op in line.strip() for op in opcode)) or (line.strip()=="")):
			print ("Invalid Opcode or Register Value")
			print ("Line: ",line)
			error = True
			break
	elif datafound:
		if ":" and "range" in line.rstrip('\n'):
			depth = line[line.find("(")+1:line.find(")")]
			deep = int(re.search(r'\d+', depth).group())#filter(str.isdigit, depth))
			point = (re.sub(r'[\s+]', "", line.split(':')[0]))
			line_temp = (re.sub(r'[\s+]', "", line))
			if "," in line_temp:
				values = line_temp.split(',')
			else:
				values = [line_temp]
			length = len(values)
			#print ("*************************************")
			#print (values)
			#print (depth)
			#print (point)
			#print (length)
			#print (deep)
			#print (line_temp)
			#print ("*************************************")
						
			if length > 1:
				first_join = point + ":" + values[1]
				data.append(first_join)
				difference = deep - (length-1)			
				for i in range (2, deep+1):
					if(i < length):
						data.append(values[i])
					else:
						data.append("0x0000")
			else:
				first_join = point + ":" + "0x0000"
				data.append(first_join)
				for i in range (1, deep):
					data.append("0x0000")
			#data.append(line.rstrip('\n'))
file.close()
if not error:
#	print ("Code List")
#	for val in code:
#		print ("\t",val)
#	print ("Loop List")
#	for val in loop:
#		print ("\t",val)
	print ("Data List")
	for val in data:
		h_size = len(val[-4:]) * 4
		h = ( bin(int(val[-4:], 16))[2:] ).zfill(h_size)
		print ("\t",h)

#for val in code:
#	print (val,"\t\tAddress = ","{0:#0{1}x}".format(code.index(val)*2,6))


sys.exit(0)

