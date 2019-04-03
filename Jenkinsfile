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
        sh "sudo docker image build -t vfarcic/jenkins-swarm-agent ."
      }
    }
    stage("release") {
      when {
        branch "master"
      }
      steps {
        dockerLogin()
        sh "sudo docker tag vfarcic/jenkins-swarm-agent vfarcic/jenkins-swarm-agent:${currentBuild.displayName}"
        sh "sudo docker image push vfarcic/jenkins-swarm-agent:latest"
        sh "sudo docker image push vfarcic/jenkins-swarm-agent:${currentBuild.displayName}"
      }
    }
    stage("deploy") {
      when {
        branch "master"
      }
      agent {
        label "prod"
      }
      steps {
        dfDeploy("jenkins-swarm-agent", "infra_jenkins-agent", "")
      }
    }
  }
  post {
    success {
      slackSend(
        color: "good",
        message: "vfarcic/jenkins-swarm-agent:${currentBuild.displayName} was deployed to the cluster. Verify that it works correctly!"
      )
    }
    failure {
      slackSend(
        color: "danger",
        message: "${env.JOB_NAME} failed: ${env.RUN_DISPLAY_URL}"
      )
    }
  }
}
