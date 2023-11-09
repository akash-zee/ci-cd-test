def debPackageName = ''

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
      packageName = debPkg.getPackageName()
      sh "echo 'package Name: ${packageName}'"

      currVer = debRepo.getLatestVersionForPackage(packageName)
      newVer = debPkg.getNewVersion(currVer)
      sh "echo 'current version: ${currVer}, new version: ${newVer}'"

      debPkg.updateVersion(newVer)

      debPackageName = "${packageName}_${newVer}.deb"
      sh "echo 'debPackageName: ${debPackageName}'"
      debPkg.build(debPackageName)
    // sh 'tar -cvzf hello.tar.gz hello.sh'
    }

    stage('publish') {
      if (codeRepo.isDeployementBranch()) {
        debRepo.publishPkg(debPackageName)
        echo 'uploading package...!'
      } else {
        echo 'Not a deployment branch. Not publishing.'
      }
    }
  } finally {
    stage('cleanup') {
      echo 'doing some cleanup...!'
    }
  }
}

