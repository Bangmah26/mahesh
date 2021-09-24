#!/bin/bash
sudo sed -i '/azurevm/d' /etc/ansible/hosts
az login --service-principal -u="${ARM_CLIENT_ID}" -p="${ARM_CLIENT_SECRET}" -t="${ARM_TENANT_ID}" > /dev/null
ip=`az vm list-ip-addresses -n myVM -g proj1-rg --query [].virtualMachine.network.publicIpAddresses[0].ipAddress -o tsv`
echo -e "azurevm ansible_host=$ip ansible_ssh_extra_args='-o StrictHostKeyChecking=no'" | sudo tee -a /etc/ansible/hosts > /dev/null

