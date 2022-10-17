pipeline {

   agent any
   tools {
        maven "MVN"
        jdk "JDK-11"
    }

   stages {
      stage('Verify Branch') {
         steps {
            echo "$GIT_BRANCH"
            
            
         }
      }
      stage('Build with maven') {
        steps {
            sh 'mvn clean package'
            
            }
        }
      stage('run unit testing') { 
       steps {
         sh 'mvn test'
         }

       post {
       always {
          junit(
        allowEmptyResults: true,
        testResults: '*/test-reports/.xml'
      )
      }
   }
   }
   

      stage('Dependency-check-maven') { 
         steps { 
            sh 'mvn verify'
            }
      }
      


      stage('Docker Build') {
         steps {
            sh 'docker images -a'
            sh """
             
               docker build -t ahmedfathyy/jenkins-pipeline .
               docker images -a
               
            """
         }
      }

      
      stage('check Docker with trivy') { 
         steps { 
            sh 'trivy image ahmedfathyy/jenkins-pipeline'

            }
      }

      
      stage ('Push Docker image'){

            steps{
                echo "============Pushing Docker image==========="
             withCredentials([usernamePassword(credentialsId: 'DockerHub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')])
                {
                sh """
                    docker login -u ${USERNAME} -p ${PASSWORD}
                    docker push ahmedfathyy/jenkins-pipeline:latest
                    """ 
                }
            }
            post {
                success {
                    echo "Docker image pushed successfully"
                }
                failure {
                    echo "Failed to push the image"
                }

            }
            
        }






    }
}
