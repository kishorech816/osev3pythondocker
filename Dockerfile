# Using RHEL 7 base image and Apache Web server
FROM rhel7:latest

#REPOSITORY SECTIONS  --add ur custom rpm to install packges
#ADD ./prerequisites/repos/* /etc/yum.repos.d/

# Fix per https://bugzilla.redhat.com/show_bug.cgi?id=1192200 
RUN yum -y install deltarpm yum-utils --disablerepo=*-eus-* --disablerepo=*-htb-* \
    --disablerepo=*-ha-* --disablerepo=*-rt-* --disablerepo=*-lb-* --disablerepo=*-rs-* --disablerepo=*-sap-*

RUN yum-config-manager --disable *-eus-* *-htb-* *-ha-* *-rt-* *-lb-* *-rs-* *-sap-* > /dev/null

# Update image
RUN yum update -y && yum install python -y && yum clean all

#Tidy Repositories
#RUN rm /etc/yum.repos.d/

#Add html files
ADD ./htdocs/* /var/www/htdocs/

#Expose Port
EXPOSE 8080

WORKDIR /var/www/htdocs

CMD python -m SimpleHTTPServer 8080