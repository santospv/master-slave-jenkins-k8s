pipeline {

  options {
    ansiColor('xterm')
  }

  agent {
    kubernetes {
      yamlFile 'builder.yaml'
    }
  }

  stages {

    stage('Kaniko Build & Push Image') {
      steps {
        container('kaniko') {
          script {
            sh '''
            /kaniko/executor --dockerfile `pwd`/Dockerfile \
                             --context `pwd` \
                             --destination=santospv08/app-apache-docker:${BUILD_NUMBER}
            '''
          }
        }
      }
    }

    // stage('Deploy App to Kubernetes') {     
    //   steps {
    //     container('kubectl') {
    //       withCredentials([file(credentialsId: 'mykubeconfig', variable: 'KUBECONFIG')]) {
    //         sh 'sed -i "s/<TAG>/${BUILD_NUMBER}/" pvsapp.yaml'
    //         sh 'kubectl apply -f pvsapp.yaml'
    //       }
    //     }
    //   }
    // }
  
  }
}