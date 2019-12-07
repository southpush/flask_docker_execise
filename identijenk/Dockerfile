FROM jenkins/jenkins:lts

USER root

# 替换镜像源
COPY sources.list /
RUN cat /sources.list > /etc/apt/sources.list

# step 1: 安装必要的一些系统工具
RUN apt-get update \
    && apt-get -y install \
        apt-transport-https \
        ca-certificates \
        sudo \
        curl \
        software-properties-common
# step 2: 安装GPG证书
RUN curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/debian/gpg | sudo apt-key add -
# Step 3: 写入软件源信息
RUN add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/debian $(lsb_release -cs) stable"
# Step 4: 更新并安装Docker-CE
RUN apt-get -y update \
    &&  apt-get -y install docker-ce \
    && rm -rf /var/lib/apt/lists/*

# 执行sudo时不需要输入密码
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# 安装docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/1.25.1-rc1/docker-compose-`uname -s`-`uname \
    -m` -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# 切换用户
USER jenkins

# 安装插件
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt \
    && echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state