part_token=$(cat /root/kubernetes/automation_k8s/worker-join-command)
master_token=$(cat /root/kubernetes/automation_k8s/master-join-command)
echo  "$part_token --control-plane --certificate-key $master_token --ignore-preflight-errors=NumCPU" > /root/kubernetes/automation_k8s/master_token.sh
