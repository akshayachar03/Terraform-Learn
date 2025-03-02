# Vault Integration with Terraform and AWS

This guide provides detailed steps to set up HashiCorp Vault on an AWS EC2 instance, configure AppRole authentication, and use Terraform to retrieve secrets from Vault.

## Folder Structure
```
Example-4/
│── main.tf
└── README.md
```

---

## Step 1: Create an AWS EC2 Instance
To create an AWS EC2 instance with Ubuntu:

1. Log in to the AWS Management Console.
2. Navigate to the EC2 service and click **Launch Instance**.
3. Select **Ubuntu Server xx.xx LTS AMI**.
4. Choose an instance type (e.g., `t2.micro`).
5. Configure the instance settings as required.
6. Click **Launch** and select or create a key pair for SSH access.

---

## Step 2: Install Vault on EC2 Instance
Run the following commands to install Vault:

### Install GPG
```bash
sudo apt update && sudo apt install gpg
```

### Download and Verify HashiCorp’s GPG Key
```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
```

### Add the HashiCorp Repository and Install Vault
```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install vault
```

---

## Step 3: Start Vault Server
Run Vault in development mode for testing:
```bash
vault server -dev -dev-listen-address="0.0.0.0:8200"
```

Export the Vault address:
```bash
export VAULT_ADDR="http://127.0.0.1:8200"
```

---

## Step 4: Configure Vault for Terraform Authentication (CLI)

### Enable AppRole Authentication
```bash
vault auth enable approle
```

### Create a Policy for Terraform
```bash
vault policy write terraform - <<EOF
path "*" {
  capabilities = ["list", "read"]
}

path "secrets/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "kv/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "secret/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "auth/token/create" {
  capabilities = ["create", "read", "update", "list"]
}
EOF
```

### Create an AppRole
```bash
vault write auth/approle/role/terraform \
    secret_id_ttl=10m \
    token_num_uses=10 \
    token_ttl=20m \
    token_max_ttl=30m \
    secret_id_num_uses=40 \
    token_policies=terraform
```

### Retrieve Role ID and Secret ID
```bash
vault read auth/approle/role/terraform/role-id
vault write -f auth/approle/role/terraform/secret-id
```
Save these credentials for Terraform authentication.

---

## Step 5: Configure Vault for Terraform Authentication (UI)

### Enable AppRole Authentication
1. Open Vault UI and log in as the root user.
2. Navigate to **Access** → **Auth Methods**.
3. Click **Enable New Method** and select **AppRole**.
4. Click **Enable Method**.

### Create a Secret
1. Navigate to **Secrets** → **KV**.
2. Click **Create Secret**.
3. Provide a path (e.g., `kv/test-secret`).
4. Add key-value pairs (e.g., `akshay: my-secret-value`).
5. Click **Save**.

---

## Step 6: Run Terraform

### Initialize Terraform
```bash
terraform init
```

### Plan and Apply the Configuration
```bash
terraform plan
terraform apply -auto-approve
```

This will create an AWS EC2 instance with a secret fetched from Vault.

---

## Step 7: Destroy Resources
If you need to delete the created resources, use the following command:
```bash
terraform destroy -auto-approve
```
This will remove all infrastructure components created by Terraform.

---

## Conclusion
This guide demonstrated how to set up HashiCorp Vault on an EC2 instance, configure AppRole authentication via CLI and UI, create secrets, and integrate Vault with Terraform to securely retrieve secrets for AWS resource provisioning.

