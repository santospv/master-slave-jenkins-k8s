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

    stage('Deploy App to Kubernetes') {     
      steps {
        container('kubectlkubectl') {
          // withCredentials([file(credentialsId: 'mykubeconfig', variable: 'KUBECONFIG')]) {
            sh 'gcloud auth activate-service-account --key-file=serviceaccount.json'
            sh 'gcloud container clusters get-credentials pvs-devops-iac-gke --zone us-south1-c --project pvs-devops-iac'
            sh 'kubectl get nodes'
            sh 'sed -i "s/<TAG>/${BUILD_NUMBER}/" pvsapp.yaml'
            sh 'kubectl apply -f pvsapp.yaml'
          // }
        }
      }
    }
  
  }
}

// stage('Deploy'){
//     steps{

//         //Deploy to GCP
//         sh """
//             #!/bin/bash 
//             echo "deploy stage";
//             curl -o /tmp/google-cloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-225.0.0-linux-x86_64.tar.gz;
//             tar -xvf /tmp/google-cloud-sdk.tar.gz -C /tmp/;
//             /tmp/google-cloud-sdk/install.sh -q;

//                         source /tmp/google-cloud-sdk/path.bash.inc;


//              gcloud config set project ${GOOGLE_PROJECT_ID};
//              gcloud components install app-engine-java;
//              gcloud components install app-engine-python;
//              gcloud auth activate-service-account --key-file ${GOOGLE_SERVICE_ACCOUNT_KEY};

//              gcloud config list;
//              gcloud app deploy --version=v01;
//                          echo "Deployed to GCP"
//         """
//         }   

// }