cd ops

current_dir=`pwd`
echo "$current_dir" 

echo "initializing terraform..."
terraform init

echo "applying changes to staging..."
terraform apply -var-file="kb-darrensim-io.tfvars" -auto-approve