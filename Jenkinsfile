podTemplate(label: 'docker', containers: [
    containerTemplate(name: 'docker', image: 'docker:1.12.6', ttyEnabled: true, command: '/bin/sh -c', args: 'cat'),
    containerTemplate(name: 'jnlp', image: 'jenkinsci/jnlp-slave', args: '${computer.jnlpmac} ${computer.name}')
    ], volumes: [
    hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')]
    ) {

        node('docker') {
                git url: "https://github.com/jhart99/arachne.git"
                sh "git rev-parse HEAD > .git/commit-id"
                def commit_id = readFile('.git/commit-id').trim()
                println commit_id
            
                stage("build") {
                    container('docker') {
                            def app = docker.build("vogt1005.scripps.edu:5000/test:testing")
                    }
                }
            
        }
   }
