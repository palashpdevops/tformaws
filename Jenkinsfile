pipeline {
    agent any

    stages {
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
                sh 'terraform plan'
            }
        }
    stage('Terraform Apply') {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }        
    }    
}
