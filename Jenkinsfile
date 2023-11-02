node {
  try {
    stage('checkout') {
      checkout scm
    }
    stage('prepare') {
      sh "echo $DEB_REPO_HOST $DEB_REPO_TYPE"
      test.printMsg('Hello, shared lib message is working!!')
      test.printMsg('Test msg 4')
      sh 'git clean -fdx'

    }
    stage('compile') {
      echo 'nothing to compile for hello.sh...'
    }
    stage('test') {
      sh './test_hello.sh'
    }
    stage('package') {
      sh 'tar -cvzf hello.tar.gz hello.sh'
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

