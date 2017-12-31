AKS_PERS_STORAGE_ACCOUNT_NAME=shfeldmastorage$RANDOM
AKS_PERS_RESOURCE_GROUP=shfeldma-K8S-Share
AKS_PERS_LOCATION=westeurope
AKS_PERS_SHARE_NAME=k8sshare
az group create --name $AKS_PERS_RESOURCE_GROUP --location $AKS_PERS_LOCATION
az storage account create -n $AKS_PERS_STORAGE_ACCOUNT_NAME -g $AKS_PERS_RESOURCE_GROUP -l $AKS_PERS_LOCATION --sku Standard_LRS
export AZURE_STORAGE_CONNECTION_STRING=`az storage account show-connection-string -n $AKS_PERS_STORAGE_ACCOUNT_NAME -g $AKS_PERS_RESOURCE_GROUP -o tsv`
echo $AZURE_STORAGE_CONNECTION_STRING
az storage share create -n $AKS_PERS_SHARE_NAME
STORAGE_KEY=$(az storage account keys list --resource-group $AKS_PERS_RESOURCE_GROUP --account-name $AKS_PERS_STORAGE_ACCOUNT_NAME --query "[0].value" -o tsv)
echo $STORAGE_KEY
echo -n $AKS_PERS_STORAGE_ACCOUNT_NAME | base64
echo -n $STORAGE_KEY | base64