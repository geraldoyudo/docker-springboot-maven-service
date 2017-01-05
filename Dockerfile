FROM geraldoyudo/java-8-maven-git

COPY conf/application.yml /conf/application.yml
COPY entry-point.sh /entry-point.sh

ENV projectUrl ${url}
ENV projectBranch ${branch}
ENV projectFolder ${folder}
ENV logFolder ${log:-/user/service/out.txt}


RUN svn checkout ${projectUrl}/branches/${branch:-master}/${folder} project &&/
	cd project &&/
	mvn install -DskipTests &&/
	cp *.* /workdir
	
ENTRYPOINT ["/entry-point.sh"]

