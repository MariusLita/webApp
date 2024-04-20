pipeline for the application:

pipeline {
	agent any
	tools {
	    dotnetsdk "sdk7" // use the sdk tool in order to run .net application
	}

	stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/MariusLita/webApp.git'  // copy from my git repository
            }
        }
        
        stage('Build') {
            steps {
                sh 'dotnet restore --packages ./packages'  // ensure that all the dependecies are available and use cache memory
                sh 'dotnet build -c Release' // build the application
            }
        }
        
        stage('Test') {
            steps {
                sh 'dotnet test' // run the application 
            }
        }
        
    }
    post {
        success {
            archiveArtifacts artifacts: '**/bin/**' // Archive built artifacts    
        }
    }
}