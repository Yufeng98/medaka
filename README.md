Run Command
```shell
# Create virtual envirenment
make install
MEDAKA=venv/bin/activate
NPROC=1
source ${MEDAKA}

# Enter dataset folder
cd consensus
medaka consensus calls_to_draft.bam consensus_probs.hdf --model r941_min_high_g360 --batch_size 100 --threads NPROC
```

Create dataset from scratch, see profile.sh.
