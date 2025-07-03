#!/bin/bash

# Script to initialize Terraform backend for different environments
# Usage: ./init-backend.sh [environment]
# Example: ./init-backend.sh dev

set -e

ENVIRONMENT=${1:-dev}
BACKEND_CONFIG_FILE="backend-${ENVIRONMENT}.hcl"

# Check if backend config file exists
if [[ ! -f "$BACKEND_CONFIG_FILE" ]]; then
    echo "Error: Backend configuration file '$BACKEND_CONFIG_FILE' not found!"
    echo "Available backend configurations:"
    ls -1 backend-*.hcl 2>/dev/null || echo "No backend configuration files found"
    exit 1
fi

echo "Initializing Terraform backend for environment: $ENVIRONMENT"
echo "Using configuration file: $BACKEND_CONFIG_FILE"

# Initialize terraform with the backend configuration
terraform init -backend-config="$BACKEND_CONFIG_FILE"

echo "Backend initialization completed successfully!"
echo "You can now run: terraform plan or terraform apply" 