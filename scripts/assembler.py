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
loop_loc = dict()
data_loc = dict()
code =[]
data =[]
loop =[]
pc_count=dict()


assm16_code=[]
bin16_code=[]


pc = 0
error = False

opcode = ["NOP","HLT","LDA","LDD","LDR","LDM","LDI","STR","ADD","ADI","SUB","SUI","MUL","MOD","AND","ORR","XOR","BZR","BEQ","BPV","BNG","JMP"]
registers = ["R0", "R1", "R2", "R3", "R4", "R5", "R6", "R7", "R8", "R9", "R10", "R11", "R12", "R13", "R14", "R15"]

decode_op = {"NOP" : "00000","HLT" : "11111","LDA":"0010","LDD":"00011","LDR":"00100","LDM":"00101","LDI":"00110","STR":"00111","ADD":"01000","ADI":"01001","SUB":"01010","SUI":"01011","MUL":"01100","MOD":"01100","AND":"01101","ORR":"01110","XOR":"01111","BZR":"10000","BEQ":"10001","BPV":"10010","BNG":"10011","JMP":"110"}
decode_reg = {"R0":"0000", "R1":"0001", "R2":"0010", "R3":"0011", "R4":"0100", "R5":"0101", "R6":"0110", "R7":"0111", "R8":"1000", "R9":"1001", "R10":"1010", "R11":"1011", "R12":"1100", "R13":"1101", "R14":"1110", "R15":"1111"}

line_count = 0

for line in file.readlines():
	if ".code" in line:
		codefound = True
	if ".data" in line:
		datafound = True
	if(codefound and (line.strip() != ".code") and not datafound):
		if ":" in line.rstrip('\n'):
			loop.append(re.sub(r'[\s+]', "",line.split(':')[0]))#line.rstrip('\n'))
			loop_loc[re.sub(r'[\s+]', "",line.split(':')[0])] = line_count
			#code.append(re.sub(r'[\s+]', "", line))#line.rstrip('\n'))
			if("=" in line):
				line_count = line_count + 2
				part = line.split('=')
				code.append(re.sub(r'[\s+]', "", (part[0]+"#0")))
				code.append(re.sub(r'[\s+]', "", part[1]))#line.rstrip('\n'))
			else:
				line_count = line_count + 1
				code.append(re.sub(r'[\s+]', "", line))#line.rstrip('\n'))
			pc_count[line.rstrip('\n')] = pc
			pc += 2
		elif (any(rg in line.strip() for rg in registers) or \
		any(op in line.strip() for op in opcode)) and line.strip() and ":" not in line.rstrip('\n'):
			if("=" in line):
				line_count = line_count + 2
				part = line.split('=')
				code.append(re.sub(r'[\s+]', "", (part[0]+"#0")))
				code.append(re.sub(r'[\s+]', "", part[1]))#line.rstrip('\n'))
			else:
				line_count = line_count + 1
				code.append(re.sub(r'[\s+]', "", line))#line.rstrip('\n'))

			#code.append(line.rstrip('\n'))
			pc_count[line.rstrip('\n')] = pc
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
			data_loc[point] = line_count
			#print ("*************************************")
			#print (values)
			#print (depth)
			#print (point)
			#print (length)
			#print (deep)
			#print (line_temp)
			#print ("*************************************")
						
			if length > 1:
				line_count = line_count + 1
				first_join = point + ":" + values[1]
				data.append(first_join)
				difference = deep - (length-1)			
				for i in range (2, deep+1):
					line_count = line_count + 1
					if(i < length):
						data.append(values[i])
					else:
						data.append("0x0000")
			else:
				line_count = line_count + 1
				first_join = point + ":" + "0x0000"
				data.append(first_join)
				for i in range (1, deep):
					line_count = line_count + 1
					data.append("0x0000")
			#data.append(line.rstrip('\n'))
file.close()

if line_count == (len(code) + len(data)):
	print("Values are perfect")
	print("Line count = ",line_count,"\nCode count = ",len(code),"\nData count = ",len(data),"\nCode + Data = ",len(code)+len(data))
else:
	print("Line count = ",line_count,"\nCode count = ",len(code),"\nData count = ",len(data),"\nCode + Data = ",len(code)+len(data))
	print("Check the code of line_count: You are in deep shit")
	sys.exit(0)

if not error:
	print ("Code List")
	for val in code:
		print ("\t",val)
	print ("Loop List")
	for val in loop:
		print ("\t",val)
	print ("Data List")
	for val in data:
		print ("\t",val)
#		h_size = len(val[-4:]) * 4
#		h = ( bin(int(val[-4:], 16))[2:] ).zfill(h_size)
#		print ("\t",h)
	print ("\n\nLoop Locations")
	print (loop_loc)
	print (data_loc)
#	for val in loop_loc:
#		print ("\t",val," at line:")
#		for linenum in loop_loc[val]:
#			print("\t\tLine number = ",linenum)

sys.exit(0)

assm16_code = code + data

line_count = 0
for line in assm16_code:
		line_count += 1 
		syntax = line.split(',')
		length = len(syntax)
		if((length < 1) or (length > 3)):
			print("ERROR: Invalid Entry",syntax,"at line",line_count)
			sys.exit(0)
		if(length == 3):
			if ":" in syntax[0]:
				strip_opcode = syntax[0].split(':')[1]
			else:
				strip_opcode = syntax[0]
			if decode_op.get(strip_opcode) is not None:
				output = decode_op.get(strip_opcode)
			else:
				print("ERROR: Invalid Opcode ",syntax[0]," at line:",line_count)
				sys.exit(0)
			if decode_reg.get(syntax[1]) is not None:
				output = output + decode_reg.get(syntax[1])
			else:
				print("ERROR: Invalid Register ",syntax[1]," at line:",line_count)
				sys.exit(0)

			if "#" in syntax[2]:
				const_val = int(re.search(r'\d+', syntax[2]).group())
				output = output + (bin(const_val)[2:]).zfill(7)
			elif decode_reg.get(syntax[2]) is not None:
				if (strip_opcode == "MOD"): 
					output = output + decode_reg.get(syntax[2]) + "001"
				else:
					output = output + decode_reg.get(syntax[2]) + "000"
			else:
				print("ERROR: Invalid Entry ",syntax[2]," at line:",line_count)
				sys.exit(0)
		elif(length == 2):
			if ":" in syntax[0]:
				strip_opcode = syntax[0].split(':')[1]
			else:
				strip_opcode = syntax[0]
			if decode_op.get(strip_opcode) is not None:
				if (strip_opcode in ["JMP","BZR","BEQ","BPV","BNG"]):
					output = decode_op.get(strip_opcode)
				else:
					print("ERROR: Incorrect Opcode type for 2 level syntax ",syntax[0]," used at line:",line_count)	
					sys.exit(0)
			else:
				print("ERROR: Invalid Opcode ",syntax[0]," at line:",line_count)
				sys.exit(0)
		#	if


				




#for val in code:
#	print (val,"\t\tAddress = ","{0:#0{1}x}".format(code.index(val)*2,6))


sys.exit(0)

