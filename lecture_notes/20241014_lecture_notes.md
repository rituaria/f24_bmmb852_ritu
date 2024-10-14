## Lecture 10/14 Notes

### Solving the file overwrite problem:

Don't do it. 

```bash
unzip -o ncbi_dataset.zip 
```

will overwrite and destroy your README with the one in the zip and there can be similar situations, use instead:

```bash
unzip -n ncbi_dataset.zip
```
which doesn't flag nor overwrite the file. Alt tricks/option- use parentheses to temporarily start a new bash. Partial code examples:

```bash
mkdir tmp
(cd tmp && pwd)
(cd tmp && echo > foo.txt)
(cd tmp && datasets download ... && unzip -n ncbi_dataset.zip)
```

### Alignment (slides):

- Sequencing refresher: fragment DNA, read, map to reference (or assemble new from overlapping reads, not covered here)
- **read mapping** is a more accurate term than **alignment**
    - mapping finds most likely match of a read in a genome
    - alignment finds the best possible arrangement of two sequences
    - but the terms are still used interchangeably...
- the read is matched to places and scored, the best position is reported with additional info like the mismatches or deletions
- Most tools will give you the best match, some might give you best two or more

- Indexing

- bwa tool- parameters 

- Demonstration with 2014 Ebola virus sequencing comparing to 1976 ref genome. 
    - downloading with bio fetch, storing in fasta format, making index, and looking at seqkit stats
    - bwa mem refs/ebola.fa (index), read1 read2
    - .... lots of code, hopefully he will post.

### Assignment:

Map simulated and real reads and see the difference.

