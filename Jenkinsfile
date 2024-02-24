pipeline {
    agent any

    stages {
            stage('Install Terraform') {
            steps {
                sh 'sudo apt-get update && sudo apt-get install -y gnupg software-properties-common'
                sh 'wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg'
                sh 'echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list'
                sh 'sudo apt update'
                sh 'sudo apt-get install terraform'
                sh 'terraform -v'
            }
        }
        stage('Checkout from GIT') {
            steps {
                git branch: 'main', url: 'https://github.com/palashpdevops/tformaws/'
            }
        }
    stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
    stage('Terraform Plan') {
            steps {
                withCredentials([aws(accessKeyVariable:'AWS_ACCESS_KEY_ID',credentialsId:'jenkinstform',secretKeyVariable:'AWS_SECRET_ACCESS_KEY')]){
                sh 'terraform plan'
            }
            }
        }
    stage('Terraform Apply') {
            steps {
                withCredentials([aws(accessKeyVariable:'AWS_ACCESS_KEY_ID',credentialsId:'jenkinstform',secretKeyVariable:'AWS_SECRET_ACCESS_KEY')]){
                sh 'terraform apply --auto-approve'
            }
            }
        }  
    stage('Terraform Destroy') {
            steps {
                withCredentials([aws(accessKeyVariable:'AWS_ACCESS_KEY_ID',credentialsId:'jenkinstform',secretKeyVariable:'AWS_SECRET_ACCESS_KEY')]){
                sh 'terraform destroy'
            }
            }
        }        
    }    
}
