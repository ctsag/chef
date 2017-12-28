pipeline {
    agent any

    stages {
        stage('Lint Tests') {
            steps {
                dir('cookbook/nothingness')
                    sh 'pwd'
                }
            }
        }
        stage('Unit Tests') {
            steps {
                echo 'chef exec rspec -f d spec/unit/recipes/*'
            }
        }
    }
}
