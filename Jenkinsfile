def containers = ["ldap']
podTemplate(label: 'docker', containers: [
        containerTemplate(name: 'docker',
            image: 'docker:1.12.6',
            ttyEnabled: true,
            command: '/bin/sh -c', 
            args: 'cat'),
        containerTemplate(name: 'jnlp',
            image: 'jenkinsci/jnlp-slave',
            args: '${computer.jnlpmac} ${computer.name}')
    ], volumes: [
        hostPathVolume(hostPath: '/var/run/docker.sock',
            mountPath: '/var/run/docker.sock')]
) {
    //git url: "https://github.com/jhart99/arachne.git"
    //    sh "git rev-parse HEAD > .git/commit-id"
    //    def commit_id = readFile('.git/commit-id').trim()
    //    println commit_id

    node('docker') {
        checkout scm
        commit = sh(returnStdout: true, script: "git log -n 1 --pretty=format:'%h'").trim()
        echo commit
        for (container in containers) {
        stage("build $container") {
            container('docker') {
                dir("docker/$container/docker"){
                    sh "docker build -t vogt1005.scripps.edu:5000/$container:${commit} ."
                }
            }
        }
        stage("test $container") {
            container('docker') {
                sh "echo test passed"
            }
        }
        stage("deploy $container") {
            container('docker') {
                sh """
                    docker tag vogt1005.scripps.edu:5000/$container:${commit} vogt1005.scripps.edu:5000/$container:latest
                    docker push vogt1005.scripps.edu:5000/$container:latest
                    """
            }
        }
    }
}
