# ID of desired reference genome
REFSEQID = GCA_000441915.1

# Number of reads to simulate with wgsim
Nsim = 1000

# Length of reads to simulate with wgsim
Lsim = 100

# Files to write the reads in the format newdirectory/filename#.fq
D1 = simreads
R1 = simreads/wgsim_read1.fq
R2 = simreads/wgsim_read2.fq

# Save a variable with the path to the genome FASTA file
GENPATH = ncbi_dataset/data/${REFSEQID}


# SRR to variable
SRR = SRR916071

# Sampled number of reads
Nreads = 100

# Set cut window size (range is 1-1000, default is 4)
CutW = 4

#Set cut mean quality (range is 1-36, default is 20)
CutQ = 20

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
	@echo make simulate ": simulates reads based on the genome"
	@echo "		using Nsim and Lsim variables"
	@echo make download ": downloads a sample of sequencing reads from SRA number"
	@echo "		using the SRR variable"
	@echo make trim "    : trims the reads"
	@echo "		using the CutW and CutQ variable"
	@echo make report "  : makes fastqc reports for pre- and post- trimmed reads"
	@echo make clean "   : clears downloaded files"


# Downloads genome using NCBI's downloader and unzips with overwriting
genome: 
	datasets download genome accession ${REFSEQID}
	unzip -o ncbi_dataset.zip

# Simulates reads with wgsim with no errors and no mutations in a new D1 folder
simulate:
	mkdir -p ${D1}
	wgsim -N ${Nsim} -1 ${Lsim} -2 ${Lsim} -r 0 -R 0 -X 0 ${GENPATH}/*.fna ${R1} ${R2}


# Downloads a sample of reads from SRA into a new reads folder
download:
	mkdir -p reads
	fastq-dump -X ${Nreads} -F --outdir reads --split-files ${SRR}


# Trims reads with fastp with cut-right with designated window size and mean quality
# Dependency set for one of the files to ensure download is run up to date before running trim
trim: reads/${SRR}_1.fastq
	fastp --cut_right -W ${CutW} -M ${CutQ} -i reads/${SRR}_1.fastq -o reads/${SRR}_1.trimmed.fastq -I reads/${SRR}_2.fastq -O reads/${SRR}_2.trimmed.fastq

# Reports from fastqc for pre- and post- trimmed data
# Dependency set for one trimmed file to ensure trim is run up to date before running report
report: reads/${SRR}_1.trimmed.fastq
	mkdir -p reports
	fastqc -o reports reads/${SRR}_1.fastq reads/${SRR}_2.fastq
	fastqc -o reports reads/${SRR}_1.trimmed.fastq reads/${SRR}_2.trimmed.fastq

# Removes all downloaded files
clean:
	rm -rf ncbi_dataset/data/${REFSEQID}
	rm -f md5sum.txt ncbi_dataset.zip
	rm -f fastp.html fastp.json
	rm -f README.md

all: genome simulate download trim report

.PHONY: usage genome simulate download trim report clean