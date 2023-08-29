pipeline {
  agent any
  stages {
    stage('checkout code') {
      steps {
        git(url: 'https://github.com/roudlek/karateproject', branch: 'main')
      }
    }

    stage('List all files') {
      steps {
        sh 'ls -la'
      }
    }

  }
}