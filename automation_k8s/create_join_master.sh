part_token=$(cat worker-join-command)
master_token=$(cat master-join-command)
echo  "kubeadm join $part_token   
    --control-plane --certificate-key $master_token" > new_master_create.sh
