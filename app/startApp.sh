#!/bin/bash
echo "Starting APP ok service";
source /opt/conda/etc/profile.d/conda.sh
conda activate biospytial3;
jupyter notebook --ip=0.0.0.0 --allow-root;
#tail -f /dev/null
