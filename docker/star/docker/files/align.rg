#!/bin/bash -e
# Run bash with -e exit on first error, -x add +command stream to sterr.
# Remove -x for cleaner usage message

# setup a scratch area
scratch=$(mktemp -d -t star.XXXXXX -p /mnt/work)
function finish {
    rm -rf "$scratch"
}
trap finish EXIT

# Check command line and provide usage and version information
while getopts ":p" opt; do
  case $opt in
    p)
        poot=$OPTARG
        ;;
    s)
        spikeInFa=$OPTARG
        ;;
    t)
        tRnaGtf=$OPTARG
        ;;
    \?)
        echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
    :)
        echo "Option -$OPTARG requires an argument." >&2
        exit 1
        ;;
  esac
done
# purge the options
shift `expr $OPTIND - 1`
if [ $# -lt 2 ]; then 
    echo "align.rg  \\"
    echo "      starGenome rgs outputStarPrefix"
    exit -1;
fi
genome=$1
rgs=$2
prefix=$3

dirprefix=`dirname $rgs`
while read RG
do
    PREFIX=`echo $RG | awk '{print substr($1,4)}'`
    echo $RG $PREFIX
    if [ -z "$RGS" ]; then
        RGS="$RG"
        readsa="$dirprefix/$PREFIX.1.fq.gz"
        readsb="$dirprefix/$PREFIX.2.fq.gz"
    else
        RGS="$RGS , $RG"
        readsa="$readsa,$dirprefix/$PREFIX.1.fq.gz"
        readsb="$readsb,$dirprefix/$PREFIX.2.fq.gz"
    fi
done < $rgs
echo $RGS
echo $readsa
echo $readsb
# Make target dir and build index files
if [ -e ${prefix}Log.final.out ]; then
    echo Already complete
    exit 0
fi
STAR --genomeDir ${genome} --readFilesIn $readsa $readsb \
    --outSAMattrRGline $RGS \
    --readFilesCommand zcat --runThreadN 12 --genomeLoad NoSharedMemory \
    --outFilterMultimapNmax 20 --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 \
    --outFilterMismatchNmax 999 --outFilterMismatchNoverLmax 0.04 \
    --alignIntronMin 20 --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
    --outSAMunmapped Within --outFilterType BySJout \
    --outSAMattributes NH HI AS NM MD \
    --outSAMtype BAM Unsorted \
    --quantMode TranscriptomeSAM GeneCounts \
    --outFileNamePrefix $prefix --outTmpDir $scratch/star
