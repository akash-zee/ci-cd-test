node {
  try {
    stage('checkout') {
      checkout scm
    }

    stage('prepare') {
      sh "echo \"Checking jenkins environment variables: $DEB_REPO_HOST $DEB_REPO_TYPE\""
      test.printMsg('Hello, shared lib message is working!!')
      sh "echo \"Checking shared lib variables: ${debRepo.HOST} ${debRepo.TYPE}\""
      sh "echo \"Checking shared lib variables: $debRepo.HOST $debRepo.TYPE\""
      test.printMsg(debRepo.HOST)
      test.printMsg("${debRepo.HOST}")
      sh 'git clean -fdx'
    }

    stage('compile') {
      echo 'nothing to compile for hello.sh...'
    }

    stage('test') {
      sh './test_hello.sh'
    }

    stage('package') {
      //helper.updateVersion(debRepo.HOST, debRepo.TYPE, 'test-ci-cd')
      helper.updateVersion('test-ci-cd')
      // sh 'tar -cvzf hello.tar.gz hello.sh'
    }

    stage('publish') {
      echo 'uploading package...!'
    }
  } finally {
    stage('cleanup') {
      echo 'doing some cleanup...!'
    }
  }
}

