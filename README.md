# Setup

## Requirements

- Docker must be installed
- To be able to execute scripts

```bash
sudo apt-get install fzf tree yq
```

```bash
pip install graphviz diagrams

```

## Terraform state remote backend - lock files resources (s3 bucket and dynamodb table)
```bash
cd /terraform/live/shared/setup/terraform_state
terraform init
terraform plan
terraform apply
```

# Documentation
## Generate terraform modules documentation
```bash
cd terraform
./modules/doc.sh
```

# Deployment
## Deployment all infrastructure

```bash
./deploy.sh
```

## Destroy all infrastructure

```bash
./destroy.sh
```

## Interactive deployment

```bash
cd terraform
./interactive.sh
```

## Perform terraform actions (plan, apply, destroy)

```bash
cd terraform
./tf.sh <action> <env> <resource>
./tf.sh <plan|apply|destroy> <test|prod|shared> <resource>
```

