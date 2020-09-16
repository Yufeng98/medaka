#!/bin/bash

# Obtaining Data and Software

WALKTHROUGH=${PWD}/medaka_walkthrough
DATA=${PWD}/data

cd ${WALKTHROUGH}
git clone https://github.com/nanoporetech/pomoxis --recursive
git clone https://github.com/nanoporetech/medaka

cd pomoxis && make install && cd ..
cd medaka && make install && cd ..

POMOXIS=${WALKTHROUGH}/pomoxis/venv/bin/activate
MEDAKA=${WALKTHROUGH}/medaka/venv/bin/activate

cd ${WALKTHROUGH}
NPROC=$(nproc)
BASECALLS=data/basecalls.fa
source ${POMOXIS}
mini_assemble -i ${BASECALLS} -o draft_assm -p assm -t ${NPROC}

cd ${WALKTHROUGH}
source ${MEDAKA}
CONSENSUS=consensus
DRAFT=draft_assm/assm_final.fa
medaka_consensus -i ${BASECALLS} -d ${DRAFT} -o ${CONSENSUS} -t ${NPROC}

# Scripts for prediction part
# Firstly run the first 122 lines in bash file medaka_consensus
cd consensus
medaka consensus calls_to_draft.bam consensus_probs.hdf --model r941_min_high_g360 --batch_size 100 --threads NPROC
