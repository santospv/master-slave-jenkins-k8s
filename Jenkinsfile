pipeline {
agent{
    kubernetes{
        label 'slave'
    }
}
    environment {
        ZONE = "XX"
        PROJECT_ID = "XX"
    }

    stages{
        
        stage("git checkout"){
            steps{
                script{
        git(
            url: 'https://github.com/santospv/master-slave-jenkins-k8s.git',
            credentialsId: 'git-token',
            branch: 'main'
            )
                }
            }
        }
        
        stage("Building Application Docker Image"){
            steps{
                script{
                    sh 'docker build . -t santospv08/jenkins-slave:${BUILD_NUMBER}'
                }
            }
        }
        // stage("Pushing Application Docker Image to Google Artifact Registry"){
        //     steps{
        //         script{
        //             sh 'docker push asia-south1-docker.pkg.dev/xx/jenkins/hello-app:${BUILD_NUMBER}'
        // }}}
        // stage ("Updating Deployment Manifest") {
        //     steps {
        //         script {
        //             sh 'sed -i s+asia-south1-docker.pkg.dev/xx/jenkins/hello-app:v1+asia-south1-docker.pkg.dev/xx/jenkins/hello-app:${BUILD_NUMBER}+g manifests/deployment.yaml'
        //         }
        //     }
        // }
        // stage("Application Deployment on Google Kubernetes Engine"){
        //     steps{
        //         script{
        //             sh "gcloud container clusters get-credentials app-cluster --zone ${env.ZONE} --project ${env.PROJECT_ID}"
        //             sh 'kubectl apply -f manifests/.'
        //         }
        //     }
        // }
    }
}