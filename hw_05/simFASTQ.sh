# READ BELOW
# You must activate the bioinfo environment
# You must have the NCBI command-line tools downloaded https://www.ncbi.nlm.nih.gov/datasets/docs/v2/reference-docs/command-line/datasets/
# All questions for assignment are answered via the trace or generating a file.

# Set trace
set -uex

# ID of desired reference genome in quotes ""
REFSEQID="GCA_000441915.1"

# Name of link file in FASTA format to FASTA file with genome
ORG=gen_aur.fa

# Number of reads to simulate with wgsim
N=1000

# Length of reads to simulate with wgsim
L=100

# Files to write the reads in the format newdirectory/filename#.fq
R1=simreads/wsim_read1.fq
R2=simreads/wgsim_read2.fq


# -----------------------Nothing to change below this line------------------

# Use NCBI's downloader to obtain reference genome
datasets download genome accession ${REFSEQID}

# Unzip the downloaded file and overwrite any previous, name is set by NCBI
unzip -o ncbi_dataset.zip

# Save a variable with the path to the genome FASTA file
GENPATH=ncbi_dataset/data/${REFSEQID}

# Save link to genome FASTA file
ln -sf ${GENPATH}/* ${ORG}

# List file information to get file size
ls -lh ${GENPATH}

# Obtain genome FASTA file info, genome size (sum_len), number of chromosomes or contigs (num_seqs)
seqkit stats ${ORG}

# Generate an index file for the genome FASTA file
seqkit faidx ${ORG}

# Generate a file with sequence ID and length
cat ${ORG}.fai | cut -f 1,2 > seq_name_len.txt

# Make directory, extracting directory name from R1 path set above
mkdir -p $(dirname ${R1})

# Simulate with wgsim with no errors and no mutations
wgsim -N ${N} -1 ${L} -2 ${L} -r 0 -R 0 -X 0 ${ORG} ${R1} ${R2}

# Run stats on the wgsim generated FASTQ files
seqkit stats ${R1} ${R2}

# List file information to get FASTQ file size
ls -lh $(dirname ${R1})

# Compress generated FASTQ files, overwrite existing ones
gzip -f ${R1} ${R2}

# List file information to get compressed FASTQ file size
ls -lh $(dirname ${R1})