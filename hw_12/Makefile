# ID of desired reference genome
REFSEQID = GCF_000001735.3

# Save a variable with the path to the genome FASTA file
GENPATH = ncbi_dataset/data/${REFSEQID}


# SRR to variable
SRR = SRR31238423

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
	datasets download genome accession ${REFSEQID}
	unzip -n ncbi_dataset.zip

index: 
	bwa index ${GENPATH}/*.fna 

# Downloads a sample of reads from SRA into a new reads folder
download:
	mkdir -p reads
	fastq-dump -X ${Nreads} -F --outdir reads --split-files ${SRR}

# Trims reads with fastp with cut-right with designated window size and mean quality
# Dependency set for one of the files to ensure download is run up to date before running trim
trim: reads/${SRR}_1.fastq
	fastp --cut_right -W ${CutW} -M ${CutQ} \
		-i reads/${SRR}_1.fastq -o reads/${SRR}_1.trimmed.fastq \
		-I reads/${SRR}_2.fastq -O reads/${SRR}_2.trimmed.fastq

align: 
	mkdir -p bamfiles
	bwa mem ${GENPATH}/*.fna reads/${SRR}_1.trimmed.fastq reads/${SRR}_2.trimmed.fastq | \
		samtools sort > bamfiles/${SRR}_alignment.bam
	samtools index bamfiles/${SRR}_alignment.bam
	samtools flagstats bamfiles/${SRR}_alignment.bam

vcf:
	mkdir -p vcf
	bcftools mpileup ${PILE_FLAGS} -O u -f ${GENPATH}/*.fna bamfiles/${SRR}_alignment.bam | \
		bcftools call ${CALL_FLAGS} -mv -O u | \
		bcftools norm -f ${GENPATH}/*.fna -d all -O u | \
		bcftools sort -O z > vcf/${SRR}_vcf.vcf.gz
	bcftools index vcf/${SRR}_vcf.vcf.gz

mergevcf:
	bcftools merge -0 vcf/*.vcf.gz -O z > merged.vcf.gz
	bcftools index merged.vcf.gz

# Removes extraneous downloaded files
clean:
	rm -f md5sum.txt ncbi_dataset.zip
	rm -f fastp.html fastp.json

runvcf: download trim align vcf

all: genome index download trim align vcf clean

.PHONY: usage genome download trim index align vcf clean mergevcf runvcf