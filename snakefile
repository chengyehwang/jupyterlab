rule bwa:
	input: "test.in"
	cache: True
	output: "test.out"
	shell: "cat test.in > test.out"
