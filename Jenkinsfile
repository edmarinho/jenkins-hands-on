pipeline {
    // Na sessão agent é informado em qual node será executado o pipeline, any executa em qual node.
    agent any
    
    // Variáveis
    environment {
    WORKSPACE_DIR               =   pwd()
    GITHUB_URL                  =   'https://github.com/edmarinho/jenkins-hands-on.git'
    GITHUB_BRANCH               =   'main'
    }

    // Estágios
    stages {
        stage ('Clone repository') {
            steps {
                deleteDir()
                dir("${WORKSPACE_DIR}/"){
                    git branch: "${GITHUB_BRANCH}",
                        url: "${GITHUB_URL}"
                    sh 'cd app/ && npm install'
                }
            }
        }
        stage ('Install WebServer') {
            steps {
                sshPublisher(publishers: 
                    [sshPublisherDesc
                        (configName: 'WEBSITE',
                        transfers:
                            [sshTransfer
                                (cleanRemote: false,
                                excludes: '',
                                execCommand: 'sudo apt update && apt install nginx -y',
                                execTimeout: 120000,
                                flatten: false,
                                makeEmptyDirs: false,
                                noDefaultExcludes: false,
                                patternSeparator: '[, ]+',
                                remoteDirectory: '',
                                remoteDirectorySDF: false,
                                removePrefix: '',
                                sourceFiles: '')
                            ],
                        usePromotionTimestamp: false,
                        useWorkspaceInPromotion: false,
                        verbose: true)
                    ]
                )
            }
        }
        stage ('Build Application') {
            steps {
                dir("${WORKSPACE_DIR}/app/"){
                    sh 'npm install'
                }
            }
        }
        stage ('Deploy Application') {
            steps {
                sshPublisher(publishers: 
                    [sshPublisherDesc
                        (configName: 'WEBSITE',
                        transfers:
                            [sshTransfer
                                (cleanRemote: false,
                                excludes: '',
                                execCommand: 'sudo cp -R /home/ubuntu/app/* /var/www/html/',
                                execTimeout: 120000,
                                flatten: false,
                                makeEmptyDirs: false,
                                noDefaultExcludes: false,
                                patternSeparator: '[, ]+',
                                remoteDirectory: 'app/',
                                remoteDirectorySDF: false,
                                removePrefix: 'app',
                                sourceFiles: "app/*")
                            ],
                        usePromotionTimestamp: false,
                        useWorkspaceInPromotion: false,
                        verbose: true)
                    ]
                )
            }
        }
    }
}