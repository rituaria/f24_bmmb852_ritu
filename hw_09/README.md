# Week 9: Filter a BAM file


1. How many reads did not align with the reference genome?

    56 reads

```bash
# print the count (-c) of the unmapped reads (-f 4) in the bam file
samtools view -c -f 4 bamfiles/srr_alignment.bam
```


2. How many primary, secondary, and supplementary alignments are in the BAM file?

    Primary: 200
    Secondary: 0
    Supplementary: 7

```bash
# primary (-F to exclude secondary and supplementary)
samtools view -c -F 2304 bamfiles/srr_alignment.bam
# secondary
samtools view -c -f 256 bamfiles/srr_alignment.bam
# supplementary
samtools view -c -f 2048 bamfiles/srr_alignment.bam

```

3. How many properly-paired alignments on the reverse strand are formed by reads contained in the first pair?



```bash


```


4. Make a new BAM file that contains only the properly paired primary alignments with a mapping quality of over 10

```bash

```

5. Compare the flagstats for your original and your filtered BAM file.


```bash

```