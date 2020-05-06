#!/usr/bin/env groovy

@Library('Utilities') _

def pushDockerImageAs(sourceImage, destImage) {
    sh "docker tag ${sourceImage} ${destImage}"
    sh "docker push ${destImage}"
    sh "docker rmi -f ${destImage}"
}

/**
 * - If building the aa_afa-library master branch or a pull request targetting the master aa_afa-library, use the aa_reporting-framework master branch,
 * - else if building the aa_afa-library support/1.1.2.x branch or a pull request targetting the support/1.1.2.x branch, use the v1.1.2 aa_reporting-framework tag,
 * - else if building a aa_afa-library tag, use a aa_reporting-framework tag with the exact same name,
 * - else use the aa_reporting-framework develop branch.
 */
def getLibBranch() {
    def baseBranchOrPullRequestTargetBranch = [env.BRANCH_NAME, env.CHANGE_TARGET]
    def libBranch
    if (env.TAG_NAME) {
        libBranch = env.TAG_NAME
    } else if ('master' in baseBranchOrPullRequestTargetBranch) {
        libBranch = "master"
    } else if ('support/1.1.2.x' in baseBranchOrPullRequestTargetBranch) {
        libBranch = "v1.1.2"
    } else {
        libBranch = "develop"
    }
    return libBranch;
}

/**
* Define the name that will be given to the packaged KB.
*/
def getKbPackageName() {
    // Get current project name
    def kbName = sh(
        returnStdout: true,
        script: "yseop config ./bootstrap -f KB"
    ).trim()

    // Change project name by adding branch name
    if ("$env.BRANCH_NAME" == 'master' || env.TAG_NAME) {
        return kbName
    } else {
        return kbName + '-' + ("$env.BRANCH_NAME").replace('/', '-').replace('.', '_')
    }
}

/**
 * Define the version number that will be used to publish to Maven.
 * If building from a tag, use the tag name (minus the optional 'v' prefix),
 * or else use the PR name or branch name with the '-SNAPSHOT' suffix.
 */
String getMavenVersion() {
    def mavenVersion
    if (env.TAG_NAME) {
        // Git version tag implement the 'vX.X.X' convention while the Maven version uses 'X.X.X', hence this small correction
        mavenVersion = env.TAG_NAME.startsWith('v') ? env.TAG_NAME.substring(1) : env.TAG_NAME
    } else if (env.CHANGE_ID) {
        mavenVersion = "pr-${env.CHANGE_ID}-SNAPSHOT"
    } else {
        String branch = env.GIT_BRANCH.replaceAll("\\/", "_")
        mavenVersion = "branch-${branch}-SNAPSHOT"
    }
    return mavenVersion
}

