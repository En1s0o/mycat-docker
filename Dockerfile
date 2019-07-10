FROM centos:7

# 安装 Java
ADD jdk-8u212-linux-x64.tar.gz /opt
ENV JAVA_HOME /opt/jdk1.8.0_212
ENV JRE_HOME $JAVA_HOME/jre
ENV PATH $PATH:$JAVA_HOME/bin

# MYCAT 环境变量
ENV MYCAT_INSTALL_PATH /opt
ENV MYCAT_HOME $MYCAT_INSTALL_PATH/mycat
ENV PATH $PATH:$MYCAT_HOME/bin

# 安装 MYCAT，mycat_dist 可以是本系统的一个目录或者 tar 压缩包
ARG mycat_dist=NOT_SET
ADD $mycat_dist $MYCAT_INSTALL_PATH

VOLUME /opt/mycat/conf
EXPOSE 8066 9066
CMD ["mycat", "console"]
