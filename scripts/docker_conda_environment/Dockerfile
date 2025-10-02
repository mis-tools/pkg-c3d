FROM continuumio/miniconda3:24.1.2-0
RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get install -y rsync
RUN  /bin/bash -c "/opt/conda/bin/conda install conda-build conda-verify -y --quiet"
RUN  chmod o+w -R "/opt/conda"
