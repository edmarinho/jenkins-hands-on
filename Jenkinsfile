pipeline {
    // Na sessão agent é informado em qual node será executado o pipeline, any executa em qual node.
    agent any
    
    // Variáveis
    environment {
    WORKSPACE_DIR               =   pwd()
    GIT_HUB                     =   'https://github.com/edmarinho/jenkins-hands-on.git'
    }

    // Estágios
    stages {
        stage ('Check diretório de log') {
            steps {
                deleteDir()
                dir("${WORKSPACE_DIR}/"){
                    git credentialsId: 'github_credentials',
                        branch: 'master',
                        url: "${GIT_HUB}"
                    sh 'npm install'
                }
            }
        }
        stage ('APT-GET update') {
            steps {
                sshPublisher(publishers: 
                    [sshPublisherDesc
                        (configName: 'WEBSITE',
                        transfers:
                            [sshTransfer
                                (cleanRemote: false,
                                excludes: '',
                                execCommand: 'sudo apt-get update',
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
        stage ('Install dependencies') {
            steps {
                sshPublisher(publishers: 
                    [sshPublisherDesc
                        (configName: 'WEBSITE',
                        transfers:
                            [sshTransfer
                                (cleanRemote: false,
                                excludes: '',
                                execCommand: 'sudo apt install nginx nodejs npm -y && sudo npm install -g grunt-cli',
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
    }
}