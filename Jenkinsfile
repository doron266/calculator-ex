pipeline {
  agent any

  environment {
    IMAGE_NAME = "calculator:latest"
    FILE_NAME= "Jenkinsfile"
    DRIVER_NAME = "ours"
    PUSH_IMAGE = "false"   // set to "true" to push to local registry
    COMMIT_MASSAGE = "#1"
  }

  stages {
    stage('Build Image') {
      steps { sh 'docker build -t $IMAGE_NAME .' }
    }
    stage('Unit Tests') {
      steps { sh 'docker run --name calc -d $IMAGE_NAME sh -c "python -m unittest discover -s tests -v"' }
    }
    stage('HealthChecheck Test') {
      steps { sh 'docker exec calc curl -fsS http://localhost:5000/health' }
    }
   
      }
 }

