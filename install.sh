#!/bin/bash

INSTALL_DIR="$HOME/terraform-ansible-tests"

curl -O https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
bash Miniconda2-latest-Linux-x86_64.sh -p ${INSTALL_DIR} -b
export PATH=${INSTALL_DIR}/bin:$PATH
conda update -y -n base conda
pip install --upgrade pip
conda install --yes -c conda-forge ansible
conda install --yes -c conda-forge terraform
conda install -y wget
conda install -c hargup/label/pypi python-openstackclient
# ansible dynamic inventory to read terraform state files
curl -o ${INSTALL_DIR}/bin/terraform.py https://raw.githubusercontent.com/CiscoCloud/k8sclass/master/02-Install/Terraform/terraform.py
chmod +x ${INSTALL_DIR}/bin/terraform.py

echo -e "\n\nYou only need to do 'export PATH=${INSTALL_DIR}/bin:\$PATH'\n\n"
