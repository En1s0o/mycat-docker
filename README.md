# mycat-docker
构建 mycat docker 镜像的脚本

- 构建前准备

    - 需要下载 jdk-8u212-linux-x64.tar.gz（github 限制 100MB，无法上传）

        http://mirrors.linuxeye.com/jdk/jdk-8u212-linux-x64.tar.gz

        > 如果使用其他版本的 jdk，需要修改 Dockerfile



- 构建 mycat docker 镜像（默认使用本仓库携带的 mycat）

    ```shell
    ./build.sh --from-local-dist
    ```

    或者，也可以指定 mycat（如果有多个 Mycat-*.tar.gz，这样做是必须的）

    ```shell
    ./build.sh --from-local-dist --archive Mycat-server-1.6.7.1-release-20190627191042-linux.tar.gz
    ```



- 使用远程地址构建

    ```shell
    ./build.sh --from-release --mycat-url http://dl.mycat.io/1.6.7.1/Mycat-server-1.6.7.1-release-20190627191042-linux.tar.gz
    ```



- 运行/停止 mycat

    - 运行前准备

        准备两个目录（自定义，需要与 docker-compose.yml 一致）

        ```shell
        mkdir -p /home/iot/mycat/conf
        mkdir -p /home/iot/mycat/logs
        ```

        将 mycat 压缩包 `mycat/conf` 目录下的所有内容拷贝到 `/home/iot/mycat/conf` 下

    - 启动 mycat

        ```shell
        docker-compose up -d
        ```

    - 停止

        ```shell
        docker-compose down
        ```



**特别提示**

这里使用了 **jdk-8u212-linux-x64.tar.gz**，如果用于商用，请务必阅读相关 license，或者更换为 openjdk。

