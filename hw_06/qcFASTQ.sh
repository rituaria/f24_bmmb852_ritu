# This script aggressively trims data using cut-right in fastp.
# Default cut window size and cut mean quality are set but can be changed.

# set trace
set -uex

# SRR to variable
SRR=SRR916071

# Sampled number of reads
Nreads=1000

# Set cut window size (range is 1-1000, default is 4)
CutW=4

#Set cut mean quality (range is 1-36, default is 20)
CutQ=20

#-------------- No changes below this line ----------------

# Make directories for data and reports
mkdir -p reads reports

# Download a sample of reads in a separate folder
fastq-dump -X ${Nreads} -F --outdir reads --split-files ${SRR}

# Run fastqc on both files of the paired end reads
fastqc -o reports reads/${SRR}_1.fastq reads/${SRR}_2.fastq

# Run fastp with cut-right with designated window size and mean quality
fastp --cut_right -W ${CutW} -M ${CutQ} -i reads/${SRR}_1.fastq -o reads/${SRR}_1.trimmed.fastq -I reads/${SRR}_2.fastq -O reads/${SRR}_2.trimmed.fastq

# Run fastqc on trimmed files of the paired end reads
fastqc -o reports reads/${SRR}_1.trimmed.fastq reads/${SRR}_2.trimmed.fastq