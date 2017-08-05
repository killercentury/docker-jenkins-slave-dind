import java.text.SimpleDateFormat

pipeline {
  agent {
    label "test"
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '2'))
    disableConcurrentBuilds()
  }
  stages {
    stage("build") {
      steps {
        script {
          def dateFormat = new SimpleDateFormat("yy.MM.dd")
          currentBuild.displayName = dateFormat.format(new Date()) + "-" + env.BUILD_NUMBER
        }
        checkout scm
        sh "docker image build -t vfarcic/jenkins-swarm-agent ."
      }
    }
    stage("release") {
      when {
        branch "master"
      }
      steps {
        withCredentials([usernamePassword(
          credentialsId: "docker",
          usernameVariable: "USER",
          passwordVariable: "PASS"
        )]) {
          sh "docker login -u $USER -p $PASS"
        }
        sh "docker tag vfarcic/jenkins-swarm-agent vfarcic/jenkins-swarm-agent:${currentBuild.displayName}"
        sh "docker image push vfarcic/jenkins-swarm-agent:latest"
        sh "docker image push vfarcic/jenkins-swarm-agent:${currentBuild.displayName}"
      }
    }
  }
  post {
    failure {
      slackSend(
        color: "danger",
        message: "${env.JOB_NAME} failed: ${env.RUN_DISPLAY_URL}"
      )
    }
  }
}
