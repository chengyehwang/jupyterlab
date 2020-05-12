rule total:
    input:
        "test_A.out",
        "test_B.out"
rule bwa:
    input:
        "test_{sample}.in"
    output:
        "test_{sample}.out"
    shell: """
        cat {input} > {output}
    """

