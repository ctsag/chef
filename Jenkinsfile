pipeline {
    agent any

    stages {
        stage('Lint Tests') {
            steps {
                echo 'cookstyle .'
                echo 'foodcritic .'
            }
        }
        stage('Unit Tests') {
            steps {
                echo 'chef exec rspec -f d spec/unit/recipes/*'
            }
        }
    }
}
