pipeline {

  options {
    ansiColor('xterm')
  }
  
  environment {
        REGISTRY = 'santospv08/app-apache-docker'
  }

  agent {
    kubernetes {
      yamlFile 'builder.yaml'
    }
  }

  stages {

    stage('Build & Push Image') {
      steps {
        container('pvsContainer') {
          script {
            sh '''
            /pvs/executor --dockerfile `pwd`/Dockerfile \
                             --context `pwd` \
                             --destination=$REGISTRY:${BUILD_NUMBER}
            '''
          }
        }
      }
    }

    stage('Deploy pvsApp to Kubernetes') {     
      steps {
        container('kubectl') {
          withCredentials([file(credentialsId: 'mykubeconfig', variable: 'KUBECONFIG')]) {
            sh 'sed -i "s/<TAG>/${BUILD_NUMBER}/" pvsapp.yaml'
            sh 'kubectl apply -f pvsapp.yaml'
          }
        }
      }
    }
  
  }
}