pipeline {
    agent {
        node {
            label 'yseopml'
        }
    }

    options {
        timeout(time: 30, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    environment {
        DOCKER_BUILD_TAG           = utils.getDockerBuildTag()
        DOCKER_TAG                 = utils.getDockerTag()
        GITHUB_TOKEN               = credentials("github")
        DOCKER                     = credentials('docker-hub')
        DOCKER_CUSTOMER_REPOSITORY = 'yseopcustomers'
        DOCKER_STAGING_REPOSITORY  = 'yseopops'
        DOCKER_AFA_NLG             = 'afa_nlg'
        YM_VERSION                 = '7.27.0'
        LIB_BRANCH                 = getLibBranch()
        SLACK_NOTIFY               = sh(script: "git --no-pager show -s --format=%ae  | cut -d '@' -f1", returnStdout: true).trim()
        ORG_GRADLE_PROJECT_version = getMavenVersion()
    }

    stages {
        stage ('Abort previous build') {
            steps {
                script {
                    utils.killPreviousBuilds()
                }
            }
        }

        stage('Configure') {
            steps {
                sh "printf '%s\n' \"${env.DOCKER_PSW}\" | docker login --username \"${env.DOCKER_USR}\" --password-stdin"
            }
        }

        stage('Generate Documentation') {
            steps {
                sh "./scripts/generate-documentation-jenkins.sh"
            }
        }

        stage('Build the AFA library') {
            parallel {
                stage('Windows') {
                    agent {
                        node {
                            label 'win-kernel'
                        }
                    }
                    stages {
                        stage('Build library') {
                            steps {
                                withCredentials([
                                    usernamePassword(
                                        credentialsId: 'nexus3',
                                        usernameVariable: 'ORG_GRADLE_PROJECT_mavenUser',
                                        passwordVariable: 'ORG_GRADLE_PROJECT_mavenPassword'
                                )]) {
                                    bat 'cd library/ && .\\gradlew.bat installYmlLibWindows --refresh-dependencies'
                                    bat 'yseop.bat compile library/'
                                }
                            }
                        }
                        stage('Compile test project') {
                            steps {
                                bat 'yseop.bat compile test_project/'
                            }
                        }
                        stage('Test') {
                            steps {
                                bat 'yseop.bat test -j 8 test_project/ -s test_project/test/transfo-json'
                            }
                            post {
                                always {
                                    // Archive build artifacts
                                    archiveArtifacts artifacts: 'test_project/test/output/**'
                                    // Archive test reports
                                    junit allowEmptyResults: true, testResults: '**/test/reports/*.xml'
                                }
                            }
                        }
                        stage('Stash library') {
                            steps {
                                // stash only once tests are successful
                                stash(name:'windows-libs', includes:'**/*-windows.p?0.?1')
                            }
                        }
                    }
                    post {
                        always {
                            // Clean up our workspace
                            cleanWs deleteDirs: true
                            deleteDir()
                        }
                    }
                }
                stage('Linux') {
                    stages {
                        stage('Build library') {
                            steps {
                                withCredentials([
                                    usernamePassword(
                                        credentialsId: 'nexus3',
                                        usernameVariable: 'ORG_GRADLE_PROJECT_mavenUser',
                                        passwordVariable: 'ORG_GRADLE_PROJECT_mavenPassword'
                                )]) {
                                    sh 'cd library/ && ./gradlew installYmlLibLinux --refresh-dependencies'
                                    sh 'yseop compile library/'
                                }
                            }
                        }
                        stage('Compile test project') {
                            steps {
                                sh 'yseop compile test_project/'
                            }
                        }
                        stage('Test') {
                            steps {
                                sh 'yseop test -j 4 test_project/'
                            }
                            post {
                                always {
                                    // Archive build artifacts
                                    archiveArtifacts artifacts: 'test_project/test/output/**'
                                    // Archive test reports
                                    junit allowEmptyResults: true, testResults: '**/test/reports/*.xml'
                                }
                            }
                        }
                    }
                }
            }
        }

        stage('Publish library') {
            steps {
                unstash('windows-libs')
                withCredentials([
                    usernamePassword(
                        credentialsId: 'nexus3',
                        usernameVariable: 'ORG_GRADLE_PROJECT_mavenUser',
                        passwordVariable: 'ORG_GRADLE_PROJECT_mavenPassword'
                )]) {
                    echo "Publishing version ${env.ORG_GRADLE_PROJECT_version}"
                    sh 'yseop libs publish library/'
                }
            }
        }

        stage('Build and package bootstrap') {
            environment {
                KB_PACKAGE_NAME = getKbPackageName()
            }
            steps {
                // Tell the KB to use the new version of the library.
                sh "sed -i 's/^\\(\\s*CompilerConfiguration.useLibrary\\s*=\\s*com.yseop:aa_afa-library:\\).*\$/\\1${env.ORG_GRADLE_PROJECT_version}/' bootstrap/.settings/com.yseop.designer.prefs"
                withCredentials([
                    usernamePassword(
                        credentialsId: 'nexus3',
                        usernameVariable: 'ORG_GRADLE_PROJECT_mavenUser',
                        passwordVariable: 'ORG_GRADLE_PROJECT_mavenPassword'
                )]) {
                    sh 'cd bootstrap/ && ./gradlew installYmlLib --refresh-dependencies'
                    sh "yseop compile bootstrap/"
                }
                sh "yseop package bootstrap/ --deploy-name ${KB_PACKAGE_NAME}"
                sh "test -r bootstrap/${KB_PACKAGE_NAME}.yma"
                sh "test -s bootstrap/${KB_PACKAGE_NAME}.yma"
            }
        }

        stage('Build Docker image') {
            steps {
                script {
                    sh([
                        'yseop docker build',
                        /* Verbose. */
                        '-v',
                        /* Base YM image. */
                        "-y '${DOCKER_STAGING_REPOSITORY}/ym:${YM_VERSION}'",
                        /* Image name. */
                        "-i '${DOCKER_AFA_NLG}:${DOCKER_BUILD_TAG}'",
                        /* KB directory. */
                        'bootstrap/'
                    ].join(' '))
                    sh "yseop docker test '${DOCKER_AFA_NLG}:${DOCKER_BUILD_TAG}'"
                }
            }
        }

        stage('Scan Docker image') {
            steps  {
                script {
                    utils.scanDockerImage("${DOCKER_AFA_NLG}:${DOCKER_BUILD_TAG}")
                }
            }
        }

        stage('Publish Docker image') {
            steps {
                script {
                    for (flavor in ['', '-debug']) {
                        pushDockerImageAs("${DOCKER_AFA_NLG}:${DOCKER_BUILD_TAG}${flavor}", "${DOCKER_STAGING_REPOSITORY}/${DOCKER_AFA_NLG}:${DOCKER_TAG}${flavor}")
                    }
                }
            }
        }

        stage('Publish Docker for customers') {
            when {
                anyOf {
                    branch 'master'
                    branch 'support/1.1.2.x'
                    buildingTag()
                }
            }
            steps {
                script {
                    for (flavor in ['', '-debug']) {
                        pushDockerImageAs("${DOCKER_AFA_NLG}:${DOCKER_BUILD_TAG}${flavor}", "${DOCKER_CUSTOMER_REPOSITORY}/${DOCKER_AFA_NLG}:${DOCKER_TAG}${flavor}")
                    }
                }
            }
        }

        stage('Deploy') {
            when {
                anyOf {
                    branch 'develop'
                    branch 'master'
                }
            }
            steps {
                build job: "../anna_master/${GIT_BRANCH}", wait: false, propagate: false
            }
        }

        stage('Build documentation') {
            when {
                branch 'develop'
            }
            steps {
                script {
                    // Project yseop-doc does not use 'git flow'. Its master branch is the staging branch.
                    build job: 'yseop-doc/master', wait: false
                }
            }
        }
    }

    post {
        success {
            // Archive build artifacts
            archiveArtifacts artifacts: '**/*.yma', fingerprint: true, allowEmptyArchive: true

            // Clean up our workspace
            cleanWs deleteDirs: true
            deleteDir()

            slackSend (color: 'good', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
        failure {
            slackSend (color: 'danger', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL}) <@${SLACK_NOTIFY}>")
        }
        always {
            archiveArtifacts artifacts: '**/test/output/**', allowEmptyArchive: true

            // Archive test reports
            junit allowEmptyResults: true, testResults: '**/test/reports/*.xml'
        }
    }
}
