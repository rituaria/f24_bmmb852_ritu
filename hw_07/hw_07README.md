# Week 7: Write a Makefile
This report explains how the makefile works and how to run it to achieve the various tasks. This file is called hw_07README.md because when running this makefile, the ncbi datasets tool also downloads a README.md... so confusing and annoying, I wanted to delete it with make clean and not overwrite or delete this report.

```bash
make
```

prints the usage target:

```
This Makefile contains the following targets and variables:
make genome   : downloads reference genome from NCBI
                using the REFSEQID variable
make simulate : simulates reads based on the genome
                using Nsim and Lsim variables
make download : downloads a sample of sequencing reads from SRA number
                using the SRR variable
make trim     : trims the reads
                using the CutW and CutQ variable
make report   : makes fastqc reports for pre- and post- trimmed reads
make clean    : clears downloaded files
```

Running each individual portion sequentially will produce the desired information and execute the desired tasks, however there is also 

```bash
make all
```
which runs everything except the clean-up all at once. This is probably the best way to use this make the first time around. In make trim and make report, I have added dependencies to a file made in download or trim targets respectively. These must be up to date to get the appropriate input for trim and report. I attempted to set up a similar dependency with a path and *.fna for simulate, but this dependency did not pass when running make all the first time, it always had to be run a second time for some reason, so it was removed. 
Key components from previous scripts for hw_05 and hw_06 were used. 