# Working to update and clean up elements as recommended rather than building them piecemeal 


# ID of desired reference genome
REFSEQID = GCF_000001735.3

# Save a variable with the path to the genome FASTA file
GENPATH = ncbi_dataset/data/${REFSEQID}

# Save a variable with the path to the genome GFF file
GFFPATH = ncbi_dataset/data/${REFSEQID}

# Save variable for reads directory
dirREADS = reads

# Save variable for read files
R1 = ${dirREADS}/${SRR}_1.fastq
R2 = ${dirREADS}/${SRR}_2.fastq

# Save variable for bam directory
dirBAM = bam

# SRR to variable
SRR = ERR11901578

# bamfile to variable
BAM = ${SRR}_alignment.bam

# Sampled number of reads
Nreads = 100000

# Set cut window size (range is 1-1000, default is 4)
CutW = 4

#Set cut mean quality (range is 1-36, default is 20)
CutQ = 20

# bcf flags for pileup annotation
PILE_FLAGS =  -d 100 --annotate 'INFO/AD,FORMAT/DP,FORMAT/AD,FORMAT/ADF,FORMAT/ADR,FORMAT/SP'

# bcf flags for calling process
CALL_FLAGS = --ploidy 2 --annotate 'FORMAT/GQ'

SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# Prints help/information for makefile
usage:
	@echo "This Makefile contains the following targets and variables:"
	@echo make genome "  : downloads reference genome from NCBI"
	@echo "		using the REFSEQID variable"
	@echo make index "   : indexes the reference genome"
	@echo make download ": downloads a sample of sequencing reads from SRA number"
	@echo "		using the SRR variable"
	@echo make trim "    : trims the reads"
	@echo "		using the CutW and CutQ variable"
	@echo make align "   : aligns SRR reads to the reference genome"
	@echo make clean "   : clears downloaded files"
	
# Downloads genome using NCBI's downloader and unzips with overwriting
genome: 
	datasets download genome accession ${REFSEQID} --include genome,gff3
	unzip -n ncbi_dataset.zip

index: 
	hisat2-build ${GENPATH}/*.fna ${GENPATH}/${REFSEQID}-index

# Downloads a sample of reads from SRA into a new reads folder
getreads:
	mkdir -p ${dirREADS}
	fastq-dump -X ${Nreads} -F --outdir ${dirREADS} --split-files ${SRR}

align: 
	mkdir -p ${dirBAM}
	hisat2 -x ${GENPATH}/${REFSEQID}-index -1 ${R1} -2 ${R2} | \
		samtools sort > ${dirBAM}/${BAM}
	samtools index ${dirBAM}/${BAM}

getalign: getreads align

counts: 
	featureCounts -a ${GFFPATH}/*.gff -t gene -g ID -o counts.txt ${dirBAM}/*.bam

# Removes extraneous downloaded files
clean:
	rm -f md5sum.txt ncbi_dataset.zip




.PHONY: usage genome index getreads align getalign clean