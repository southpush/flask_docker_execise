# identijenk

《Docker开发指南》p100-105的demo，修改了一些使用官方代码遇到的bug。

在jenkins中执行的shell保存在 cmd_for_jenkins.sh 文件中。


- 使用Dockerfile创建identidock时遇到bug
  在jenkins中执行构建，会在sudo docker-compose $COMPOSE_ARGS up -d一步中失败，控制台提示
  ```
  OCI runtime create failed: container_linux.go:348: starting container process caused "exec: \\"/cmd.sh\\": permission denied": unknown'
  ```
  解决方法：修改Dockerfile最后执行cmd.sh一行
  ```
  CMD ["sh", "/cmd.sh"]
  ```

- 每次构建identijenk镜像特别慢 

  参照https://github.com/southpush/docker-jenkins-init  
  修改镜像源，并安装插件


- 测试无法通过
  1. 无法获取IP，获取到的IP为空
    官方给出的获取IP的语法是旧的，使用新语法即可正确获取容器IP
    ```
    IP=$(sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' jenkins_identidock_1)
    ```
  2. 即使正确获取到容器IP，curl无法访问
    因为这时候jenkins容器和identidock容器并不在同一个容器网络中，需要手动连接
    ```
    # disconnect and ignore error
    sudo docker network disconnect jenkins_default jenkins || true
    # connect
    sudo docker network connect jenkins_default jenkins
    ```
