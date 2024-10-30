# Week 9: Filter a BAM file

## Edits and notes from lecture

For question 3, if you're looking at all alignments, you need to also account for removing the unmapped and munmapped, not just secondary and supplementary (-F 4 -F 8 -F 256 -F 2048). If using the proper_pair section (which I did) you can maybe not worry about it. For selecting the reverse, -f 16 and -F 32. 


## Original Assignment Submission Below

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

    55

```bash
# properly paired 16 + 2 
samtools view -c -f 18 bamfiles/srr_alignment.bam
```


4. Make a new BAM file that contains only the properly paired primary alignments with a mapping quality of over 10

```bash
samtools view -b -f 2 -F 2304 -q 10 bamfiles/srr_alignment.bam > bamfiles/filt_srr_align.bam

```

5. Compare the flagstats for your original and your filtered BAM file.

```bash
samtools flagstats bamfiles/filt_srr_align.bam
```

prints filtered file stats which show that all of the properly paired primary alignments are 100% properly paired alignments...:

```
110 + 0 in total (QC-passed reads + QC-failed reads)
110 + 0 primary
0 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
110 + 0 mapped (100.00% : N/A)
110 + 0 primary mapped (100.00% : N/A)
110 + 0 paired in sequencing
55 + 0 read1
55 + 0 read2
110 + 0 properly paired (100.00% : N/A)
110 + 0 with itself and mate mapped
0 + 0 singletons (0.00% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
```

The original flagstats for the SRR were: 

```
207 + 0 in total (QC-passed reads + QC-failed reads)
200 + 0 primary
0 + 0 secondary
7 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
151 + 0 mapped (72.95% : N/A)
144 + 0 primary mapped (72.00% : N/A)
200 + 0 paired in sequencing
100 + 0 read1
100 + 0 read2
110 + 0 properly paired (55.00% : N/A)
144 + 0 with itself and mate mapped
0 + 0 singletons (0.00% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
```
