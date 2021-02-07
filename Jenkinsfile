pipeline {
    // Na sessão agent é informado em qual node será executado o pipeline, any executa em qual node.
    agent any
    
    // Variáveis
    environment {
    WORKSPACE_DIR               =   pwd()
    EC2_USER                    =   'ubuntu'
    EC2_IP                      =   'IP'
    EC2_KEY_SSH                 =   credentials('ssh_connect')
    }

    // Estágios
    stages {
        stage ('Check diretório de log') {
            steps {
                deleteDir()
                dir("${WORKSPACE_DIR}/"){
                    sh ''' if [ ! -d $LOG_DIR ]; then
                            mkdir $LOG_DIR
                         fi '''
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
    }
}