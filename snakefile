rule total:
    input:
        "test_A.out",
        "test_B.out"
def func(wildcards):
	return "test_" + wildcards.sample + ".in"
rule bwa:
    input:
        lambda wildcards: "test_" + wildcards.sample + ".in",
	func
    output:
        "test_{sample}.out",
        directory("AA_{sample}")
    shell:
        "mkdir AA_{wildcards.sample} && echo {input[0]} && cat test_{wildcards.sample}.in > {output[0]}"

