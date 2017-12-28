pipeline {
    agent any

    dir('cookbook/nothingness')

    stages {
        stage('Lint Tests') {
            steps {
                sh 'pwd'
            }
        }
        stage('Unit Tests') {
            steps {
                echo 'chef exec rspec -f d spec/unit/recipes/*'
            }
        }
    }
}
