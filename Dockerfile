FROM jenkins

#install Android SDK
USER root

RUN dpkg --add-architecture i386
RUN apt-get update -y
RUN apt-get install -y libncurses5:i386 libstdc++6:i386 zlib1g:i386

RUN wget -q http://dl.google.com/android/android-sdk_r24.3.4-linux.tgz
RUN tar -xvzf android-sdk_r24.3.4-linux.tgz
RUN mv android-sdk-linux /usr/local/android-sdk
RUN rm android-sdk_r24.3.4-linux.tgz

ENV ANDROID_HOME /usr/local/android-sdk
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANDROID_HOME/build-tools/23.0.1

RUN echo "y" | android update sdk --no-ui --force --filter tools,platform-tools,extra-android-support,extra-android-m2repository,android-23,build-tools-23.0.1

USER jenkins

#install plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
