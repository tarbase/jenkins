pipeline {
    agent any
    options {
        timestamps()
        ansiColor('xterm')
        buildDiscarder(
            logRotator(
                artifactDaysToKeepStr: '9',
                artifactNumToKeepStr: '5',
                daysToKeepStr: '9',
                numToKeepStr: '5'
            )
        )
    }

    environment {
        workspace = pwd()
        M0 = "static mimo"
    }

    stages {
        stage('00') {
            steps {
                echo "### FETCH RUBY ###"
                script {
                    sh(script:
                    """
                    test -d .rbenv && cd .rbenv ; git pull || git clone https://github.com/rbenv/rbenv.git .rbenv
                    test -d .rbenv/plugins/ruby-build && cd .rbenv/plugins/ruby-build ; git pull || git clone https://github.com/rbenv/ruby-build.git .rbenv/plugins/ruby-build
                    """,
                    returnStdout: true).trim()
                }
            }
        }
        stage('01') {
            steps {
                echo "#### SETUP ENV ###"
                script {
                    sh(script:
                    """
                    echo 'export PATH=\"\$HOME/.rbenv/bin:\$PATH\"' >> .bash_profile
                    echo 'export PATH=\"\$HOME/.rbenv/plugins/ruby-build/bin:\$PATH\"' >> .bash_profile
                    echo 'eval \"\$(rbenv init -)\"' >> .bashrc
                    """, returnStdout: true).trim()
                }
            }
        }
        stage('02') {
            steps {
                echo "### COMPUTE ###"
                script {
                    GOONE = sh(script: "echo FROM COMPUTE: [${env.M0}] XX", returnStdout: true).trim()
                    GOTWO = getstuff()
                }
            }
        }
        stage('03') {
            steps {
                echo "### USE ###"
                script {
                    sh(script: "echo USE [${GOTWO}]", returnStdout: true).trim()
                }
            }
        }
        stage('04') {
            steps {
                echo "### MERGE ###"
                script {
                    usestuff()
                }
            }
        }
    }
}

def getstuff() {
    sh(script:
    """
    echo \"[${env.workspace} ${GOONE}]\"
    """, returnStdout: true).trim()
}


def usestuff() {
    mikeyfunc = getstuff()
    sh(script: "echo mimi [${mikeyfunc}] mimi", returnStdout: true).trim()
}
