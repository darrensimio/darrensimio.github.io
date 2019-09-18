cd ops

current_dir=`pwd`
echo "$current_dir" 

echo "initializing terraform..."
terraform init

echo "applying changes to prod..."
terraform apply -var-file="darrensim-io.tfvars" -auto-approve